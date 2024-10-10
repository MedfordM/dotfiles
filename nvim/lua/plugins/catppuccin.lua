return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
      flavour = 'auto',
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      custom_highlights = function(colors)
          return {
            NormalFloat = {bg=colors.none}
          }
      end,
      -- transparent_background = false,
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        -- loops = {},
        -- functions = {},
        -- keywords = {},
        -- strings = {},
        -- variables = {},
        -- numbers = {},
        -- booleans = {},
        -- properties = {},
        -- types = {},
        -- operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      integrations = {
        -- harpoon = true,
        barbar = true,
        mason = true,
        neotree = true,
        mini = {
          enabled = true,
          indentscope_color = "surface1"
        },
        lsp_trouble = true,
        which_key = true,
        markdown = true,
        gitsigns = true,
        cmp = true,
        -- noice = true,
        -- notify = true,
        -- dashboard = true,
        -- symbols_outline = true,
        -- lsp_saga = true,
        dap = {
          enabled = true,
          enable_ui = true
        },
        native_lsp = {
          enabled = true,
          signs = {
            errors = {'bold'}
          },
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
      }
    } end ,
    config = function(_, opts)
      require('catppuccin').setup(opts)
      --local tmux_theme = vim.system({'tmux', 'showenv', '-g', 'THEME'}, { text = true }):wait().stdout
      local theme = 'catppuccin-'
      local flavor = 'mocha'
      if nil ~= tmux_theme and string.len(tmux_theme) > 0 then
        flavor = string.sub(tmux_theme, 7, -2)
      end
      local colorscheme = theme .. flavor
      vim.cmd.colorscheme(colorscheme)
    end,
  }
}
