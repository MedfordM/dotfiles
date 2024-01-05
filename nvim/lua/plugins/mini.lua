return {
  -- {
  --   'echasnovski/mini.pick',
  --   cmd = 'Pick',
  --   keys = {
  --     { '<leader>C', function() MiniPick.registry.nvimConf() end, desc = 'Edit Neovim Conf' },
  --     { '<leader>f', function() MiniPick.registry.files() end, desc = 'Find File' },
  --     { '<leader>g', function() MiniPick.registry.grep_live() end, desc = 'Search Files' },
  --   },
  --   opts = {
  --         -- Delays (in ms; should be at least 1)
  --         delay = {
  --           -- Delay between forcing asynchronous behavior
  --           async = 10,
  --
  --           -- Delay between computation start and visual feedback about it
  --           busy = 50,
  --         },
  --
  --         -- Keys for performing actions. See `:h MiniPick-actions`.
  --         mappings = {
  --           caret_left  = '<Left>',
  --           caret_right = '<Right>',
  --
  --           choose            = '<CR>',
  --           choose_in_split   = '<C-s>',
  --           choose_in_tabpage = '<C-t>',
  --           choose_in_vsplit  = '<C-CR>',
  --           choose_marked     = '<M-CR>',
  --
  --           delete_char       = '<BS>',
  --           delete_char_right = '<Del>',
  --           delete_left       = '<C-u>',
  --           delete_word       = '<C-w>',
  --
  --           move_up    = '<Up>',
  --           move_down  = '<Down>',
  --           move_start = '<Home>',
  --
  --           stop = '<Esc>',
  --
  --           toggle_info    = '<S-Tab>',
  --           toggle_preview = '<Tab>',
  --         },
  --
  --         -- General options
  --         options = {
  --           -- Whether to show content from bottom to top
  --           content_from_bottom = false,
  --
  --           -- Whether to cache matches (more speed and memory on repeated prompts)
  --           use_cache = true,
  --         },
  --
  --         -- Source definition. See `:h MiniPick-source`.
  --         source = {
  --           items = nil,
  --           name  = nil,
  --           cwd   = nil,
  --
  --           match   = nil,
  --           show = nil,
  --           -- show = function(buf_id, items_arr, query)
  --           --           local lines = vim.tbl_map(function(x) return 'Item: ' .. x end, items_arr)
  --           --           vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  --           --        end,
  --           preview = nil,
  --
  --           choose        = nil,
  --           choose_marked = nil,
  --         },
  --
  --         -- Window related options
  --         window = {
  --           -- Float window config (table or callable returning it)
  --           config = nil,
  --         },
  --
  --   },
  --   config = function(_, opts)
  --     local miniPick = require('mini.pick')
  --     miniPick.setup(opts)
  --     vim.ui.select = miniPick.ui_select
  --     miniPick.registry.nvimConf = function(local_opts)
  --       local configOpts = { source = { cwd = '/home/mike/.config/nvim', name = 'Neovim Config'} }
  --       return miniPick.builtin.files(local_opts, configOpts)
  --     end
  --   end
  -- },

  -- {
  --   'echasnovski/mini.extra',
  --   keys = {
  --     { 'gr', function() require('mini.extra').pickers.lsp({scope = "references"}) end, desc = 'References' },
  --     { 'gi', function() require('mini.extra').pickers.lsp({scope = "implementation"}) end, desc ='Implementations' },
  --     { 'gd', function() require('mini.extra').pickers.lsp({scope = "definition"}) end, desc ='Definition' },
  --     { 'gt', function() require('mini.extra').pickers.lsp({scope = "type_definition"}) end, desc ='Type Defn.' },
  --     { 'gs', function() require('mini.extra').pickers.lsp({scope = "document_symbol"}) end, desc ='Symbols' },
  --   }
  -- },

  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {}
  },

  {
    'echasnovski/mini.comment',
    event = 'BufReadPre',
    opts = {}
  },

  {
    'echasnovski/mini.bufremove',
    keys = {
      {'<leader>q', function() MiniBufremove.delete() end, desc = 'Close Buffer'}
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
      delete = "sd", -- Delete surrounding
      find = "sf", -- Find surrounding (to the right)
      find_left = "sF", -- Find surrounding (to the left)
      highlight = "sh", -- Highlight surrounding
      replace = "sr", -- Replace surrounding
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
      require('mini.cursorword').setup()
      vim.api.nvim_set_hl(0, 'MiniCursorword', {bg = require('catppuccin.palettes.frappe').surface2})
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
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
