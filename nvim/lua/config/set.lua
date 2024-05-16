vim.g.mapleader = ' '
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
vim.opt.clipboard      = 'unnamedplus'
vim.opt.conceallevel   = 2
vim.api.nvim_set_keymap('ca', 'h', 'vert h', {})
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

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
  update_in_insert = true
})

vim.fn.sign_define('DiagnosticSignError',
  { text = Icons.diagnostics.ERROR, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn',
  { text = Icons.diagnostics.WARNING, texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignHint',
  { text = Icons.diagnostics.HINT, texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo',
  { text = Icons.diagnostics.INFO, texthl = 'DiagnosticSignInfo' })

vim.cmd("let g:wordmotion_mappings = { 'w' : 'w', 'e' : '', 'b' : 'b' }")

local floatWindowStyle = {
    anchor_bias = 'below',
    border = 'rounded',
    winhighlight = 'Normal:Normal,FloatBorder:SpecialChar,CursorLine:Visual,Search:None',
    zindex = 1001,
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = true
}

vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
  config = config or {}
  for k,v in pairs(floatWindowStyle) do config[k] = v end
  config.max_width = 120
  config.max_heigth = 60
  config.wrap = false
  config.focus_id = ctx.method
  config.title = 'Info'
  if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
    -- Ignore result since buffer changed. This happens for slow language servers.
    return
  end
  if not (result and result.contents) then
    if config.silent ~= true then
      vim.notify('No information available')
    end
    return
  end
  local format = 'markdown'
  local contents ---@type string[]
  if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
    format = 'plaintext'
    contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
  else
    contents = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  end
  if vim.tbl_isempty(contents) then
    if config.silent ~= true then
      vim.notify('No information available')
    end
    return
  end
  contents = vim.lsp.util._normalize_markdown(contents)
  return vim.lsp.util.open_floating_preview(contents, format, config)
end

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  floatWindowStyle
)

vim.diagnostic.config({
  float = floatWindowStyle
})
