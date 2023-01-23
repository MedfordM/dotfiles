local treesitter = require('nvim-treesitter')
require 'nvim-treesitter.configs'.setup({
  -- A list of parser names, or "all"
  ensure_installed = { "help", "java", "javascript", "typescript", "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },

  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'rounded',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>cpf"] = {query = "@function.outer", desc = 'Function'},
        ["<leader>cpc"] = {query = "@class.outer", desc = 'Class'},
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = {query = "@function.outer", desc = "Next function"},
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = { query = "@function.outer", desc = "End of function"},
        ["]C"] = { query = "@class.outer", desc = "End of class"},
      },
      goto_previous_start = {
        ["[m"] = { query = "@function.outer", desc = 'Previous function'},
        ["[c"] = { query = "@class.outer", desc = 'Previous class'},
      },
      goto_previous_end = {
        ["[M"] = { query = "@function.outer", desc = 'Prev func end'},
        ["[C"] = { query = "@class.outer", desc = 'Prev class end'},
      },
    },

    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      include_surrounding_whitespace = false,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["f"] = "@function.outer",
        ["c"] = "@class.outer",
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
    },
  },
})

