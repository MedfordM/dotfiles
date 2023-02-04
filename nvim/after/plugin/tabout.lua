require('tabout').setup({
  tabkey = '<Tab>',
  act_as_tab = true,
  act_as_shift_tab = true,
  default_tab = '<Tab>',
  default_shift_tab = '<S-Tab>',
  enable_backwards = true,
  backwards_tabkey = '<S-Tab>',
  completion = true,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = '`', close = '`' },
    { open = '(', close = ')' },
    { open = '[', close = ']' },
    { open = '{', close = '}' },
    { open = '<', close = '>' }
  },
  ignore_beginning = true,
  exclude = {}
})
