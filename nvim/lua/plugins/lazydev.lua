return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      integrations = {
        lspconfig = false,
        cmp = true,
        coq = false
      }
    },
  },
}
