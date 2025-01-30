return {
  url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  ft = 'java',
  dependencies = {
    'mfussenegger/nvim-jdtls',
    'neovim/nvim-lspconfig'
  },
  config = function()
    require('sonarlint').setup({
      server = {
        cmd = {
          'sonarlint-ls',
          '-stdio',
          '-analyzers', '/usr/share/java/sonarlint-ls/analyzers/sonarjava.jar'
        },
      },
      filetypes = {
        'java',
      }
    })
  end
}
