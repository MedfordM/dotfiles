local wk = require('which-key')
local telescope = require('telescope.builtin')

wk.register({
  K      = { vim.lsp.buf.hover, 'Show doc' },
  [']s'] = { '<cmd>TSTextobjectGotoNextStart @scope<cr>', 'Scope node' },
  [']z'] = { '<cmd>TSTextobjectGotoNextStart @fold<cr>', 'Fold' },
  [']m'] = { '<cmd>TSTextobjectGotoNextStart @function.outer<cr>', 'Method start' },
  [']c'] = { '<cmd>TSTextobjectGotoNextStart @class.outer<cr>', 'Class start' },
  [']M'] = { '<cmd>TSTextobjectGotoNextEnd @function.outer<cr>', 'Method end' },
  [']C'] = { '<cmd>TSTextobjectGotoNextEnd @class.outer<cr>', 'Method end' },
  ['[m'] = { '<cmd>TSTextobjectGotoPrevStart @function.outer<cr>', 'Method start' },
  ['[c'] = { '<cmd>TSTextobjectGotoPrevStart @class.outer<cr>', 'Class start' },
  ['[M'] = { '<cmd>TSTextobjectGotoPrevStart @class.outer<cr>', 'Method start' },
  ['[C'] = { '<cmd>TSTextobjectGotoPrevStart @class.outer<cr>', 'Class start' },
  ['vm'] = { '<cmd>TSTextobjectSelect @function.outer<cr>', 'Select method' },
  ['vc'] = { '<cmd>TSTextobjectSelect @class.outer<cr>', 'Select class' },

  ['<leader>c'] = {
    name  = 'Code',
    s = { vim.cmd.SymbolsOutline, 'Symbols' },
    r = { vim.lsp.buf.rename, 'Rename symbol' },
    a = { vim.lsp.buf.code_action, 'Quick action' },
    f = { vim.lsp.buf.format, 'Format' },
    j = { vim.cmd.Neogen, 'Gen Docs' },
    D = { '<cmd>lua require("dapui").toggle()', 'DapUI'},

    g = {
      name  = 'Goto',
      r = { telescope.lsp_references, 'References' },
      i = { telescope.lsp_implementations, 'Implementations'},
      d = { vim.lsp.buf.definition, 'Definition' },
      t = { vim.lsp.buf.type_definition, 'Type' },
      s = { telescope.lsp_document_symbols, 'Goto Symbol' },
    },

    d = {
      name  = 'Diagnostics',
      p = { vim.diagnostic.open_float, 'Diagnostic info' },
      l = { telescope.diagnostics, 'Goto diagnostic'},
      [']'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
      ['['] = { vim.diagnostic.goto_prev, 'Prev diagnostic' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'List document issues' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'List workspace issues' },
      c = { vim.cmd.TroubleClose, 'Close diagnostics' }
    },

    p = {
      name  = 'Peek',
      m = { '<cmd>TSTextobjectPeekDefinitionCode @function.outer<cr>', 'Function'},
      c = { '<cmd>TSTextobjectPeekDefinitionCode @class.outer<cr>', 'Class'},
    }

  },
})
