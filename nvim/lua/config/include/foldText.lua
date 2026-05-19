local ts = vim.treesitter

--- Get the named Tree-sitter node at the first non-whitespace col of a line
---@param lnum integer 1-indexed
---@return TSNode|nil
local function get_fold_node(lnum)
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = ts.get_parser(bufnr, "java")
  if not parser then return nil end

  local tree = parser:parse()[1]
  if not tree then return nil end

  local row = lnum - 1
  local line = vim.fn.getline(lnum)
  local col = #line:match("^%s*")

  return tree:root():named_descendant_for_range(row, col, row, col)
end

--- Walk up ancestors to find the first node matching one of the given types
---@param node TSNode
---@param types string[]
---@return TSNode|nil
local function find_ancestor(node, types)
  local type_set = {}
  for _, t in ipairs(types) do type_set[t] = true end

  local cur = node
  while cur do
    if type_set[cur:type()] then return cur end
    cur = cur:parent()
  end
end

--- Extract raw text of a node's named field (first child only)
---@param node TSNode
---@param field string
---@param bufnr integer
---@return string|nil
local function field_text(node, field, bufnr)
  local children = node:field(field)
  if children and children[1] then
    return ts.get_node_text(children[1], bufnr)
  end
end

--- Collect all formal_parameter nodes and format them as "Type name" pairs
--- Optionally truncates long param lists.
---@param params_node TSNode
---@param bufnr integer
---@param max_params integer?
---@return string
local function format_params(params_node, bufnr, max_params)
  max_params = max_params or 3
  local parts = {}

  for child in params_node:iter_children() do
    local ctype = child:type()

    if ctype == "formal_parameter" or ctype == "spread_parameter" then
      -- Each formal_parameter has a `type` field and a `name` field (identifier)
      local ptype = field_text(child, "type", bufnr) or "?"
      local pname = field_text(child, "name", bufnr) or "?"
      table.insert(parts, ptype .. " " .. pname)

    elseif ctype == "receiver_parameter" then
      -- Rare but valid: `MyClass this` receiver param in inner classes
      local ptype = field_text(child, "type", bufnr) or "?"
      table.insert(parts, ptype .. " this")
    end
  end

  if #parts > max_params then
    local shown = {}
    for i = 1, max_params do shown[i] = parts[i] end
    return table.concat(shown, ", ") .. (", +%d more"):format(#parts - max_params)
  end

  return table.concat(parts, ", ")
end

--- Format a method_declaration node into a concise signature string
---@param node TSNode
---@param bufnr integer
---@return string
local function format_method(node, bufnr)
  -- Modifiers: public, private, static, final, synchronized, abstract, etc.
  local modifiers = {}
  for child in node:iter_children() do
    if child:type() == "modifiers" then
      -- Each modifier keyword is a direct child of the modifiers node
      for mod in child:iter_children() do
        local mtype = mod:type()
        -- Skip annotations — they clutter the fold line
        if mtype ~= "annotation" and mtype ~= "marker_annotation" then
          table.insert(modifiers, ts.get_node_text(mod, bufnr))
        end
      end
      break
    end
  end

  local return_type = field_text(node, "type", bufnr) or "void"
  local name        = field_text(node, "name", bufnr) or "?"

  local params_node = node:field("parameters")[1]
  local params_str  = params_node and format_params(params_node, bufnr) or ""

  -- Throws clause: format as "throws ExA, ExB"
  local throws_parts = {}
  for child in node:iter_children() do
    if child:type() == "throws" then
      for ex in child:iter_children() do
        local etype = ex:type()
        if etype ~= "throws" and etype ~= "," then   -- skip keyword & punctuation
          table.insert(throws_parts, ts.get_node_text(ex, bufnr))
        end
      end
    end
  end
  local throws_str = #throws_parts > 0
      and " throws " .. table.concat(throws_parts, ", ")
      or ""

  local mod_str = #modifiers > 0 and table.concat(modifiers, " ") .. " " or ""
  return ("%s%s %s(%s)%s"):format(mod_str, return_type, name, params_str, throws_str)
end

--- Format a constructor_declaration node
---@param node TSNode
---@param bufnr integer
---@return string
local function format_constructor(node, bufnr)
  local modifiers = {}
  for child in node:iter_children() do
    if child:type() == "modifiers" then
      for mod in child:iter_children() do
        local mtype = mod:type()
        if mtype ~= "annotation" and mtype ~= "marker_annotation" then
          table.insert(modifiers, ts.get_node_text(mod, bufnr))
        end
      end
      break
    end
  end

  local name        = field_text(node, "name", bufnr) or "?"
  local params_node = node:field("parameters")[1]
  local params_str  = params_node and format_params(params_node, bufnr) or ""

  local throws_parts = {}
  for child in node:iter_children() do
    if child:type() == "throws" then
      for ex in child:iter_children() do
        local etype = ex:type()
        if etype ~= "throws" and etype ~= "," then
          table.insert(throws_parts, ts.get_node_text(ex, bufnr))
        end
      end
    end
  end
  local throws_str = #throws_parts > 0
      and " throws " .. table.concat(throws_parts, ", ")
      or ""

  local mod_str = #modifiers > 0 and table.concat(modifiers, " ") .. " " or ""
  return ("%s%s(%s)%s"):format(mod_str, name, params_str, throws_str)
end

--- Format a class/interface/enum/record declaration
---@param node TSNode
---@param bufnr integer
---@return string
local function format_type_decl(node, bufnr)
  local ntype = node:type()

  local kind = ({
    class_declaration     = "class",
    interface_declaration = "interface",
    enum_declaration      = "enum",
    record_declaration    = "record",
    annotation_type_declaration = "@interface",
  })[ntype] or "class"

  local name = field_text(node, "name", bufnr) or "?"

  -- Generic type parameters: <T extends Foo, U>
  local type_params = field_text(node, "type_parameters", bufnr) or ""

  -- superclass
  local superclass = ""
  local sc_node = node:field("superclass")[1]
  if sc_node then
    superclass = " extends " .. ts.get_node_text(sc_node, bufnr)
  end

  -- interfaces
  local iface_parts = {}
  local ifaces = node:field("interfaces")[1]
  if ifaces then
    for child in ifaces:iter_children() do
      if child:type() ~= "," and child:type() ~= "implements" then
        table.insert(iface_parts, ts.get_node_text(child, bufnr))
      end
    end
  end
  local iface_str = #iface_parts > 0 and " implements " .. table.concat(iface_parts, ", ") or ""

  return ("%s %s%s%s%s"):format(kind, name, type_params, superclass, iface_str)
end

--- Dispatch to the right formatter based on node type
---@param node TSNode
---@param bufnr integer
---@return string
local function node_label(node, bufnr)
  local ntype = node:type()

  if ntype == "method_declaration" then
    return format_method(node, bufnr)

  elseif ntype == "constructor_declaration" then
    return format_constructor(node, bufnr)

  elseif ntype == "class_declaration"
      or ntype == "interface_declaration"
      or ntype == "enum_declaration"
      or ntype == "record_declaration"
      or ntype == "annotation_type_declaration" then
    return format_type_decl(node, bufnr)

  elseif ntype == "static_initializer" then
    return "static { ... }"

  elseif ntype == "instance_initializer" then
    return "{ ... }  // instance initializer"

  elseif ntype == "lambda_expression" then
    -- Show param list of the lambda only
    local params = node:field("parameters")[1]
    local p = params and ts.get_node_text(params, bufnr) or "()"
    return ("(%s) -> ..."):format(p:gsub("^%((.-)%)$", "%1"))

  elseif ntype == "import_declaration" then
    return " [Imports] "

  else
    -- Generic fallback: trimmed first line
    return vim.fn.getline(vim.v.foldstart):match("^%s*(.-)%s*$")
  end
end

--- Build a lookup table of {start_row -> end_row} for each contiguous
--- block of import_declaration nodes in the file.
---@param bufnr integer
---@return table<integer, integer>  keys and values are 0-indexed rows
local function get_import_blocks(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "java")
  if not parser then return {} end
  local tree = parser:parse()[1]
  if not tree then return {} end

  -- Collect all import node row ranges, sorted
  local imports = {}
  for child in tree:root():iter_children() do
    if child:type() == "import_declaration" then
      local sr = child:start()
      local er = select(1, child:end_())
      table.insert(imports, { sr = sr, er = er })
    end
  end

  if #imports == 0 then return {} end

  -- Merge consecutive imports into blocks
  -- "consecutive" = next import starts on the very next line
  local blocks = {}
  local block_start = imports[1].sr
  local block_end   = imports[1].er

  for i = 2, #imports do
    if imports[i].sr == block_end + 1 then
      block_end = imports[i].er          -- extend current block
    else
      blocks[block_start] = block_end    -- save completed block
      block_start = imports[i].sr
      block_end   = imports[i].er
    end
  end
  blocks[block_start] = block_end        -- save final block

  return blocks
end



--- Global foldtext function registered for Java buffers
--- Interesting node types to search for when walking ancestors
local INTERESTING = {
  "method_declaration",
  "constructor_declaration",
  "class_declaration",
  "interface_declaration",
  "enum_declaration",
  "record_declaration",
  "annotation_type_declaration",
  "static_initializer",
  "instance_initializer",
  "lambda_expression",
  "import_declaration"
}

function JavaFoldText()
  local bufnr = vim.api.nvim_get_current_buf()
  local start  = vim.v.foldstart
  local finish = vim.v.foldend
  local lines  = finish - start + 1

  local node  = get_fold_node(start)
  local label

  if node then
    local target = find_ancestor(node, INTERESTING)
    label = target and node_label(target, bufnr)
    or vim.fn.getline(start):match("^%s*(.-)%s*$")
  else
    label = vim.fn.getline(start):match("^%s*(.-)%s*$")
  end

  local indent    = vim.fn.getline(start):match("^%s*")
  local count_str = ("  ↙ %d lines"):format(lines)
  local win_width = vim.api.nvim_win_get_width(0)
  local padding   = math.max(1, win_width - #indent - #label - #count_str - 10)

  return indent .. label .. string.rep(" ", padding) .. count_str
end
