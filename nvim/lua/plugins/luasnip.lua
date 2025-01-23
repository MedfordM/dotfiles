function get_class_name()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr, 'java')
  if not parser then
    vim.notify('go treesitter parser not found for ' .. vim.fn.bufname(), vim.log.levels.WARN)
    return log('no ts parser found')
  end
  local root = require('nvim-treesitter.ts_utils').get_root_for_position(0, 0)
  local query = vim.treesitter.query.parse('java',
    [[(class_declaration name: (identifier) @name)]]
  )
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    return vim.treesitter.get_node_text(node, bufnr)
  end
end

return {
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      ls.setup({})

      ls.add_snippets("java", {
        ls.snippet("logger", {
          ls.text_node("private static final Logger LOGGER = LoggerFactory.getLogger("),
          require('luasnip.extras').partial(get_class_name),
          ls.text_node(".class);")
        }),
        ls.snippet("pf", {
          ls.text_node("private final "),
          ls.insert_node(1),
          ls.insert_node(2),
          ls.text_node(";"),
        })
      })
    end
  }
}
