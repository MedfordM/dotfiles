return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require('lspconfig')[server_name].setup({
            capabilities = capabilities
          })
        end,
        ['ts_ls'] = function()
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require('lspconfig').ts_ls.setup({
            capabilities = capabilities,
            settings = {
              completions = {
                completeFunctionCalls = true
              }
            }
          })
        end,
        ['lua_ls'] = function()
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require 'lspconfig'.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT',
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim', 'MiniPick', 'MiniBufremove', 'MiniExtras' },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("./*.lua", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
              },
            },
          }
        end,
    })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'lua_ls',
        -- 'jdtls'
      },
      automatic_installation = true
    },
  },
  {
    'neovim/nvim-lspconfig',
    init = function()
      require('config.lsp')
    end,
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.util.default_config = vim.tbl_extend( "force", lspconfig.util.default_config, {
        autostart = true,
        handlers = {
          ["window/logMessage"] = function(err, method, params, client_id)
            if params and params.type and params.type <= vim.lsp.protocol.MessageType.Log then
              vim.lsp.handlers["window/logMessage"](err, method, params, client_id)
            end
          end,
          ["window/showMessage"] = function(err, method, params, client_id)
            if params and params.type and params.type <= vim.lsp.protocol.MessageType.Warning.Error then
              vim.lsp.handlers["window/showMessage"](err, method, params, client_id)
            end
          end,
        }
      })
    end
  },
}
