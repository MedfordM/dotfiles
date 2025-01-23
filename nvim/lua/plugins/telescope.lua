return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {'<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Search for files'},
      {'<leader>fC', function() require('telescope.builtin').find_files({cwd = '/home/mike/.config/nvim'}) end, desc = 'Edit Neovim Conf'},
      {'<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Search in files'},
      {'<leader>m', function() require('telescope.builtin').marks() end, desc = 'Show marks'},
      {'<leader>cs', function() require('telescope.builtin').lsp_document_symbols({symbols = 'method', symbol_width = 40}) end, desc = 'File Symbols'},
      {'gr', function() require('telescope.builtin').lsp_incoming_calls({
          initial_mode = 'normal',
          prompt_title = 'References',
          path_display = {'tail'},
          layout_config = {
            height = 20,
            width = 200
          },
          layout_strategy = "cursor",
          results_title = false,
          sorting_strategy = "ascending",
          theme = "cursor",
          include_declaration = false,
          include_current_line = false,
          file_encoding = 'utf-8'
      }) end, desc = 'References'},
      {'<leader>T', function() require('telescope.builtin').resume() end, desc = 'Resume telescope search'},
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
              [ '<A-v>' ] = 'file_vsplit',
              [ '<C-p>' ] = require('telescope.actions.layout').toggle_preview,
            }
          }
        },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)
    end
}
