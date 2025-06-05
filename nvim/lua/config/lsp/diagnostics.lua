local floatWindowStyle = {
    anchor_bias = 'below',
    title = 'Info',
    border = 'rounded',
    winhighlight = 'Normal:Normal,FloatBorder:SpecialChar,CursorLine:Visual,Search:None',
    -- zindex = 1001,
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = true,
    source = 'if_many'
}

vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true,
  severity_sort = true,
  update_in_insert = true,
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
  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
})

-- vim.diagnostic.config({
--   float = vim.tbl_extend('force', floatWindowStyle, { title = 'Diagnostic' }),
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = Icons.diagnostics.ERROR,
--       [vim.diagnostic.severity.WARN] = Icons.diagnostics.WARNING,
--       [vim.diagnostic.severity.INFO] = Icons.diagnostics.INFO,
--       [vim.diagnostic.severity.HINT] = Icons.diagnostics.HINT,
--     },
--     texthl = {
--       [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
--       [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
--       [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
--       [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
--     }
--   },
--   virtual_text = false,
--   underline = {severity = vim.diagnostic.severity.ERROR},
--   severity_sort = true,
--   update_in_insert = true,
-- })
