vim.g.mapleader = " "

local wk = require("which-key")

wk.register({
  ["<leader>w"] = {
    name = "Window Mode",
    h = { "<C-w>h", "Focus window left" },
    j = { "<C-w>j", "Focus window below" },
    k = { "<C-w>k", "Focus window above" },
    l = { "<C-w>l", "Focus window right" },
    s = { "<C-w>s", "Split window horizontally" },
    v = { "<C-w>v", "Split window vertically" },
  }
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", "<C-BS>", "<C-w>")

local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

wk.register({
  ["<leader>pf"] = { vim.cmd.Neotree, "File tree" },
  ["<leader>cp"] = { name = "Peek" },
})







