local db = require('dashboard')

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  callback = function()
    vim.g.miniindentscope_disable = true
  end,
})

db.hide_statusline = true
db.hide_tabline = true
db.hide_winbar = true
db.session_directory = '~/.local/state/nvim/sessions'
db.session_auto_save_on_exit = true

db.setup({
  theme = "doom",
  config = {
    header = {
      '',
      '',
      '',
      '',
      ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
      ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
      ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
      ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
      ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
      ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
      '',
      '',
    },
    center = {
      { icon = '  ',
        desc = 'Restore Session                         ',
        action = 'lua require("persistence").load()'
      },
      { icon = '  ',
        desc = 'Recently opened files                   ',
        action = 'lua require("telescope.builtin").oldfiles{}',
      },
      { icon = '  ',
        desc = 'Find  File                              ',
        action = 'Telescope find_files find_command=rg,--hidden,--files',
      },
      { icon = '  ',
        desc = 'File Browser                            ',
        action = 'NeoTreeFloatToggle',
      },
      { icon = '  ',
        desc = 'Find  word                              ',
        action = 'Telescope live_grep',
      },
      { icon = '  ',
        desc = 'Open Personal dotfiles                  ',
        action = 'Telescope find_files path="~/.config"',
      }
    }
  }
})
