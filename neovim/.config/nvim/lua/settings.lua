local set=vim.opt

-- TODO
-- set.nocompatible=true
-- set.nobackup=true
-- set.t_BE=
-- set.nosc = { 'noru', 'nosm' }
-- set.nowrap=true

-- Settings
set.number=true
set.encoding='utf-8'
set.fileencoding='utf-8'
set.title=true
set.autoindent=true
set.background='dark'
set.hlsearch=true
set.showcmd=true
set.cmdheight=1
set.laststatus=2
set.scrolloff=10
set.expandtab=true
set.shell='zsh'
set.backupskip='/tmp/*,/private/tmp/*'
set.inccommand='split'
set.clipboard='unnamedplus'
set.completeopt='noinsert,menuone,noselect'
set.cursorline=true
set.hidden=true
set.mouse='a'
set.splitbelow=true
set.splitright=true
set.ttimeoutlen=0
set.wildmenu=true
set.autoread=true
set.shiftwidth=2
set.tabstop=2
set.lazyredraw=true
set.showmatch=true
set.ignorecase=true
set.smarttab=true
set.shiftwidth=2
set.ai=true
set.si=true
set.backspace='start,eol,indent'
set.path:append '**'
set.wildignore:append'*/node_modules/*'
set.formatoptions:append'r'
set.exrc=true
set.termguicolors=true
set.winblend=0
set.wildoptions='pum'
set.pumblend=5
set.suffixesadd = '.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md,.go'
set.statusline:append '%{Fugitive#Statusline()}'
