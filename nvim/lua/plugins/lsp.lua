return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/nvim-cmp' },
    init = function()
      require('config.lsp')
    end,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          -- local cmpCapabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        -- config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
    end
  },
}
