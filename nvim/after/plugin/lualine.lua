require('lualine').setup({
  options = {
    theme = 'catppuccin',
    globalstatus = true,
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
      },
      -- lualine_c = { 'filename' },
      lualine_c = {
          'diagnostics',
          sources = { 'nvim_lsp' },
          sections = { 'error', 'warn', 'info', 'hint' },
          diagnostics_color = {
            error = 'DiagnosticError',
            warn  = 'DiagnosticWarn',
            info  = 'DiagnosticInfo',
            hint  = 'DiagnosticHint',
          },
          symbols = {error = '', warn = '', info = '', hint = ''},
          colored = true,
          update_in_insert = false,
          always_visible = false
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { "require('lsp-status').status()" },
      lualine_z = { 'location' }
    },
  },

  extensions = { 'neo-tree', 'toggleterm' }
})
