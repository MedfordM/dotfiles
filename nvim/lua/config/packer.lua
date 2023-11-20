vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'nvim-tree/nvim-web-devicons' }
  use { "RRethy/vim-illuminate", event = 'BufReadPost' }
  use { "catppuccin/nvim", as = "catppuccin" }
  -- use { 'nvim-treesitter/nvim-treesitter' }
  use { 'mbbill/undotree' }
  use { 'echasnovski/mini.nvim' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'akinsho/bufferline.nvim' }
  -- use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'mfussenegger/nvim-jdtls' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'rafamadriz/friendly-snippets' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope.nvim' }
  use { 'onsails/lspkind.nvim' }
  use { 'folke/trouble.nvim' }
  use { 'folke/which-key.nvim' }
  use { 'MunifTanjim/nui.nvim' }
  use { 'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'luukvbaal/statuscol.nvim' }
  use { 'kylechui/nvim-surround' }
  use { 'moll/vim-bbye' }
  use { 'nvim-lua/lsp-status.nvim' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'folke/neodev.nvim' }
  use { 'mfussenegger/nvim-dap' }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'chaoren/vim-wordmotion' }
  use { 'tpope/vim-fugitive' }
  use { 'mrjones2014/smart-splits.nvim' }
  use { 'mhartington/formatter.nvim' }
end)
