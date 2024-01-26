vim.keymap.set('n', 'I', '<cmd>startinsert<CR>')

vim.keymap.set({'n'}, 'l', 'n')
vim.keymap.set({'n'}, 'L', 'N')

vim.keymap.set({'n','v'}, 'n', 'j')
vim.keymap.set({'n','v'}, 'e', 'k')
vim.keymap.set({'n','v'}, 'i', 'l')

vim.keymap.set('v', 'N', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'E', ":m '>-2<CR>gv=gv")

vim.keymap.set('i', '<C-BS>', '<C-w>')

vim.keymap.set('n', 'U', '<cmd>redo<CR>')

vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')

vim.keymap.set('n', '<leader>n', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = 'Toggle Relative Num'})

