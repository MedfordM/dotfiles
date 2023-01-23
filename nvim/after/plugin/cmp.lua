local cmp = require('cmp')
local luasnip = require('luasnip')

local merge = function(a, b)
  return vim.tbl_deep_extend('force', {}, a, b)
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'cmp-path' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' }
  }),

  preselect = cmp.PreselectMode.Item,

  window = {
    completion = merge(
      cmp.config.window.bordered(),
      {
        max_height = 45,
        max_width = 60,
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
    format = require("lspkind").cmp_format({ with_text = true, menu = ({}) }),
  },

  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-j>'] = cmp.mapping.scroll_docs(5),
    ['<C-k>'] = cmp.mapping.scroll_docs(-5),
    ['<C-e>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end),
  }
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['jdtls'].setup {
  capabilities = capabilities
}
