local wk = require('which-key')

require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

wk.register({
  ["<leader>d"] = {
    name = "Diagnostics",
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "List document issues" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "List workspace issues" },
    c = { vim.cmd.TroubleClose, "Close diagnostics" }
  }
})
