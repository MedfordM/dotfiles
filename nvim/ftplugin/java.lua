local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
local project_name = vim.fn.getcwd()
local workspace_dir = '/home/mike/.cache/jdtls/workspace/' .. project_name
local javaBin = '/home/mike/.sdkman/candidates/java/current/bin/java'
local lsp_status = require('lsp-status')
lsp_status.register_progress()
  lsp_status.config({
    indicator_errors = '',
    indicator_warnings = '',
    indicator_info = '',
    indicator_hint = '',
  })

local capabilities = require('cmp_nvim_lsp').default_capabilities()
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- UI
local finders = require 'telescope.finders'
local sorters = require 'telescope.sorters'
local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
  local opts = {}
  pickers.new(opts, {
    prompt_title    = prompt,
    finder          = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter          = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)

        cb(selection.value)
      end)

      return true
    end,
  }):find()
end

require('jdtls').start_or_attach({
  capabilities = capabilities,
  cmd = {
    javaBin,
    '-Dconfig.file=/home/mike/Source/darwin/localFiles/local.conf',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:/home/mike/Misc/lombok.jar',
    '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
    '-configuration', '/usr/share/java/jdtls/config_linux',
    '-data', workspace_dir
  },

  root_dir = vim.fn.getcwd(),
  settings = {
    java = {
      -- signatureHelp = {
      --   enabled = true,
      --   description = { enabled = true }
      -- },
      import = {
        maven = {
          enabled = true
        }
      },
      completion = {
        enabled = true,
        guessMethodArguments = true
      },
      configuration = {
        updateBuildConfiguration = { automatic = 'automatic' }
      },
      format = {
        comments = { enabled = false },
        enabled = true,
        insertSpaces = false,
        tabSize = 2,
        settings = {
          url = '/home/mike/Misc/eclipse-java-google-style.xml',
          profile = 'GoogleStyle'
        }
      },
      maven = {
        downloadSources = true
      },
      inlayHints = {
        parameterNames = {
          enabled = true
        }
      },
      referenceCodeLens = { enabled = true },
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
      }
    },

  },
  init_options = {
    bundles = {
      vim.fn.glob('/home/mike/Misc/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true)
    };
    extendedClientCapabilities = extendedClientCapabilities;
  },
  on_attach = function()
    vim.lsp.codelens.refresh()
    require('jdtls').setup_dap()
    require('jdtls.dap').setup_dap_main_class_configs()
    require('config.lspkeys')
    vim.lsp.inlay_hint.enable(0, true)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.java" },
      callback = function()
        local _, _ = pcall(vim.lsp.codelens.refresh)
      end,
    })

  end,
})
