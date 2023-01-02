vim.g.loaded=1
vim.g.loaded_netrwPlugin=1

require('settings')
require('plugins')
require('autocmd')
require('maps')

vim.cmd 'highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40'

vim.cmd 'filetype plugin indent on'
vim.cmd 'cnoreabbrev gg LazyGit'
vim.cmd 'command! W w !sudo tee > /dev/null %'

vim.g.better_whitespce_ctermcolor='219'
