vim.opt.nu = true
vim.opt.relativenumber = true

vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.signcolumn = 'yes'

vim.opt.cmdheight = 0
vim.opt.showmode = false

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 2

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldtext =
-- [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.fillchars = "fold:\\"
-- vim.opt.foldminlines = 1
