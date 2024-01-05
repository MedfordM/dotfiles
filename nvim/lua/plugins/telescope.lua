return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {'<leader>f', function() require('telescope.builtin').find_files() end, desc = 'Find Files'},
      {'<leader>C', function() require('telescope.builtin').find_files({cwd = '/home/mike/.config/nvim'}) end, desc = 'Edit Neovim Conf'},
      {'<leader>g', function() require('telescope.builtin').live_grep() end, desc = 'Search Files'},
      {'<leader>s', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'File Symbols'},
      {'<leader>gc', function() require('telescope.builtin').git_bcommits() end, desc = 'File Commits'},
      {'gr', function() require('telescope.builtin').lsp_references({include_declaration = false}) end, desc = 'Incoming Calls'},
      {'gd', function() require('telescope.builtin').lsp_definitions() end, desc = 'Definition'},
      {'gi', function() require('telescope.builtin').lsp_implementations() end, desc = 'Implementations'},
    },
    opts = function()
      return {
        defaults = {
          path_display = {'tail'},
          sorting_strategy = 'ascending',
          dynamic_preview_title = true,
          scroll_strategy = 'limit',
          layout_strategy = 'flex',
          layout_config = {
            prompt_position = 'top',
          },
          mappings = {
            n = {
              [ 'p' ] = require('telescope.actions.layout').toggle_preview,
              [ 'v' ] = 'file_vsplit',
              [ 's' ] = 'file_split',
              [ 'n' ] = 'move_selection_next',
              [ 'e' ] = 'move_selection_previous'
            },
            i = {
              [ '<Tab>' ] = 'move_selection_next',
              [ '<S-Tab>' ] = 'move_selection_previous',
              ['<A-v>'] = 'file_vsplit',
              [ '<C-p>' ] = require('telescope.actions.layout').toggle_preview,
            }
          }
        },
        -- pickers = {
        --   ['lsp_document_symbols'] = {
        --     layout_strategy = 'cursor',
        --   },
        --   ['lsp_references'] = {
        --     layout_strategy = 'cursor',
        --   },
        --   ['lsp_definitions'] = {
        --     layout_strategy = 'cursor',
        --   },
        --   ['lsp_implementation'] = {
        --     layout_strategy = 'cursor'
        --   },
        -- },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)
    end
}
