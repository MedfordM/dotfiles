return {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {'nvim-tree/nvim-web-devicons'},
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode',
            {
                "macro-recording",
                fmt = function()
                  local recording_register = vim.fn.reg_recording()
                  if recording_register == "" then
                      return ""
                  else
                      return "Recording @" .. recording_register
                  end
                end
            }
        },
        lualine_b = {'branch', 'diff',
          {
            'diagnostics',
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_workspace_diagnostic' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn'  },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              -- error = 'DiagnosticError', -- Changes diagnostics' error color.
              -- warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              -- info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
              -- hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            symbols = {error = Icons.diagnostics.ERROR, warn = Icons.diagnostics.WARNING, info = Icons.diagnostics.INFO, hint = Icons.diagnostics.HINT},
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = true, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
          }
        },
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'neo-tree', 'trouble', 'nvim-dap-ui', 'fugitive', 'mason', 'lazy'  }
    },
    config = function(_, opts)
      local lualine = require('lualine')
      lualine.setup(opts)
      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
            lualine.refresh({place = { "statusline" }})
        end
      })
      vim.api.nvim_create_autocmd("RecordingLeave", {
          callback = function()
              local timer = vim.loop.new_timer()
              timer:start(
                  50,
                  0,
                  vim.schedule_wrap(function()
                      lualine.refresh({place = { "statusline" }})
                  end)
              )
          end,
      })
    end,
}
