return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', },
    opts = {
      -- signs = {
      --   add          = { text = Icons.git.status_added },
      --   change       = { text = Icons.git.status_modified },
      --   delete       = { text = Icons.git.status_removed },
      --   topdelete    = { text = Icons.git.topdelete },
      --   changedelete = { text = Icons.git.changedelete },
      --   untracked    = { text = Icons.git.untracked },
      -- },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 0,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 0
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', {desc = 'Toggle git blame'})
    end,
  }
}
