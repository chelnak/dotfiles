local treesitter = require("nvim-treesitter.configs")
treesitter.setup {
    ensure_installed = {"go", "python", "ruby", "typescript", "bash"},
    highlight = {
        enable = true
    },
}
