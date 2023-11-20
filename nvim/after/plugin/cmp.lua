local cmp = require('cmp')
local luasnip = require('luasnip')
local types = require('cmp.types')
local cmpEntry = require('cmp.entry')
local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 25
local MIN_LABEL_WIDTH = 25

local merge = function(a, b)
  return vim.tbl_deep_extend('force', {}, a, b)
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  -- performance = {
  --   max_view_entries = 10
  -- },
  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
      group_index = 1,
      entry_filter = function(entry)
        if entry:get_kind() == types.lsp.CompletionItemKind.Text or entry:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return false
        end
        return true
      end
    },
    {
      name = 'luasnip',
      group_index = 2,
      max_item_count = 2,
      option = {
        use_show_condition = true
      },
    },
    { name = 'cmp-path', max_item_count = 1,              group_index = 2 },
    { name = 'buffer',                 group_index = 2 },
    { name = 'nvim_lsp_signature_help' },
  }),
  window = {
    -- documentation = cmp.config.window.bordered(),
    completion = merge(
      cmp.config.window.bordered(),
      {
        max_height = 45,
        -- max_width = 20,
        side_padding = 0
      }
    ),
    documentation = merge(
      cmp.config.window.bordered(),
      {
        max_height = 45,
        -- max_width = 60,
        side_padding = 0
      }
    )
  },
  formatting = {
    expandable_indicator = false,
    fields = {
			cmp.ItemField.Kind,
			cmp.ItemField.Abbr,
      cmp.ItemField.Menu,
		},
    format = require('lspkind').cmp_format({
      mode = 'symbol',
      before = function(entry, vim_item)
        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
        -- if truncated_label ~= label then
        --   vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
        -- elseif string.len(label) < MIN_LABEL_WIDTH then
        --   local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label)) .. '     '
        --   vim_item.abbr = label .. padding
        -- end
        local menuLbl = vim_item.menu
        if vim_item.menu ~= nil and vim_item.menu ~= '' then
          local truncated_menu = vim.fn.strcharpart(menuLbl, 0, 30)
          if truncated_menu ~= menuLbl then
            vim_item.menu = truncated_menu .. ELLIPSIS_CHAR
          elseif string.len(menuLbl) < 30 then
            local padding = string.rep('', 30 - string.len(menuLbl))
            vim_item.menu = menuLbl .. padding
          end
        else
          vim_item.menu = entry.source.name
        end
        return vim_item
      end,
      preset = 'default',
      maxwidth = 30,
      ellipsis_char = '...',
      dup = 0,
    }),
  },

  mapping = {
    ["<Down>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
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
    ['<CR>']    = cmp.mapping.confirm({ select = true }),
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
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
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
    [' ']   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end),
  },
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = {
    ["<Down>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end),
    ['Up'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ["<Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
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
