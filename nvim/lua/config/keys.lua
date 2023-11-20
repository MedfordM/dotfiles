local wk = require('which-key')
local telescope = require('telescope.builtin')

vim.g.mapleader = ' '

vim.keymap.set('n', 'I', '<cmd>startinsert<CR>')

vim.keymap.set({'n','v','s'}, 'n', 'j')
vim.keymap.set({'n','v','s'}, 'e', 'k')
vim.keymap.set({'n','v','s'}, 'i', 'l')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")
vim.keymap.set('i', '<C-BS>', '<C-w>')
vim.keymap.set('n', 'U', '<cmd>redo<CR>')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')

vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-n>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-e>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-i>', require('smart-splits').resize_right)

vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-n>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-e>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-i>', require('smart-splits').move_cursor_right)

wk.register({

  ['<leader>'] = {
    [ '<C-Tab>' ] = {'<cmd>BufferLineCycleNext<CR>', 'which_key_ignore'},
    [ '<C-S-Tab>' ] = {'<cmd>BufferLineCyclePrev<CR>', 'which_key_ignore'},
    ['1']  = { '<cmd>BufferLineGoToBuffer 1<CR>', 'which_key_ignore'},
    ['2']  = { '<cmd>BufferLineGoToBuffer 2<CR>', 'which_key_ignore'},
    ['3']  = { '<cmd>BufferLineGoToBuffer 3<CR>', 'which_key_ignore'},
    ['4']  = { '<cmd>BufferLineGoToBuffer 4<CR>', 'which_key_ignore'},
    ['5']  = { '<cmd>BufferLineGoToBuffer 5<CR>', 'which_key_ignore'},
    ['6']  = { '<cmd>BufferLineGoToBuffer 6<CR>', 'which_key_ignore'},
    ['7']  = { '<cmd>BufferLineGoToBuffer 7<CR>', 'which_key_ignore'},
    ['8']  = { '<cmd>BufferLineGoToBuffer 8<CR>', 'which_key_ignore'},
    ['9']  = { '<cmd>BufferLineGoToBuffer 9<CR>', 'which_key_ignore'},
    F  = { '<cmd>Neotree toggle<CR>', 'File tree' },
    C  = { '<cmd>Telescope find_files find_command=fd,-a,--base-directory,/home/mike/.config/nvim<CR>', 'Neovim Conf' },
    q  = { '<cmd>Bdelete<CR>', 'Close buffer' },
    f  = { '<cmd>Telescope find_files find_command=fd,--base-directory,.<CR>', 'Find file' },
    b  = { telescope.buffers, 'Pick buffer' },
    u  = { vim.cmd.UndotreeToggle, 'Undo Tree' },
    g  = { '<cmd>Telescope live_grep<CR>', 'Search files' },
    ['<ESC>'] = { function() require('notify').dismiss() end, 'Dismiss notifications' },
  }
})
