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
