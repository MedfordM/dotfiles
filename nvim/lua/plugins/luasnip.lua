return {
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      ls.setup({
        history = false,
      })

      ls.add_snippets("java", {
        ls.snippet("logger", {
          ls.text_node("private final Logger logger = LoggerFactory.getLogger("),
          ls.insert_node(1),
          ls.text_node(".class);")
        }),
        ls.snippet("pf", {
          ls.text_node("private final "),
          ls.insert_node(1),
          ls.insert_node(2),
          ls.text_node(";"),
        })
      })

      -- vim.api.nvim_create_autocmd("ModeChanged", {
      --   group = vim.api.nvim_create_augroup("UnlinkLuaSnipSnippetOnModeChange", {
      --     clear = true,
      --   }),
      --   pattern = { "s:n", "i:*" },
      --   desc = "Forget the current snippet when leaving the insert mode",
      --   callback = function(evt)
      --     -- If we have n active nodes, n - 1 will still remain after a `unlink_current()` call.
      --     -- We unlink all of them by wrapping the calls in a loop.
      --     while true do
      --       if ls.session and ls.session.current_nodes[evt.buf] and not ls.session.jump_active then
      --         ls.unlink_current()
      --       else
      --         break
      --       end
      --     end
      --   end,
      -- })
    end
  }
}
