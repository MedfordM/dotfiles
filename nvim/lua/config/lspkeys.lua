local wk = require('which-key')

wk.register({
  K      = { vim.lsp.buf.hover, 'Show doc' },
  ['gd'] = { function() vim.lsp.buf.definition() vim.api.nvim_feedkeys("zz", "n", false) end, 'Goto Definition'},
  [']d'] = { function() vim.diagnostic.goto_next({severity = { vim.diagnostic.severity.WARNING, vim.diagnostic.severity.ERROR }}) vim.api.nvim_feedkeys("zz", "n", false) end, 'Next diagnostic' },
  ['[d'] = { function() vim.diagnostic.goto_prev({severity = { vim.diagnostic.severity.WARNING, vim.diagnostic.severity.ERROR }}) vim.api.nvim_feedkeys("zz", "n", false) end, 'Prev diagnostic' },

  ['<leader>c'] = {
    name  = 'Code',
    r = { vim.lsp.buf.rename, 'Rename symbol' },
    a = { vim.lsp.buf.code_action, 'Quick action' },
    f = { '<cmd>silent FormatWrite<cr>', 'Format' },
    d = {
      name  = 'Diagnostics',
      p = { function() vim.diagnostic.open_float({severity_sort = true}) end, 'Diagnostic info' },
    },
  },
})
