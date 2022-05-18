" init autocmd
autocmd!

" set script encoding
scriptencoding utf-8

" enable syntax highlighting
syntax enable

" load settings
runtime settings.vim

" load plugins
runtime plug.vim

" load keybindings
runtime maps.vim

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

" Set line number color
highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

" enable color scheme
lua << EOF
    require("nightfox").setup({
        palettes = {
            nordfox = {
                comment = "#b0c0d6", -- "#60728a",
            },
        }
    })
EOF

colorscheme nordfox

" turns on "detection", "plugin" and "indent" at once.
filetype plugin indent on

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Language specific Settings
autocmd BufNewFile,BufRead *.es6 setf javascript
autocmd BufNewFile,BufRead *.tsx setf typescriptreact
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.mdx set filetype=markdown
autocmd BufNewFile,BufRead *.go set filetype=go
autocmd BufNewFile,BufRead *.rb set filetype=ruby

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" Reload files when they change on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

autocmd FileChangedShellPost *
\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Set the color for extra whitespace
let g:better_whitespace_ctermcolor='219'

command! GHChangelog execute('!gh changelog new')
