return {
  "folke/noice.nvim",
  event = "VeryLazy",
  init = function(_)
    vim.keymap.set({'n'}, '<leader><escape>', function() vim.cmd('NoiceDismiss') end, {desc = 'Dismiss Notifications'})
  end,
  opts = {
    lsp = {
      progress = {
        enabled = false
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }
}
