local project_name = vim.fn.getcwd()
local workspace_dir = '/home/mike/.cache/jdtls/workspace/' .. project_name
local javaBin = '/home/mike/.sdkman/candidates/java/current/bin/java'

return
  {
    {
      'mfussenegger/nvim-jdtls',
      ft = 'java',
      dependencies = {
        {
          'mfussenegger/nvim-dap',
        }
      },
      opts = function()
        return {
          cmd = {
            javaBin,
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-javaagent:/home/mike/.local/share/lombok.jar',
            '-jar', vim.fn.glob('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar', true),
            '-configuration', '/usr/share/java/jdtls/config_linux',
            '-data', workspace_dir
          },

          root_dir = vim.fn.getcwd(),

          settings = {
            java = {
              signatureHelp = {
                enabled = true,
                description = { enabled = true }
              },
              import = {
                maven = {
                  enabled = true
                }
              },
              contentProvider = { preferred = 'fernflower' },
              completion = {
                enabled = true,
                guessMethodArguments = true,
                favoriteStaticMember = {
                  "java.util.*"
                }
              },
              configuration = {
                updateBuildConfiguration = { automatic = 'automatic' }
              },
              maven = {
                downloadSources = true
              },
              inlayHints = {
                parameterNames = {
                  enabled = true
                }
              },
              errors = {
                incompleteClasspath = 'ignore'
              },
              referencesCodeLens = { enabled = true },
              implementationsCodeLens = { enabled = true },
              references = {
                includeAccessors = true,
                includeDecompiledSources = true
              },
              autobuild = { enabled = true },
              symbols = {
                includeSourceMethodDeclarations = true
              },
              codeGeneration = {
                generateComments = true,
                hashCodeEquals = {
                  useInstanceof = true
                },
                useBlocks = true,
                toString = {
                  template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}'
                }
              },
            },
          },
          init_options = {
            bundles = {
              vim.fn.glob('/home/mike/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true)
            };
          },
        }
      end,
      config = function(_, opts)
        opts['on_attach'] = function(client, bufnr)
          require('config.lspkeys')
          local _, _ = pcall(vim.lsp.codelens.refresh)
          require("jdtls").setup_dap({ hotcodereplace = "auto" })
          vim.lsp.inlay_hint.enable(0, true)
          -- vim.lsp.codelens.display(vim.lsp.codelens.get(vim.api.nvim_get_current_buf()), vim.api.nvim_get_current_buf(), 1)
          local _, _ = pcall(require, "jdtls.dap")
          -- if status_ok then
          --   jdtls_dap.setup_dap_main_class_configs()
          -- end
        end

        local startJdtls = function(config)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          local cmpCapabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
          capabilities.textDocument.completion.completionItem = cmpCapabilities.textDocument.completion.completionItem
          config.capabilities = capabilities
          config.init_options.extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
          config.init_options.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
          require('jdtls').start_or_attach(config)
        end

        startJdtls(opts)

        vim.api.nvim_create_autocmd("FileType", {
          pattern = 'java',
          callback = function() startJdtls(opts) end
        })
      end,
    }
  }
