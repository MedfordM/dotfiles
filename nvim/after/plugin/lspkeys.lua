local wk = require('which-key')

wk.register({
  ["<leader>cg"] = { name = "Goto" },
  ["<leader>cgr"] = { vim.lsp.buf.references, "References" },
  ["<leader>cgd"] = { vim.lsp.buf.definition, "Definition" },
  ["<leader>cr"] = { vim.lsp.buf.rename, "Rename symbol" },
  ["<leader>ca"] = { vim.lsp.buf.code_action, "Quick action" },
  ["<leader>cd"] = { name = "Diagnostics" },
  ["<leader>cdd"] = { vim.diagnostic.open_float, "Diagnostic info" },
  ["<leader>cd]"] = { vim.diagnostic.goto_next, "Next diagnostic" },
  ["<leader>cd["] = { vim.diagnostic.goto_prev, "Prev diagnostic" },
  ["<leader>cf"] = { vim.lsp.buf.format, "Format" },
  ["K"] = { vim.lsp.buf.hover, "Show doc" }
})
