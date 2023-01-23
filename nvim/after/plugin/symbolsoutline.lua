require("symbols-outline").setup({
  auto_close = true,
})

require('which-key').register({
  ['<leader>css'] = { vim.cmd.SymbolsOutline, 'Symbols' }
})
