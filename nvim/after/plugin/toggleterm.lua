require("toggleterm").setup({
  open_mapping = '<leader>t',
  hide_numbers = true,
  autochdir = false,
  start_in_insert = true,
  direction = 'float',
  insert_mappings = false,
  terminal_mappings = true,
  persist_size = false,
  persist_mode = false,
  shell = '/bin/zsh',
  highlights = {
    Normal = {
      guibg = '#1E1E2E',
    },
    NormalFloat = {
      guifg = '#CDD6F4',
      guibg = '#1E1E2E',
    },
    FloatBorder = {
      guifg = '#CDD6F4',
    },
  },
  shade_terminals = false,
  float_opts = {
    border = 'curved',
    winblend = 3,
    height = 40,
    width = 150
  },
})

local wk = require('which-key')
wk.register({
  ['<leader>t'] = { '<cmd>ToggleTerm<CR>', 'Terminal' }
})

vim.keymap.set('t', '<esc>', '<cmd>ToggleTerm<CR>', {})

