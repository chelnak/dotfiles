local set=vim.opt

-- Settings
set.title=true
set.autoindent=true
set.background='dark'
set.clipboard='unnamedplus'
set.cmdheight=1
set.completeopt='noinsert,menuone,noselect'
set.cursorline=true
set.encoding='utf-8'
set.expandtab=true
set.fileencoding='utf-8'
set.formatoptions:append'r'
set.ignorecase=true
set.laststatus=2
set.mouse='a'
set.number=true
set.path:append '**'
set.pumblend=5
set.scrolloff=10
set.secure=true
set.shell='zsh'
set.shiftwidth=2
set.showmatch=true
set.smartindent=true
set.smarttab=true
set.splitright=true
set.statusline:append '%{Fugitive#Statusline()}'
set.tabstop=2
set.termguicolors=true
set.ttimeoutlen=0
set.timeoutlen=500
set.wildignore:append'*/node_modules/'
set.wrap=false
