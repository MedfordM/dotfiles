vim.opt.nu             = true
-- vim.opt.relativenumber = true
vim.opt.timeout        = true
vim.opt.timeoutlen     = 300
vim.opt.tabstop        = 2
vim.opt.softtabstop    = 2
vim.opt.shiftwidth     = 2
vim.opt.expandtab      = true
vim.opt.smartindent    = true
vim.opt.wrap           = false
vim.opt.swapfile       = false
vim.opt.backup         = false
vim.opt.undodir        = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile       = true
vim.opt.hlsearch       = false
vim.opt.incsearch      = true
vim.opt.termguicolors  = true
vim.opt.completeopt    = { 'menu', 'menuone', 'noselect' }
vim.opt.cmdheight      = 0
vim.opt.showmode       = false
vim.opt.foldmethod     = 'expr'
vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable     = false
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.signcolumn     = 'yes'
vim.opt.cursorline     = true
vim.opt.foldenable     = true
vim.opt.foldlevel      = 99
vim.opt.foldlevelstart = 99
vim.opt.signcolumn     = 'auto'

vim.diagnostic.config({
  float = {
    show_header = false,
    source = 'if_many',
    border = 'rounded',
  },
  signs = true,
  virtual_text = true,
  underline = true,
  severity_sort = true,
})

vim.fn.sign_define('DiagnosticSignError',
  { text = Icons.diagnostics.ERROR, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn',
  { text = Icons.diagnostics.WARNING })
vim.fn.sign_define('DiagnosticSignHint',
  { text = Icons.diagnostics.HINT })
vim.fn.sign_define('DiagnosticSignInfo',
  { text = Icons.diagnostics.INFO })

