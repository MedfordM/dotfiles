require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls' },
  automatic_installation = true
})
require("lspconfig")

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      require('config.lspkeys'),
    }
  end,
  ['tsserver'] = function()
    require('lspconfig').tsserver.setup({
      settings = {
        completions = {
          completeFunctionCalls = true
        }
      }
    })
  end,
  ['lua_ls'] = function()
    local lsp_status = require('lsp-status')
    lsp_status.register_progress()
    require 'lspconfig'.lua_ls.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end,
}
