return {
  {
      'nvim-treesitter/nvim-treesitter',
      version = false,
      build = ":TSUpdate",
      event = { 'BufReadPre', 'BufNewFile' },
      init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
      end,
      opts = function()
        return {

          sync_install = false,
          auto_install = true,
          ensure_installed = {
            "java",
            "javascript",
            "typescript",
            "lua",
            "rust",
            "vim",
            "regex",
            "bash",
            "terraform"
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = function(lang, buf)
              -- if (lang == 'markdown') then
              --   return true
              -- end
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
            end,
          },

        }
      end,
      config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
        vim.cmd('TSEnable highlight')
        vim.api.nvim_set_hl(0, 'Folded', {})
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      end
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    opts = {},
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost' },
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
  }
}
