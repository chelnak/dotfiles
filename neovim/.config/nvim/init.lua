vim.g.loaded=1
vim.g.loaded_netrwPlugin=1

require('plugins')
require('autocmd')
require('settings')
require('maps')

vim.cmd 'highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40'
vim.cmd 'highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000'
vim.cmd 'colorscheme catppuccin'
vim.cmd 'filetype plugin indent on'
vim.cmd 'cnoreabbrev g Git'
vim.cmd 'cnoreabbrev gg LazyGit'
vim.cmd 'cnoreabbrev gopen GBrowse'
vim.cmd 'command! W w !sudo tee > /dev/null %'

vim.g.better_whitespce_ctermcolor='219'
vim.g.airline_theme='deus'
vim.g.airline_powerline_fonts=1
vim.g['airline#extensions#tabline#enabled']=1
