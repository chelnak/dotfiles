let g:plug_home = stdpath('data') . '/plugged'

call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'ntpeters/vim-better-whitespace'

    " Utilities
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'plasticboy/vim-markdown'
    Plug 'Pocco81/AutoSave.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'numToStr/Comment.nvim'

    " Git
    Plug 'tveskag/nvim-blame-line'
    Plug 'airblade/vim-gitgutter'

    " NERDTree
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " Theme
    Plug 'EdenEast/nightfox.nvim'

    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'github/copilot.vim'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " LSP
    Plug 'tami5/lspsaga.nvim'
    Plug 'folke/lsp-colors.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'onsails/lspkind-nvim'
    Plug 'williamboman/nvim-lsp-installer'

    " Completion
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()
