local cmp = require('cmp')
local luasnip = require('luasnip')

local merge = function(a, b)
  return vim.tbl_deep_extend('force', {}, a, b)
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
      group_index = 1,
      entry_filter = function(entry)
        if entry:get_kind() == 1 then
          return false
        end
        return true
      end
    },
    {
      name = 'luasnip',
      group_index = 2,
      option = {
        use_show_condition = true
      },
    },
    { name = 'cmp-path',               group_index = 2 },
    { name = 'buffer',                 group_index = 2 },
    { name = 'nvim_lsp_signature_help' },
  }),
  window = {
    completion = merge(
      cmp.config.window.bordered(),
      {
        max_height = 45,
        max_width = 20,
        side_padding = 0
      }
    ),
    documentation = merge(
      cmp.config.window.bordered(),
      {
        max_height = 45,
        max_width = 60,
        side_padding = 0
      }
    )
  },
  formatting = {
    format = require('lspkind').cmp_format({
      maxwidth = 60,
      ellipsis_char = '...',
      with_text = true,
      menu = ({
        buffer   = '[Buffer]',
        nvim_lsp = '[LSP]',
        path     = '[Path]',
        luasnip  = '[LuaSnip]',
      })
    }),
  },
  mapping = {
    ["<Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>']    = cmp.mapping.confirm({ select = false }),
    ['<C-j>']   = cmp.mapping.scroll_docs(5),
    ['<C-k>']   = cmp.mapping.scroll_docs(-5),
    ['<C-e>']   = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end),
  }
})

cmp.setup.cmdline('/', {
  mapping = {
    ["<Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>']    = cmp.mapping.confirm({ select = false }),
    ['<C-j>']   = cmp.mapping.scroll_docs(5),
    ['<C-k>']   = cmp.mapping.scroll_docs( -5),
    ['<C-e>']   = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end),
  },
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = {
    ["<Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>']    = cmp.mapping.confirm({ select = false }),
    ['<C-j>']   = cmp.mapping.scroll_docs(5),
    ['<C-k>']   = cmp.mapping.scroll_docs( -5),
    ['<C-e>']   = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end),
  },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})


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
    { open = '<', close = '/>' }
  },
  ignore_beginning = true,
  exclude = {}
})
