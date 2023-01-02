local api = vim.api

api.nvim_create_autocmd('InsertLeave', { command = 'set nopaste' })
api.nvim_create_autocmd('BufNewFile,BufRead', { pattern='*.es6', command='setf javascript' })
api.nvim_create_autocmd('BufNewFile,BufRead', { pattern='*.tsx', command='setf typescriptreact' })
api.nvim_create_autocmd('BufNewFile,BufRead', { pattern='*.md', command='set filetype=markdown' })
api.nvim_create_autocmd('BufNewFile,BufRead', { pattern='*.mdx', command='set filetype=markdown' })
api.nvim_create_autocmd('BufNewFile,BufRead', { pattern='*.go', command='set filetype=go' })
api.nvim_create_autocmd('BufNewFile,BufRead', { pattern='*.rb', command='set filetype=ruby' })

api.nvim_create_autocmd('FileType', { pattern = 'ruby', command='setlocal shiftwidth=2 tabstop=2' })
api.nvim_create_autocmd('FileType', { pattern = 'yaml', command='setlocal shiftwidth=2 tabstop=2' })

api.nvim_create_autocmd('FileChangedShellPost', { command='echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None'})

-- Packer
local packer_user_config = api.nvim_create_augroup('packer_user_config', {clear = true})
api.nvim_create_autocmd("BufWritePost", { pattern="plugins.lua", command="source <afile> | PackerCompile", group=packer_user_config })
api.nvim_create_autocmd('BufEnter', { pattern = '*', command = 'EnableBlameLine' })
