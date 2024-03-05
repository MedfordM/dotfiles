return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      integrations = {
        -- harpoon = true,
        mason = true,
        neotree = true,
        mini = true,
        treesitter = true,
        telescope = true,
        lsp_trouble = true,
        which_key = true,
        markdown = true,
        gitsigns = true,
        cmp = true,
        noice = true,
        notify = true,
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
        },
      }
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')
    end
  }
}
