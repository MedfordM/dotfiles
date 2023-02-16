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

local animate = require('mini.animate')
require('mini.animate').setup({
  cursor = {
    timing = animate.gen_timing.linear({ duration = 50, unit = 'total' }),
  },
  scroll = {
    -- Animate equally but with 120 maximum steps instead of default 60
    subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
  }
})
