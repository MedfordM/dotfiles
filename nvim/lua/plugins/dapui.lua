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
            element = "console",
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
                  id = "scopes",
                  size = 0.8
                },
                -- {
                --   id = "breakpoints",
                --   size = 0.25
                -- },
                {
                  id = "watches",
                  size = 0.2
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
              size = 15
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
      local dapui = require("dapui")
      local mappings = {
        ["<M-t>"] = function() dapui.toggle({ reset = true }) end,
        ["<M-w>"] = function() dapui.elements.watches.add() end,
        ["<M-b>"] = function() dapui.float_element("breakpoints") end,
        ["<M-v>"] = function() dapui.float_element("scopes") end,
        ["<M-r>"] = function() dapui.float_element("repl") end,
      }
      for keys, mapping in pairs(mappings) do
        vim.api.nvim_set_keymap("n", keys, "", { callback = mapping, noremap = true })
      end
      dapui.setup(opts)
    end
  }
}
