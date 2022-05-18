nnoremap <leader>n :NERDTreeToggle<CR>

autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

let NERDTreeShowHidden=1

" Xuyuanp/nerdtree-git-plugin
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 1
