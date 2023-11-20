-- local config = {
--    ui = {
--      kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
--      border = "rounded"
--  },
--  lightbulb = {
--    enable = false,
--    enable_in_insert = true,
--    sign = true,
--    sign_priority = 40,
--    virtual_text = true,
--  },
--  symbol_in_winbar = {
--    enable = false,
--    separator = " ",
--    ignore_patterns={},
--    hide_keyword = true,
--    show_file = false,
--    folder_level = 2,
--    respect_root = false,
--    color_mode = true,
--  },
-- }

-- require('lspsaga').setup(config)

-- local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
-- keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
-- keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the selected files
-- keymap("n", "<leader>cr", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
-- keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
-- keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
-- keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Go to type definition
-- keymap("n","gt", "<cmd>Lspsaga goto_type_definition<CR>")


-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
-- keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show buffer diagnostics
-- keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Show workspace diagnostics
-- keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

-- Show cursor diagnostics
-- keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
-- keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
-- keymap("n", "[E", function()
--   require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end)
-- keymap("n", "]E", function()
--   require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end)

-- Toggle outline
-- keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
-- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- Call hierarchy
--keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
--keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
