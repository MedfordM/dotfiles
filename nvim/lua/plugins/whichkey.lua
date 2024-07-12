return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = {
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      operators = { gc = 'Comments' },
      key_labels = {
        ['<space>'] = 'SPACE',
        ['<cr>'] = 'ENTER',
        ['<tab>'] = 'TAB',
      },
      motions = {
        count = true
      },
      window = {
        border = 'single'
      },
      ignore_missing = true,
    },
    config = function(opts)
      WHICH_KEY = require('which-key')
      WHICH_KEY.setup(opts)
      WHICH_KEY.register({
        ['<leader>c'] = {
          name  = 'Code',
          d = {
            name  = 'Diagnostics',
          },
        },
      })
    end
  }
}
