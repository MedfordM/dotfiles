return {
  {
    'chaoren/vim-wordmotion',
    event = { "BufReadPost" },
    init = function ()
      vim.cmd("let g:wordmotion_mappings = { 'w' : 'w', 'e' : '" .. Layout.movement.END_WORD .. "', 'b' : 'b' }")
    end
  }
}
