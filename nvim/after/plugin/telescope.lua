local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    color_devicons = true,
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    prompt_prefix = '> ',
    selection_caret = '> ',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
        mirror = false
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        ['<Tab>']   = actions.move_selection_next,
        ['<S-Tab>'] = actions.move_selection_previous,
        ['<C-c>']   = actions.close,
        ['<Down>']  = actions.move_selection_next,
        ['<Up>']    = actions.move_selection_previous,
        ['<CR>']    = actions.select_default,
        ['<C-h>']   = actions.select_horizontal,
        ['<C-s>']   = actions.select_vertical,
        ['<C-t>']   = actions.select_tab,
        ['<C-k>']   = actions.preview_scrolling_up,
        ['<C-j>']   = actions.preview_scrolling_down,
        ['<C-q>']   = actions.send_to_qflist + actions.open_qflist,
        ['<M-q>']   = actions.send_selected_to_qflist + actions.open_qflist,
        ['<C-l>']   = actions.complete_tag,
        ['<C-/>']   = actions.which_key,
        ['<C-_>']   = actions.which_key,
        ['<C-w>']   = { '<c-s-w>', type = 'command' },
      },

      n = {
        ['<esc>']   = actions.close,
        ['<CR>']    = actions.select_default,
        ['<C-h>']   = actions.select_horizontal,
        ['<C-s>']   = actions.select_vertical,
        ['<C-t>']   = actions.select_tab,
        ['<Tab>']   = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<C-q>']   = actions.send_to_qflist + actions.open_qflist,
        ['j']       = actions.move_selection_next,
        ['k']       = actions.move_selection_previous,
        ['H']       = actions.move_to_top,
        ['M']       = actions.move_to_middle,
        ['L']       = actions.move_to_bottom,
        ['gg']      = actions.move_to_top,
        ['G']       = actions.move_to_bottom,
        ['<C-k>']   = actions.preview_scrolling_up,
        ['<C-j>']   = actions.preview_scrolling_down,
        ['?']       = actions.which_key,
      },
    }
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        layout_strategy = 'cursor'
      }
    },

    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension 'ui-select'
