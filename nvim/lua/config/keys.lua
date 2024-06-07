vim.keymap.set('n', Layout.insert, '<cmd>startinsert<CR>')

vim.keymap.set({'n'}, Layout.search.NEXT,     'n')
vim.keymap.set({'n'}, Layout.search.PREVIOUS, 'N')
vim.keymap.set({'n'}, '<leader>x', 'a<C-X>s', {desc = 'Spell Suggestion'})

vim.keymap.set({'n', 'v'}, Layout.movement.LEFT,  'h')
vim.keymap.set({'n', 'v'}, Layout.movement.DOWN,  'j')
vim.keymap.set({'n', 'v'}, Layout.movement.UP,    'k')
vim.keymap.set({'n', 'v'}, Layout.movement.RIGHT, 'l')

vim.keymap.set('i', '<C-BS>', '<C-w>')
vim.keymap.set('n', 'U', '<cmd>redo<CR>')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')
vim.keymap.set('n', '<leader>n', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = 'Toggle Relative Num'})

vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', {desc = 'Toggle git blame'})
