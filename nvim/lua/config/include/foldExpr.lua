function JavaFoldExpr()
  local lnum = vim.v.lnum
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr, "java")
  if not parser then return "0" end

  local tree = parser:parse()[1]
  if not tree then return "0" end

  local row = lnum - 1
  local line = vim.fn.getline(lnum)
  local col = #line:match("^%s*")

  local node = tree:root():named_descendant_for_range(row, col, row, col)

  -- Walk up to find if this line belongs to a method/constructor
  local cur = node
  while cur do
    local t = cur:type()
    if t == "method_declaration" or t == "constructor_declaration" or t == 'import_declaration' then
      local start_row = cur:start()
      local end_row   = select(1, cur:end_())
      if row == start_row then return "1" end   -- fold opens here
      if row == end_row   then return "<1" end  -- fold closes here
      return "1"                                -- interior lines
    end
    -- Stop climbing if we hit a type boundary — don't fold the class body itself
    if t == "class_declaration"
      or t == "interface_declaration"
      or t == "enum_declaration"
      or t == "record_declaration" then
      break
    end
    cur = cur:parent()
  end

  return "0"  -- not part of any method
end
