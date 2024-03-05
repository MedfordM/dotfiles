return {
  {
    'williamboman/mason.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason').setup()
      require("mason-lspconfig").setup()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,
        ['terraformls'] = function()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          require('lspconfig').terraformls.setup({
            filetypes = {"terraform", "terraform-vars", "tf"},
            root_dir = function(dirpath)
              return vim.fn.getcwd()
            end,
            capabilities = capabilities
          })

          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = {'*.tf'},
            callback = function() vim.cmd('%!terraform fmt -') end
          })
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
        -- ['jdtls'] = function() end,
        ['lua_ls'] = function()
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
      }
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'lua_ls' },
      automatic_installation = true
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig')
    end
  },
}
