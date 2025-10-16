return {
  url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  ft = 'java',
  dependencies = {
    'neovim/nvim-lspconfig',
    'lewis6991/gitsigns.nvim'
  },
  config = function()
    require('sonarlint').setup({
      server = {
        -- Setting these initial options for now as a workaround
        -- https://gitlab.com/schrieveslaach/sonarlint.nvim/-/issues/35#note_2784246690
        init_options = {
          connections = vim.empty_dict(),
          rules = vim.empty_dict(),
          automaticAnalysis = true,
        },
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
