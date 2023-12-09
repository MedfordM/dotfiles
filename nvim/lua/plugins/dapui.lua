return {
  {
    'rcarriga/nvim-dap-ui',
    keys = {
      { '<leader>cD', function() require('dapui').toggle() end, desc = 'Toggle DapUI' },
    },
    dependencies = {
      {
        'mfussenegger/nvim-dap',
      }
    },
    init = function()
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
    end,
    opts = function()
      return {
          controls = {
            element = "repl",
            enabled = true,
            icons = {
              disconnect = "",
              pause = "",
              play = "",
              run_last = "",
              step_back = "",
              step_into = "",
              step_out = "",
              step_over = "",
              terminate = ""
            }
          },
          element_mappings = {},
          expand_lines = true,
          floating = {
            border = "single",
            mappings = {
              close = { "q", "<Esc>" }
            }
          },
          force_buffers = true,
          icons = {
            collapsed = "",
            current_frame = "",
            expanded = ""
          },
          layouts = { {
              elements = {
                {
                  id = "repl",
                  size = 0.01
                },
                {
                  id = "scopes",
                  size = 0.79
                },
                -- {
                --   id = "breakpoints",
                --   size = 0.25
                -- },
                {
                  id = "watches",
                  size = 0.19
                }
              },
              position = "left",
              size = 40
            }, {
              elements = {
                {
                  id = "console",
                  size = 1
                }
            },
              position = "bottom",
              size = 10
            } },
          mappings = {
            edit = "I",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t"
          },
          render = {
            indent = 1,
            max_value_lines = 100
          }
        }
    end,
    config = function(_, opts)
      -- require('dap.ext.vscode').load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      require('jdtls').setup_dap()
      require('jdtls.dap').setup_dap_main_class_configs()
      require'dap'.set_exception_breakpoints({'raised', 'uncaught'}, {breakMode = 'always'})

      local mappings = {
        ["<F5>"] = function() dap.continue() end,
        ["<M-right>"] = function() dap.step_over() end,
        ["<M-down>"] = function() dap.step_into() end,
        ["<M-up>"] = function() dap.step_out() end,
        ["<M-x>"] = function() dap.toggle_breakpoint() end,
        ["<F2>"] = function() dap.set_breakpoint(vim.fn.input('Condition: '), nil, nil) end,
        ["<M-t>"] = function() dapui.toggle({ reset = true }) end,
        ["<M-w>"] = function() dapui.elements.watches.add() end,
        ["<M-m>"] = function() dapui.float_element() end,
        ["<M-v>"] = function() dapui.float_element("scopes") end,
        ["<M-r>"] = function() dapui.float_element("repl") end,
        ["<M-q>"] = function() dap.terminate() end,
      }

      for keys, mapping in pairs(mappings) do
        vim.api.nvim_set_keymap("n", keys, "", { callback = mapping, noremap = true })
      end

      dapui.setup(opts)
    end
  }
}
