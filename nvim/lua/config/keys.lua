local wk = require('which-key')
local telescope = require('telescope.builtin')
local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
local harpoonMark = require('harpoon.mark')
local harpoonUi = require('harpoon.ui')

vim.g.mapleader = ' '

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")
vim.keymap.set('i', '<C-BS>', '<C-w>')
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)
vim.keymap.set({'n', 'i'}, '<C-Tab>', '<cmd>BufferLineCycleNext<CR>')
vim.keymap.set({'n', 'i'}, '<C-S-Tab>', '<cmd>BufferLineCyclePrev<CR>')
vim.keymap.set({'n', 'i'}, '<C-1>', '<cmd>BufferLineGoToBuffer 1<CR>')
vim.keymap.set({'n', 'i'}, '<C-2>', '<cmd>BufferLineGoToBuffer 2<CR>')
vim.keymap.set({'n', 'i'}, '<C-3>', '<cmd>BufferLineGoToBuffer 3<CR>')
vim.keymap.set({'n', 'i'}, '<C-4>', '<cmd>BufferLineGoToBuffer 4<CR>')
vim.keymap.set({'n', 'i'}, '<C-5>', '<cmd>BufferLineGoToBuffer 5<CR>')
vim.keymap.set({'n', 'i'}, '<C-6>', '<cmd>BufferLineGoToBuffer 6<CR>')
vim.keymap.set({'n', 'i'}, '<C-7>', '<cmd>BufferLineGoToBuffer 7<CR>')
vim.keymap.set({'n', 'i'}, '<C-8>', '<cmd>BufferLineGoToBuffer 8<CR>')
vim.keymap.set({'n', 'i'}, '<C-9>', '<cmd>BufferLineGoToBuffer 9<CR>')
vim.keymap.set('t', '<esc>', '<cmd>ToggleTerm<CR>', {})

wk.register({

    ['<A-h>'] = { vim.cmd.KittyNavigateLeft,  'KittyNavLeft'  },
    ['<A-j>']= { vim.cmd.KittyNavigateDown,   'KittyNavDown'  },
    ['<A-k>'] = { vim.cmd.KittyNavigateUp,    'KittyNavUp'    },
    ['<A-l>'] = { vim.cmd.KittyNavigateRight, 'KittyNavRight' },

  ['<leader>'] = {
    F  = { vim.cmd.NeoTreeShow, 'File tree' },
    C  = { '<cmd>Telescope find_files find_command=fd,-a,--base-directory,/home/mike/.config/nvim<CR>', 'Neovim Conf' },
    q  = { '<cmd>Bdelete<CR>', 'Close buffer' },
    f  = { '<cmd>Telescope find_files find_command=fd,--base-directory,.<CR>', 'Find file' },
    b  = { telescope.buffers, 'Pick buffer' },
    t  = { vim.cmd.ToggleTerm, 'Terminal' },
    u  = { vim.cmd.UndotreeToggle, 'Undo Tree' },

    s = {
      name = 'Session',
      r = { function() require('persistence').load() end, 'Restore' },
      l = { function() require('persistence').load({last=true}) end, 'Restore latest' }
    },

    w = {
      name = 'Window',
      h = { '<C-w>h', 'Focus window left' },
      j = { '<C-w>j', 'Focus window below' },
      k = { '<C-w>k', 'Focus window above' },
      l = { '<C-w>l', 'Focus window right' },
      s = { '<C-w>s', 'Split window horizontally' },
      v = { '<C-w>v', 'Split window vertically' },
    },

    h = {

    name = 'Harpoon',
      a = { harpoonMark.add_file, 'Add file to Harpoon' },
      h = { harpoonUi.toggle_quick_menu, 'Show Harpoon' },
      ['1'] = { function() harpoonUi.nav_file(1) end, 'Goto file 1' },
      ['2'] = { function() harpoonUi.nav_file(1) end, 'Goto file 2' },
      ['3'] = { function() harpoonUi.nav_file(1) end, 'Goto file 3' },
      ['4'] = { function() harpoonUi.nav_file(1) end, 'Goto file 4' },
    },

  }
})


