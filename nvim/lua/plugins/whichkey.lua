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
      local wk = require('which-key')
      wk.setup(opts)
      wk.register({}, opts)

      wk.register({
        ['<leader>'] = {
          b = {
            name = 'Buffer',
            a  = { '<cmd>BufferLineGoToBuffer 1<CR>', '1' },
            r  = { '<cmd>BufferLineGoToBuffer 2<CR>', '2' },
            s  = { '<cmd>BufferLineGoToBuffer 3<CR>', '3' },
            t  = { '<cmd>BufferLineGoToBuffer 4<CR>', '4' },
            h  = { '<cmd>BufferLineGoToBuffer 5<CR>', '5' },
            n  = { '<cmd>BufferLineGoToBuffer 6<CR>', '6' },
            e  = { '<cmd>BufferLineGoToBuffer 7<CR>', '7' },
            i  = { '<cmd>BufferLineGoToBuffer 8<CR>', '8' },
          },
          u  = { '<cmd>UndotreeToggle<CR>', 'Undo Tree' },
        }
      })
    end
  }
}
