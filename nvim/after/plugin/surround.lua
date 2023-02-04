require('nvim-surround').setup({
  keymaps = {
    insert = '<C-s>',
    normal = 'sa',
    normal_cur = 'ssl',
    visual = 's',
    delete = 'ds',
    change = 'cs',
  },
})

