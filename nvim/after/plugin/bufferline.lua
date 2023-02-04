require('bufferline').setup {
  highlights = require('catppuccin.groups.integrations.bufferline').get(),
  options = {
    offsets = {
      { filetype = 'NvimTree', text = '', padding = 1 },
      { filetype = 'neo-tree', text = 'File Explorer', padding = 1 },
      { filetype = 'Outline', text = 'Outline', padding = 1 },
    },
    indicator = {
        style = 'underline'
    },
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    diagnostics_update_in_insert = true,
    buffer_close_icon = '',
    show_buffer_close_icons = true,
    modified_icon = '',
    close_icon = '',
    show_close_icon = false,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = 'multiwindow',
    separator_style = 'thin',
    always_show_bufferline = true,
  },
}
