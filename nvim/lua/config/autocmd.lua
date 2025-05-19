-- Save folds
vim.api.nvim_create_autocmd({"BufWinLeave"}, {
  pattern = {"!*.class"},
  desc = "save view (folds), when closing file",
  command = "mkview",
})
-- Load folds
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"!*.class"},
  desc = "load view (folds), when opening file",
  command = "silent! loadview"
})
