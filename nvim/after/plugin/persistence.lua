require('persistence').setup({
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
  options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
})

local wk = require('which-key')

wk.register({
  ['<leader>s'] = {
    name = 'Session',
    r = { function() require('persistence').load() end, 'Restore' },
    l = { function() require('persistence').load({last=true}) end, 'Restore latest' }
  }
})

