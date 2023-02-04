local builtin = require('statuscol.builtin')
require('statuscol').setup({
    separator = '│',     -- separator between line number and buffer text ("│" or extra " " padding)
  thousands = false,     -- or line number thousands separator string ("." / ",")
  relculright = false,   -- whether to right-align the cursor line number with 'relativenumber' set
  lnumfunc = nil,        -- custom function called by ScLn(), should return a string
  reeval = false,        -- whether or not the string returned by lnumfunc should be reevaluated
  foldfunc = 'builtin',        -- nil for "%C" segment, "builtin" for builtin function, or custom function
  setopt = true,        -- whether to set the 'statuscolumn', providing builtin click actions
  order = 'NFsS',        -- order of the fold, sign, line number and separator segments
  ft_ignore = nil,       -- lua table with filetypes for which 'statuscolumn' will be unset
  -- Click actions
  Lnum                   = builtin.lnum_click,
  FoldClose              = builtin.foldclose_click,
  FoldOpen               = builtin.foldopen_click,
  FoldOther              = builtin.foldother_click,
  DapBreakpointRejected  = builtin.toggle_breakpoint,
  DapBreakpoint          = builtin.toggle_breakpoint,
  DapBreakpointCondition = builtin.toggle_breakpoint,
  DiagnosticSignError    = builtin.diagnostic_click,
  DiagnosticSignHint     = builtin.diagnostic_click,
  DiagnosticSignInfo     = builtin.diagnostic_click,
  DiagnosticSignWarn     = builtin.diagnostic_click,
  GitSignsTopdelete      = builtin.gitsigns_click,
  GitSignsUntracked      = builtin.gitsigns_click,
  GitSignsAdd            = builtin.gitsigns_click,
  GitSignsChangedelete   = builtin.gitsigns_click,
  GitSignsDelete         = builtin.gitsigns_click,
})


-- if _G.StatusColumn then
--   return
-- end
--
-- _G.StatusColumn = {
--   handler = {
--     fold = function()
--       local lnum = vim.fn.getmousepos().line
--
--       -- Only lines with a mark should be clickable
--       if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
--         return
--       end
--
--       local state
--       if vim.fn.foldclosed(lnum) == -1 then
--         state = "close"
--       else
--         state = "open"
--       end
--
--       vim.cmd.execute("'" .. lnum .. "fold" .. state .. "'")
--     end
--   },
--
--   display = {
--     line = function()
--       local lnum = tostring(vim.v.lnum)
--       return lnum
--     end,
--
--     fold = function()
--       if vim.v.wrap then
--         return ""
--       end
--
--       local lnum = vim.v.lnum
--       local icon = ""
--
--       -- Line isn't in folding range
--       if vim.fn.foldlevel(lnum) <= 0 then
--         return icon
--       end
--
--       -- Not the first line of folding range
--       if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
--         return icon
--       end
--
--       if vim.fn.foldclosed(lnum) == -1 then
--         icon = ""
--       else
--         icon = ""
--       end
--
--       return icon
--     end
--   },
--
--   sections = {
--     sign_column = {
--       [[%s]]
--     },
--     line_number = {
--       [[%=%{v:lua.StatusColumn.display.line()}]]
--     },
--     spacing     = {
--       [[ ]]
--     },
--     folds       = {
--       [[%#FoldColumn#]], -- HL
--       [[%@v:lua.StatusColumn.handler.fold@]],
--       [[%{v:lua.StatusColumn.display.fold()}]]
--     },
--     border      = {
--       [[%#StatusColumnBorder#]], -- HL
--       [[│]],
--     },
--     padding     = {
--       [[%#StatusColumnBuffer#]], -- HL
--       [[ ]],
--     },
--   },
--
--   build = function(tbl)
--     local statuscolumn = {}
--
--     for _, value in ipairs(tbl) do
--       if type(value) == "string" then
--         table.insert(statuscolumn, value)
--       elseif type(value) == "table" then
--         table.insert(statuscolumn, StatusColumn.build(value))
--       end
--     end
--
--     return table.concat(statuscolumn)
--   end,
--
--   set_window = function(value)
--     vim.defer_fn(function()
--       vim.api.nvim_win_set_option(vim.api.nvim_get_current_win(), "statuscolumn", value)
--     end, 1)
--   end
-- }
--
-- vim.opt.statuscolumn = StatusColumn.build({
--   StatusColumn.sections.line_number,
--   StatusColumn.sections.spacing,
--   StatusColumn.sections.folds,
--   StatusColumn.sections.border,
--   StatusColumn.sections.sign_column,
--   StatusColumn.sections.padding
-- })
