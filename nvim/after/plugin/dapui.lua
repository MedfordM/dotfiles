
require('dap.ext.vscode').load_launchjs()
local dap = require("dap")
local dapui = require("dapui")
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})
dapui.setup({
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
})

  local mappings = {
    ["<F5>"] = dap.continue,
    ["<M-right>"] = dap.step_over,
    ["<M-down>"] = dap.step_into,
    ["<M-up>"] = dap.step_out,
    ["<M-x>"] = dap.toggle_breakpoint,
    ["<M-t>"] = function()
      dapui.toggle({ reset = true })
    end,
    ["<M-w>"] = dapui.elements.watches.add,
    ["<M-m>"] = dapui.float_element,
    ["<M-v>"] = function()
      dapui.float_element("scopes")
    end,
    ["<M-r>"] = function()
      dapui.float_element("repl")
    end,
    ["<M-q>"] = dap.terminate,
  }
  for keys, mapping in pairs(mappings) do
    vim.api.nvim_set_keymap("n", keys, "", { callback = mapping, noremap = true })
  end
