vim.lsp.config['arduino'] = {
  filetypes = { 'arduino', 'ino' },
  root_dir = require('lspconfig.util').root_pattern '*.ino',
  cmd = {
    'arduino-language-server',
  },
  capabilities = {
    textDocument = {
      semanticTokens = vim.NIL,
    },
    workspace = {
      semanticTokens = vim.NIL,
    },
  }
}
