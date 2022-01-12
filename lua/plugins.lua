local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins

  -- Aesthetic
  use 'LunarVim/darkplus.nvim'

  -- NvimTree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- file icons
      'akinsho/bufferline.nvim', -- bufferline
      'moll/vim-bbye',
    },
    config = function()
      require'nvim-tree'.setup {}
      require'bufferline'.setup {}
    end,
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer', -- Buffer completions
      'hrsh7th/cmp-path', -- Path completions
      'hrsh7th/cmp-cmdline', -- Command line completions
      'hrsh7th/cmp-nvim-lsp', -- Neovim LSP completions
      'hrsh7th/cmp-nvim-lua', -- Neovim Lua completions
      'saadparwaiz1/cmp_luasnip', -- Snippet completions
    },
  }

  -- Snippets
  use 'L3MON4D3/LuaSnip' -- Snippet engine
  use 'rafamadriz/friendly-snippets' -- A bunch of snippets

  -- LSP
  use {
    'williamboman/nvim-lsp-installer', -- Neovim language server installer
    requires = { 'neovim/nvim-lspconfig' },
  }

  -- Null LS
  use 'jose-elias-alvarez/null-ls.nvim' -- for formatters and linters

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Autopairs, integrates with both cmp and treesitter
  use {
    'windwp/nvim-autopairs',
    config = function()
      require'nvim-autopairs'.setup {}
    end,
  }

  -- Comment, `gc` to comment
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Git Sign
  use 'lewis6991/gitsigns.nvim'

  -- Toggle Terminal
  use 'akinsho/toggleterm.nvim'

  -- Lualine
  use 'nvim-lualine/lualine.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
