local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({'i', 's'}, '<C-k>', function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true})


vim.keymap.set('i', '<C-j>', function ()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')
