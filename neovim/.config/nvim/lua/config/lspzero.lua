local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.configure('solargraph', {
    settings = {
        solargraph = {
            useBundler = true
        }
    }
})

lsp.set_preferences({
    manage_nvim_cmp = false,
})

lsp.setup()
