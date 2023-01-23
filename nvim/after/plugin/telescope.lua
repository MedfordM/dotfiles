local telescope = require('telescope.builtin')
-- local filePicker = require "telescope".extensions.file_browser.file_browser
local wk = require('which-key')

wk.register({
  ["<leader>f"] = { telescope.find_files, "Find file" },
  ["<leader>b"] = { telescope.buffers, "Pick buffer" },
  ["<leader>fg"] = { telescope.git_files, "Find git file" },
  ["<leader>F"] = { telescope.live_grep, "Grep files" },
})

wk.register({
  ["<leader>c"] = {
    name = "Code",
    ['gs'] = { telescope.lsp_document_symbols, "Goto Symbol" },
    ['gg'] = { telescope.lsp_definitions, "Goto definition"},
  }
})

require('telescope').setup {
  defaults = {
    color_devicons = true,
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    prompt_prefix = "> ",
    selection_caret = "> ",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
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
  },
  extensions = {
    file_browser = {
      hijack_netrw = true
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
-- require("telescope").load_extension "file_browser"
require('telescope').load_extension('fzf')


