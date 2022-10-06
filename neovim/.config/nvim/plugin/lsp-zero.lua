local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.configure('solargraph', {
    settings = {
        solargraph = {
            useBundler = true
        }
    }
})


lsp.setup()
