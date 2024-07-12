vim.keymap.set('n', Layout.insert, '<cmd>startinsert<CR>')

vim.keymap.set({'n'}, Layout.search.NEXT,     'n')
vim.keymap.set({'n'}, Layout.search.PREVIOUS, 'N')

vim.keymap.set({'n', 'v'}, Layout.movement.END_WORD,  'e')
vim.keymap.set({'n', 'v'}, Layout.movement.LEFT,  'h')
vim.keymap.set({'n', 'v'}, Layout.movement.DOWN,  'j')
vim.keymap.set({'n', 'v'}, Layout.movement.UP,    'k')
vim.keymap.set({'n', 'v'}, Layout.movement.RIGHT, 'l')

vim.keymap.set({'n'}, '<C-' .. Layout.movement.LEFT .. '>', '<C-w>h')
vim.keymap.set({'n'}, '<C-' .. Layout.movement.DOWN .. '>', '<C-w>j')
vim.keymap.set({'n'}, '<C-' .. Layout.movement.UP .. '>', '<C-w>k')
vim.keymap.set({'n'}, '<C-' .. Layout.movement.RIGHT .. '>', '<C-w>l')

vim.keymap.set({'n'}, '<C-S-' .. Layout.movement.LEFT .. '>', '<C-w>R')
vim.keymap.set({'n'}, '<C-S-' .. Layout.movement.DOWN .. '>', '<C-w>r')
vim.keymap.set({'n'}, '<C-S-' .. Layout.movement.UP .. '>', '<C-w>R')
vim.keymap.set({'n'}, '<C-S-' .. Layout.movement.RIGHT .. '>', '<C-w>r')

vim.keymap.set({'n'}, '<A-' .. Layout.movement.LEFT .. '>', '<C-w><')
vim.keymap.set({'n'}, '<A-' .. Layout.movement.DOWN .. '>', '<C-w>-')
vim.keymap.set({'n'}, '<A-' .. Layout.movement.UP .. '>', '<C-w>+')
vim.keymap.set({'n'}, '<A-' .. Layout.movement.RIGHT .. '>', '<C-w>>')

vim.keymap.set('i', '<C-BS>', '<C-w>')
vim.keymap.set('n', 'U', '<cmd>redo<CR>')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')

vim.keymap.set({'n'}, '<leader>x', 'a<C-X>s', {desc = 'Spell Suggestion'})
vim.api.nvim_set_keymap('ca', 'h', 'vert h', {})
