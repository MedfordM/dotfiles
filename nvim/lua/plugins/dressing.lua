return {
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = function()
      return {
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,

          -- Default prompt string
          default_prompt = "Input:",

          -- Can be 'left', 'right', or 'center'
          title_pos = "left",

          -- When true, <Esc> will close the modal
          insert_only = true,

          -- When true, input will start in insert mode.
          start_in_insert = true,

          -- These are passed to nvim_open_win
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "cursor",
          position = 2,
          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 40,
          width = nil,
          -- min_width and max_width can be a list of mixed types.
          -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },

          buf_options = {},
          win_options = {
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = "precedes:…,extends:…",
            winhighlight = 'Normal:Normal,FloatBorder:SpecialChar,CursorLine:Visual,Search:None',
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,
          },

          -- Set to `false` to disable
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,

          -- see :help dressing_get_config
          get_config = nil,
        },
        select = {
          enabled = true,
          backend = { "nui", "telescope", "builtin" },
          win_options = {
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = "precedes:…,extends:…",
            winhighlight = 'Normal:Normal,FloatBorder:SpecialChar,CursorLine:Visual,Search:None',
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          get_config = function(opts)
            vim.print(vim.inspect(opts))
            if opts.kind == 'codeaction' then
              return {
                backend = 'nui',
                trim_prompt = true,
                nui = {
                  position = '2',
                  relative = 'cursor',
                  max_width = 80,
                  border = {
                    style = "rounded",
                  },
                  buf_options = {
                    swapfile = false,
                    filetype = "DressingSelect",
                  },
                  win_options = {
                    -- Disable line wrapping
                    wrap = false,
                    -- Indicator for when text exceeds window
                    list = true,
                    listchars = "precedes:…,extends:…",
                    winhighlight = 'Normal:Normal,FloatBorder:SpecialChar,CursorLine:Visual,Search:None',
                    -- Increase this for more context when text scrolls off the window
                    sidescrolloff = 0,
                  },
                }
              }
            else if opts.kind == 'jdtls.multi' then
              local function select_index()
                local actions = require "telescope.actions"
                local action_state = require "telescope.actions.state"
                local action_utils = require "telescope.actions.utils"
                actions.select_default:replace(function()
                  local prompt_bufnr = vim.api.nvim_get_current_buf()
                  local results = {}
                  action_utils.map_selections(prompt_bufnr, function(entry, _)
                    entry.value.isSelected = true
                    table.insert(results, entry.value)
                  end)
                  require('telescope.actions').close(prompt_bufnr)
                  vim.fn.setreg('x', vim.json.encode(results))
                end)
                return true
              end
              return {
                backend = 'telescope',
                trim_prompt = true,
                telescope = {
                  initial_mode = 'normal',
                  prompt_title = 'Constructor Parameters',
                  path_display = {'tail'},
                  borderchars = {
                    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                    results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" }
                  },
                  layout_config = {
                    height = 12,
                    width = 80
                  },
                  layout_strategy = "cursor",
                  results_title = false,
                  sorting_strategy = "ascending",
                  theme = "cursor",
                  attach_mappings = select_index
                }
              }
            end
          end
          end,
        }
      }
      end,
    }
  }
