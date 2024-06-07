local floatWindowStyle = {
    anchor_bias = 'below',
    title = 'Info',
    border = 'rounded',
    winhighlight = 'Normal:NormalFloat,FloatBorder:SpecialChar,CursorLine:Visual,Search:None',
    zindex = 1001,
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = true,
}

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

return {
  {
    -- 'MedfordM/nvim-cmp',
    'hrsh7th/nvim-cmp',
    event = {'BufEnter', 'CmdlineEnter'},
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function(_, _)
      vim.api.nvim_create_autocmd('FileType', {
          pattern = 'cmp_docs',
          callback = function()
              vim.treesitter.start(0, 'markdown')
          end,
      })
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'luasnip', group_index = 2 },
          { name = 'path', group_index = 2 },
          { name = 'buffer', group_index = 2 },
        }),
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
          },
          keyword_length = 2
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        experimental = {
          ghost_text = true
        },
        view = {
          entries = {
            follow_cursor = true
          }
        },
        window = {
          completion = floatWindowStyle,
          documentation = floatWindowStyle,
        },
        formatting = {
          expandable_indicator = false,
          fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
          },
          format = function(_, vim_item)
            local menuLbl = vim_item.menu
            if vim_item.menu ~= nil and vim_item.menu ~= '' then
              local truncated_menu = vim.fn.strcharpart(menuLbl, 0, 30)
              if truncated_menu ~= menuLbl then
                vim_item.menu = truncated_menu .. '...'
              elseif string.len(menuLbl) < 30 then
                local padding = string.rep('', 30 - string.len(menuLbl))
                vim_item.menu = menuLbl .. padding
              end
            end
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            return vim_item
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {'i'}),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
            else
              fallback()
            end
          end, {'i'}),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>']  = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
          ['<C-e>']   = cmp.mapping(function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end, {'i'}),
        }
      })
      cmp.setup.cmdline(':', {
        mapping = {
          ["<Tab>"] = cmp.mapping(function()
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          end, {'c'}),
          ["<S-Tab>"] = cmp.mapping(function()
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          end, {'c'}),
        },
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'buffer' },
          { name = 'cmdline' },
          { name = 'nvim_lua' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.filetype('lua', {
        sources = {
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'nvim_lua', group_index = 1 },
        }
      })
    end
  }
}
