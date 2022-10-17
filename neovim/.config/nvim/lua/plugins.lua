return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Appearance
    use { 'catppuccin/nvim', as = 'catppuccin', config = [[require('config.catppuccin-theme')]] }
    use { 'nvim-tree/nvim-web-devicons', config = [[require('config.web-devicons')]] }
    use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }, config = [[require('config.lualine-theme')]] }
    -- LSP
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

    -- Utilities
    use { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indentblankline')]] }
    use { 'Pocco81/auto-save.nvim', config = [[require('config.autosave')]] }
    use { 'nvim-telescope/telescope.nvim', config = [[require('config.telescope')]] }
    use { 'nvim-lua/popup.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', }, config = [[require('config.nvim-tree')]] }
    use { 'numToStr/Comment.nvim', config = [[require('config.comment')]] }
    use 'ntpeters/vim-better-whitespace'
    use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }

    -- Git
    use 'tveskag/nvim-blame-line'
    use 'airblade/vim-gitgutter'
    use 'kdheepak/lazygit.nvim'
    use 'tpope/vim-fugitive'

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
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'rodjek/vim-puppet'
    use 'mfussenegger/nvim-dap'

    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = [[require('config.nvim-trouble')]]
    }

    use { 'folke/lsp-colors.nvim', config = function() require('lsp-colors').setup() end }
    use 'fladson/vim-kitty'
    use { 'folke/which-key.nvim', config = [[require('config.which-key')]] }
end)
