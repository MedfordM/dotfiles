local navic = require('nvim-navic')
require('lualine').setup({
  options = {
    theme = "catppuccin",
    globalstatus = true
  },

  sections = {
    lualine_c = {
      { navic.get_location, cond = navic.is_available },
    }
  },
  extensions = { 'neo-tree', 'toggleterm' }
})
