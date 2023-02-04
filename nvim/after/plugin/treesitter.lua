require('nvim-treesitter')
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "help",
    "java",
    "javascript",
    "typescript",
    "c",
    "lua",
    "rust",
    "vim",
    "regex",
    "bash",
    "markdown",
    "markdown_inline"
  },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
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
    },

    move = {
      enable = true,
      set_jumps = true,
    },

    select = {
      enable = true,
      lookahead = true,
      include_surrounding_whitespace = false,

      selection_modes = {
        ['@parameter.outer'] = 'v',
        ['@function.outer'] = 'V',
        ['@class.outer'] = '<c-v>',
      },
    },
  },
})

