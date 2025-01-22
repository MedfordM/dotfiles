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
      replace = {
        key = {
          { "<Space>", "SPACE" },
          { "<CR>", "ENTER" },
          { "<Tab>", "TAB" },
        }
      },
      win = {
        border = 'single'
      },
    },
    config = function(opts)
      local which_key = require('which-key')
      which_key.setup(opts)
      which_key.add({
        { "<leader>c", group = "Code" },
        { "<leader>cd", group = "Diagnostics" },
        { "<leader>b", group = "Buffer" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>gd", group = "Git Diff" },
        { "<leader>cs", group = "Swap" },
      })
    end
  }
}
