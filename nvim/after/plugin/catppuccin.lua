require("catppuccin").setup({
  integrations = {
    illuminate = true,
    harpoon = true,
    mason = true,
    neotree = true,
    mini = true,
    treesitter = true,
    telescope = true,
    lsp_trouble = true,
    which_key = true,
    gitsigns = true,
    cmp = true,
    noice = true,
    notify = true,
    dashboard = true,
    symbols_outline = true,
    bufferline = true,
    navic = {
      enabled = false,
      custom_bg = "NONE",
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  }
})
