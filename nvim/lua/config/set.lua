vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.timeout = true
vim.opt.timeoutlen = 300
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
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
vim.opt.splitright = true
vim.opt.splitbelow = true

local function lspSymbol(name, icon)
vim.fn.sign_define(
	'DiagnosticSign' .. name,
	{ text = icon, numhl = 'DiagnosticDefault' .. name }
)
end
lspSymbol('Error', '')
lspSymbol('Info',  '')
lspSymbol('Hint',  '')
lspSymbol('Info',  '')
lspSymbol('Warn',  '')
