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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  floatWindowStyle
)

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

vim.keymap.set('n', '<leader>n', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = 'Toggle Relative Num'})

vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)

vim.keymap.set('n', '<A-d>', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_filetype = vim.api.nvim_get_option_value('filetype', {buf=current_buf})
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result)
    local res = result[1]
    local bufnr, winid = PreviewLocation(res, {max_height = 40, max_width = 80})
    if bufnr and winid then
      local range = res.range
      vim.api.nvim_win_set_cursor(winid, {range.start.line, range.start.character})
      vim.api.nvim_set_option_value('filetype', current_filetype, {buf=bufnr})
    end
  end)
end)

vim.keymap.set('n', 'gd', function()
  vim.lsp.buf.definition({reuse_win=true})
  vim.api.nvim_feedkeys("zz", "n", false)
end)

-- vim.keymap.del('n', 'grr')
-- vim.keymap.del('n', 'gra')
-- vim.keymap.del('n', 'grn')

-- vim.keymap.set('n', 'gr', function()
--   vim.lsp.buf.references({context = {includeDeclaration = false}})
-- end)

vim.keymap.set('n', 'gr', function()
  vim.api.nvim_command('Lspsaga incoming_calls')
end)

vim.keymap.set('n', 'gi', function()
  vim.lsp.buf.implementation()
end)

vim.keymap.set('n', 'gs', function()
  vim.lsp.buf.document_symbol()
end)

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({count = 1, float=true})
end)

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({count = -1, float=true})
end)

vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Quick action' })
vim.keymap.set('n', '<leader>cdp', function() vim.diagnostic.open_float({severity_sort = true}) end, { desc = 'Diagnostic info' })
vim.keymap.set('n', '<leader>cl', function() vim.lsp.codelens.refresh({bufnr = 0}) end, {desc='Enable codelens'})
