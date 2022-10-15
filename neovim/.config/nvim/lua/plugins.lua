-- Plugin setup

return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Simple plugins can be specified as strings
    use 'rstacruz/vim-closer'

    -- Appearance
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'
    -- use 'ntpeters/vim-better-whitespace'
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- Utilities
    use { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indentblankline')]] }
    use { 'Pocco81/auto-save.nvim', config = [[require('config.autosave')]] }
    use { 'nvim-telescope/telescope.nvim', config = [[require('config.telescope')]] }

    use { 'nvim-lua/popup.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        config = [[require('config.nvim-tree')]]
    }

    -- use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end }

    use { 'numToStr/Comment.nvim', config = [[require('config.comment')]] }

    use 'kien/ctrlp.vim'

    -- Git
    use 'tveskag/nvim-blame-line'
    use 'airblade/vim-gitgutter'
    use 'kdheepak/lazygit.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- Language Support
    use 'sheerun/vim-polyglot'
    use 'github/copilot.vim'
    use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'RRethy/nvim-treesitter-textsubjects',
        },
        run = ':TSUpdate',
        config = [[require('config.nvim-treesitter')]]
    }    

    use 'rodjek/vim-puppet'
    -- use 'mfussenegger/nvim-dap'

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = [[require('config.lspzero')]]
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require('config.trouble')]]
    }

end)
