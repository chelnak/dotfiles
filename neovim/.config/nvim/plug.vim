let g:plug_home = stdpath('data') . '/plugged'

call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'
    Plug 'ntpeters/vim-better-whitespace'

    " Utilities
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'Pocco81/auto-save.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'numToStr/Comment.nvim'
    Plug 'kien/ctrlp.vim'


    " Markdown
    Plug 'godlygeek/tabular'
    Plug 'elzr/vim-json'
    Plug 'plasticboy/vim-markdown'
    Plug 'vim-pandoc/vim-pandoc-syntax'

    " Git
    Plug 'tveskag/nvim-blame-line'
    Plug 'airblade/vim-gitgutter'
    Plug 'kdheepak/lazygit.nvim'

    " NERDTree
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " Theme
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}

    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'github/copilot.vim'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'rodjek/vim-puppet'
    Plug 'mfussenegger/nvim-dap'

    " LSP
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'folke/trouble.nvim'
    Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

    " Completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'

    "  Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'

    Plug 'VonHeikemen/lsp-zero.nvim'
call plug#end()
