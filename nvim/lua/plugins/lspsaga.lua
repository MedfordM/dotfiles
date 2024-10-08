return {
  'nvimdev/lspsaga.nvim',
  ft = {'java'},
  cmd = {'Lspsaga incoming_calls'},
  config = function()
    require('lspsaga').setup({
      symbol_in_winbar = {
        enable = false
      },
      lightbulb = {
        enable = false
      },
      callhierarchy = {
        keys = {
          edit = '<CR>',
          quit = 'q',
          toggle_or_req = '<TAB>'
        }
      }
    })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  }
}
