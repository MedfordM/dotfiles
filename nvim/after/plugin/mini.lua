require('mini.pairs').setup()
require('mini.comment').setup()

require('mini.indentscope').setup({
  symbol = '│',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'alpha',
    'dashboard',
    'neo-tree',
    'Trouble',
    'lazy',
    'mason'
  },
  callback = function()
    vim.g.miniindentscope_disable = true
  end,
})
