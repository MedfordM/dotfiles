return {
  {
    'rcarriga/nvim-dap-ui',
    keys = {
      { '<leader>cD', function() require('dapui').toggle() end, desc = 'Toggle DapUI' },
    },
    dependencies = {
      {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio'
      }
    },
    init = function()
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
      vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
      vim.keymap.set('n', '<A-t>', function() require('dapui').toggle({ reset = true }) end)
      vim.keymap.set('n', '<A-w>', function() require('dapui').elements.watches.add() end)
      vim.keymap.set('n', '<A-b>', function() require('dapui').float_element('breakpoints') end)
      vim.keymap.set('n', '<A-v>', function() require('dapui').float_element('scopes') end)
      vim.keymap.set('n', '<A-r>', function() require('dapui').float_element('repl') end)
    end,
    opts = {
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
          layouts = {
            {
              elements = {
                {
                  id = "scopes",
                  size = 0.6
                },
                {
                  id = "breakpoints",
                  size = 0.1
                },
                {
                  id = 'stacks',
                  size = 0.1
                },
                {
                  id = "watches",
                  size = 0.1
                },
                {
                  id = 'repl',
                  size = 0.1
                },
              },
              position = "left",
              size = 40
            },
            {
              elements = {
                {
                  id = "console",
                  size = 1
                }
            },
              position = "bottom",
              size = 8
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
        },
    config = true
  }
}
