-- function _G.put(...)
--   local objects = {}
--   for i = 1, select('#', ...) do
--     local v = select(i, ...)
--     table.insert(objects, vim.inspect(v))
--   end
--
--   print(table.concat(objects, '\n'))
--   return ...
-- end
--
-- function _G.put_text(...)
--   local objects = {}
--   for i = 1, select('#', ...) do
--     local v = select(i, ...)
--     table.insert(objects, vim.inspect(v))
--   end
--
--   local lines = table.concat(objects, '\n')
--   file = io.open("dump.txt", "a")
--   file:write(lines)
--   file:close()
--   return ...
-- end

function SetColors(theme)
  local notify_original = vim.notify
  vim.notify = function() end
  require('lazy').reload({plugins = {'catppuccin'}})
  vim.cmd.colorscheme('catppuccin-'..theme)
  require('lazy').reload({plugins = {'mini.cursorword'}})
  vim.notify = notify_original
end

function PreviewLocation(location, opts)
  -- local context = opts.context or 0
  -- location may be LocationLink or Location (more useful for the former)
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end
  -- local range = location.targetRange or location.range
  -- local start_line = range.start.line
  -- start_line = start_line > context and start_line - context or 0
  -- local end_line = range['end'].line + 1 + context
  local start_line = 1
  local end_line = vim.api.nvim_buf_line_count(bufnr)
  local contents = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
  local syntax = vim.bo[bufnr].syntax
  if syntax == '' then
    -- When no syntax is set, we use filetype as fallback. This might not result
    -- in a valid syntax definition.
    -- An empty syntax is more common now with TreeSitter, since TS disables syntax.
    syntax = vim.bo[bufnr].filetype
  end
  opts = opts or {}
  opts.focus_id = 'location'
  return vim.lsp.util.open_floating_preview(contents, syntax, opts)
end

function Root_markers_with_field(root_files, new_names, field, fname)
  local path = vim.fn.fnamemodify(fname, ':h')
  local found = vim.fs.find(new_names, { path = path, upward = true })

  for _, f in ipairs(found or {}) do
    -- Match the given `field`.
    for line in io.lines(f) do
      if line:find(field) then
        root_files[#root_files + 1] = vim.fs.basename(f)
        break
      end
    end
  end

  return root_files
end

function Insert_package_json(root_files, field, fname)
  return Root_markers_with_field(root_files, { 'package.json', 'package.json5' }, field, fname)
end
