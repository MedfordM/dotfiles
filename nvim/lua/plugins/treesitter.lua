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
            "bash"
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = function(lang, buf)
              if (lang == 'markdown') then
                return true
              end
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
      end
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    opts = {},
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  }
}
