vim.opt.nu             = true
vim.opt.relativenumber = false
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
vim.opt.completeopt    = { 'menu', 'menuone', 'preview' }
vim.opt.cmdheight      = 0
vim.opt.showmode       = false
vim.opt.foldmethod     = 'expr'
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.signcolumn     = 'yes'
vim.opt.cursorline     = true
vim.opt.foldlevel      = 99
vim.opt.foldlevelstart = 99
vim.opt.signcolumn     = 'auto'
vim.opt.clipboard      = 'unnamedplus'
vim.opt.conceallevel   = 2
vim.opt.fillchars:append { diff = "╱" }
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
