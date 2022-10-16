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

-- Reset diagnostic config
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = true,
})
