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
vim.api.nvim_set_keymap('ca', 'h', 'vert h', {})
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

local floatWindowStyle = {
    anchor_bias = 'below',
    title = 'Info',
    border = 'rounded',
    winhighlight = 'Normal:Normal,FloatBorder:SpecialChar,CursorLine:Visual,Search:None',
    zindex = 1001,
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = true,
    source = 'if_many'
}

vim.diagnostic.config({
  float = {
    header = 'Diagnostics',
    border = 'rounded',
    scope = 'cursor',
    anchor_bias = 'below',
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = true,
    source = 'if_many'
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = Icons.diagnostics.ERROR,
      [vim.diagnostic.severity.WARN] = Icons.diagnostics.WARNING,
      [vim.diagnostic.severity.INFO] = Icons.diagnostics.INFO,
      [vim.diagnostic.severity.HINT] = Icons.diagnostics.HINT,

    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    }
  },
  virtual_text = false,
  underline = {severity = vim.diagnostic.severity.ERROR},
  severity_sort = true,
  update_in_insert = true,
})

vim.cmd("let g:wordmotion_mappings = { 'w' : 'w', 'e' : '', 'b' : 'b' }")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  floatWindowStyle
)
