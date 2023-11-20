local wk = require('which-key')
local telescope = require('telescope.builtin')

wk.register({
  K      = { vim.lsp.buf.hover, 'Show doc' },
  [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
  ['[d'] = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
  g = {
    name  = 'Goto',
    r = { telescope.lsp_references, 'References' },
    i = { telescope.lsp_implementations, 'Implementations'},
    d = { vim.lsp.buf.definition, 'Definition' },
    t = { vim.lsp.buf.type_definition, 'Type' },
    s = { telescope.lsp_document_symbols, 'Goto Symbol' },
  },

  ['<leader>c'] = {
    name  = 'Code',
    r = { vim.lsp.buf.rename, 'Rename symbol' },
    a = { vim.lsp.buf.code_action, 'Quick action' },
    x = { vim.lsp.codelens.run, 'Code Lens' },
    f = { '<cmd>silent FormatWrite<cr>', 'Format' },
    D = { '<cmd>lua require("dapui").toggle()<cr>', 'DapUI'},

    d = {
      name  = 'Diagnostics',
      p = { vim.diagnostic.open_float, 'Diagnostic info' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'List document issues' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'List workspace issues' },
      c = { vim.cmd.TroubleClose, 'Close diagnostics' }
    },

    p = {
      name  = 'Peek',
      -- m = { '<cmd>TSTextobjectPeekDefinitionCode @function.outer<cr>', 'Function'},
      -- c = { '<cmd>TSTextobjectPeekDefinitionCode @class.outer<cr>', 'Class'},
    }

  },
})
