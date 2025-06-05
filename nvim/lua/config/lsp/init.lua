require('config.lsp.autocmd')
require('config.lsp.diagnostics')
require('config.lsp.keys')


local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities
})

-- require and enable all languages in the servers directory
local servers_subdir = 'config/lsp/servers'
local servers_dir = vim.fn.stdpath("config") .. "/lua/" .. servers_subdir
local lsp_servers = {}

if vim.fn.isdirectory(servers_dir) == 1 then
  local servers_module = servers_subdir:gsub('/', ".")
  for _, file in ipairs(vim.fn.readdir(servers_dir)) do
    if file:match("%.lua$") and file ~= "init.lua" then
      local server_name = file:gsub("%.lua$", "")
      local server_module = servers_module .. '.' .. server_name
      require(server_module)
      table.insert(lsp_servers, server_name)
    end
  end
end

vim.lsp.enable(lsp_servers)
