return {
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {}
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {'<leader>q', function() MiniBufremove.delete() end, desc = 'which_key_ignore'}
    },
    config = function()
      require('mini.bufremove').setup()
    end
  },
  {
    'echasnovski/mini.surround',
    event = 'BufReadPre',
    opts = {
      add = "sa", -- Add surrounding in Normal and Visual modes
      replace = "sr", -- Replace surrounding
      delete = "sd", -- Delete surrounding
      -- find = "sf", -- Find surrounding (to the right)
      -- find_left = "sF", -- Find surrounding (to the left)
      -- highlight = "sh", -- Highlight surrounding
    },
    config = function(_, opts)
      -- Populate the keys based on the user's options
      require('mini.surround').setup(opts)
      -- local mappings = {
      --   { opts.add, desc = "Add surrounding", mode = { "n", "v" } },
      --   { opts.delete, desc = "Delete surrounding" },
      --   { opts.find, desc = "Find right surrounding" },
      --   { opts.find_left, desc = "Find left surrounding" },
      --   { opts.highlight, desc = "Highlight surrounding" },
      --   { opts.replace, desc = "Replace surrounding" },
      --   { opts.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      -- }
      -- mappings = vim.tbl_filter(function(m)
      --   return m[1] and #m[1] > 0
      -- end, mappings)
      -- return vim.list_extend(mappings, keys)
    end,
  },

  {
    'echasnovski/mini.cursorword',
    event = 'BufReadPre',
    opts = {},
    config = function()
      require('mini.cursorword').setup({delay=200})
      vim.api.nvim_set_hl(0, 'MiniCursorword', {bg = require('catppuccin.palettes.'..require('catppuccin').flavour).overlay0})
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'DiffviewFiles',
          'DressingSelect',
        },
        callback = function()
          vim.b.minicursorword_disable = true
        end,
      })
    end
  },

  {
    'echasnovski/mini.indentscope',
    event = 'BufReadPre',
    opts = {
      symbol = '│',
      options = { try_as_border = true }
    },
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'dashboard',
          'neo-tree',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end
  }
}
