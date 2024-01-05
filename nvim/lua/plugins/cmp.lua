local merge = function(a, b)
  return vim.tbl_deep_extend('force', {}, a, b)
end

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
    'MedfordM/nvim-cmp',
    -- 'hrsh7th/nvim-cmp',
    version = false,
    event = {'BufEnter', 'CmdlineEnter'},
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },

    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local types = require('cmp.types')

      cmp.setup({
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

        view = {
          entries = 'custom'
        },

        sources = {
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
          { name = 'nvim_lsp_signature_help', group_index = 1 },
          {
            name = 'luasnip',
            group_index = 1,
            max_item_count = 2,
            option = {
              use_show_condition = true
            },
          },
          { name = 'cmp-path', group_index = 2 },
          { name = 'buffer', group_index = 2 },
        },

        window = {
          -- documentation = cmp.config.window.bordered(),
          completion = merge(
          cmp.config.window.bordered(),
          {
            border = 'rounded',
            max_width = 80,
            max_heigth = 40
            -- max_height = 45,
            -- -- max_width = 20,
            -- side_padding = 0
          }
          ),
          documentation = merge(
          cmp.config.window.bordered(),
          {
            border = 'rounded',
            max_width = 80,
            max_heigth = 40
            -- max_height = 45,
            -- max_width = 60,
            -- side_padding = 0
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
          format = function(entry, vim_item)
            -- local label = entry.completion_item.label
            -- local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            -- local menuLbl = vim_item.menu
            -- if vim_item.menu ~= nil and vim_item.menu ~= '' then
            --   local truncated_menu = vim.fn.strcharpart(menuLbl, 0, 30)
            --   if truncated_menu ~= menuLbl then
            --     vim_item.menu = truncated_menu .. ELLIPSIS_CHAR
            --   elseif string.len(menuLbl) < 30 then
            --     local padding = string.rep('', 30 - string.len(menuLbl))
            --     vim_item.menu = menuLbl .. padding
            --   end
            -- else
            --   vim_item.menu = entry.source.name
            -- end
            -- vim_item.detail = 'xxxxxx'
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            -- if (entry.completion_item.documentation) then
            --   local markdown = vim.lsp.util.convert_input_to_markdown_lines(entry.completion_item.documentation)
            --   vim_item.info = 'xxxxxx' .. markdown
            -- end
            return vim_item
          end,
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
          ['<CR>']    = cmp.mapping.confirm({ select = true }),
          ['<C-e>']   = cmp.mapping(function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end),
        }
      })

      cmp.setup.cmdline(':', {
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, {'i'}),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {'i'}),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end),
        },
        sources = {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          },
          { name = 'path' },
        }
      })

      cmp.setup.cmdline({'/', '?'},{
        mapping = {
          ["<Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, {'i'}),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {'i'}),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
              fallback()
            else
              fallback()
            end
          end, {'i'}),
        },
        sources = {
          { name = 'buffer' }
        }
      })
    end
  }
}
