return {
  {
    'williamboman/mason.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason').setup()
      require("mason-lspconfig").setup()
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup({})
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
          require 'lspconfig'.lua_ls.setup {
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
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lsp_config = require('lspconfig')
      lsp_config.util.default_config = vim.tbl_extend("force",lsp_config.util.default_config, {
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
      lsp_config.terraformls.setup({
        init_options = {
          cmd = { "terraform-ls", "serve" },
          filetypes = { "terraform", "terraform-vars" },
          -- root_dir = lsp_config.util.root_pattern(".terraform", ".git"),
          -- capabilities = capabilities
        },
        -- settings = {
        --   cmd = { "terraform-ls", "serve" },
        --   filetypes = { "terraform", "terraform-vars" },
        --   root_dir = lsp_config.util.root_pattern(".terraform", ".git"),
        --   -- root_dir = function(dirpath)
        --   --   vim.print(dirpath)
        --   --   return vim.fn.getcwd()
        --   -- end,
        --   capabilities = capabilities
        -- },
      })
      vim.api.nvim_create_autocmd({"BufWritePre"}, {
        pattern = {"*.tf", "*.tfvars"},
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end,
  },
}
