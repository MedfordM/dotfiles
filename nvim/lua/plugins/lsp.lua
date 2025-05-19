return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/nvim-cmp' },
    event = 'VeryLazy',
    init = function()
      require('config.lsp')
    end,
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', {
        capabilities = capabilities
      })
      vim.lsp.config('eslint', {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
      vim.lsp.enable('eslint')
      local configs = require 'lspconfig.configs'
      lspconfig.ts_ls.setup{}
      lspconfig.clangd.setup{}
      lspconfig.gopls.setup{}
    end
  },
}
