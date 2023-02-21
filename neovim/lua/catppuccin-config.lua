local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup {
    flavour = "macchiato",
    -- term_colors = true,
    integrations = {
        treesitter = true,
        treesitter_context = true,
        nvimtree = true,
        telescope = true,
        lsp_trouble = true,
        gitgutter = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true
        },
        markdown = true,
        cmp = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    },
    custom_highlights = {
        Comment = { fg = colors.overlay1 },
        LineNr = { fg = colors.overlay1 },
        IndentBlanklineContextChar = { fg = colors.mauve },
        IndentBlanklineContextStart = { fg = colors.mauve },
    },
}

vim.api.nvim_command "colorscheme catppuccin"