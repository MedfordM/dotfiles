return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'catppuccin' },
      {
        'nvim-tree/nvim-web-devicons',
        config = function()
          require('nvim-web-devicons').setup({
            color_icons = true;
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true;
            -- globally enable "strict" selection of icons - icon will be looked up in
            -- different tables, first by filename, and if not found by extension; this
            -- prevents cases when file doesn't have any extension but still gets some icon
            -- because its name happened to match some extension (default to false)
            strict = true;
            -- same as `override` but specifically for overrides by filename
            -- takes effect when `strict` is true
          })
        end
      },
    },
    opts = function()
      return {
        highlights = require('catppuccin.groups.integrations.bufferline').get({styles = { "italic", "bold" }}),
        options = {
          offsets = {
            { filetype = 'NvimTree', text = '', padding = 1 },
            { filetype = 'neo-tree', text = 'File Explorer', separator = true },
            { filetype = 'Outline', text = 'Outline', padding = 1 },
          },
          custom_filter = function(buf_number, _)
            if vim.fn.bufname(buf_number) ~= '' then
              return true
            end
          end,
          indicator = {
            style = 'icon',
            icon = '┃'
          },
          -- diagnostics = 'nvim_lsp',
          -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
          --   local s = ""
          --   for e, n in pairs(diagnostics_dict) do
          --     local sym = e == "error" and Icons.diagnostics.ERROR
          --       or (e == "warning" and Icons.diagnostics.WARNING ) or ''
          --       if sym ~= '' then
          --         s = s .. ' ' .. n .. ' ' .. sym
          --       end
          --   end
          --   return s
          -- end,
          -- diagnostics_update_in_insert = true,
          buffer_close_icon = '󰅖',
          show_buffer_close_icons = true,
          modified_icon = '',
          close_icon = '',
          show_close_icon = false,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
          },
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 18,
          max_prefix_length = 13,
          tab_size = 20,
          show_tab_indicators = true,
          enforce_regular_tabs = false,
          view = 'multiwindow',
          separator_style = 'thin',
          always_show_bufferline = true,
        },
      }
    end,
    config = function(_, opts)
      local bufferline = require('bufferline')
      bufferline.setup(opts)
      for i=1,#Layout.buffers do
        vim.keymap.set('n', Layout.buffers[i], function() bufferline.go_to(i, true) end, {desc = 'which_key_ignore'})
      end
      vim.keymap.set('n', '<leader>bn', '<cmd>BufferLineCycleNext<cr>', {desc = 'Nex Buffer'})
      vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineCyclePrev<cr>', {desc = 'Prev Buffer'})
      vim.keymap.set('n', '<leader>b>', '<cmd>BufferLineMoveNext<cr>', {desc = 'Move buffer right'})
      vim.keymap.set('n', '<leader>b<', '<cmd>BufferLineMovePrev<cr>', {desc = 'Move buffer left'})
      vim.keymap.set('n', '<leader>bm', function() bufferline.move_to(tonumber(vim.fn.input('Move buffer to position: '))) end, {desc = 'Move buffer to index'})
    end
  }
}
