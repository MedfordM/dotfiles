return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      integrations = {
        lspconfig = true,
        cmp = true,
        coq = false
      }
    },
  },
}
