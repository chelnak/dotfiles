-- Globals
vim.g.loaded=1
vim.g.loaded_netrwPlugin=1
vim.g.better_whitespce_ctermcolor='219'
vim.g.mapleader = ' '

-- Plugin Configs
require('autosave-config')
require('catppuccin-config')
require('comment-config')
require('feline-config')
require('gitsigns-config')
require('indent-blank-line-config')
require('lsp-colors-config')
require('lsp-zero-config')
require('nvim-autopairs-config')
require('nvim-tree-config')
require('nvim-treesitter-config')
require('nvim-trouble-config')
require('telescope-config')
require('web-devicons-config')
require('which-key-config')

-- Commands
vim.cmd 'highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40'
vim.cmd 'filetype plugin indent on'
vim.cmd 'cnoreabbrev gg LazyGit'
vim.cmd 'command! W w !sudo tee > /dev/null %'

-- Settings
local settings=vim.opt

settings.title=true
settings.autoindent=true
settings.background='dark'
settings.clipboard='unnamedplus'
settings.cmdheight=0
settings.completeopt='noinsert,menuone,noselect'
settings.cursorline=true
settings.encoding='utf-8'
settings.expandtab=true
settings.fileencoding='utf-8'
settings.formatoptions:append'r'
settings.ignorecase=true
settings.laststatus=3
settings.mouse='a'
settings.number=true
settings.path:append '**'
settings.pumblend=5
settings.scrolloff=10
settings.secure=true
settings.shell='zsh'
settings.shiftwidth=2
settings.showmatch=true
settings.smartindent=true
settings.smarttab=true
settings.splitright=true
settings.tabstop=2
settings.termguicolors=true
settings.ttimeoutlen=0
settings.timeoutlen=500
settings.wildignore:append'*/node_modules/'
settings.wrap=false

-- Key maps
local map_key = vim.keymap.set

map_key('n', '<S-C-p>', '"0p')
map_key('n', '<leader>d', '_d') -- delete without yanking
map_key('n', 'x', '"_x')
map_key('n','dw', 'vb"_d') -- delete word backwards
map_key('n', '<leader>aa', 'gg vb<S-v>G') -- select all
map_key('n', '<leader>]', '<cmd>bn<CR>') -- next buffer
map_key('n', '<leader>[', '<cmd>bp<CR>') -- previous buffer

---- Trouble
map_key('n', '<leader>tt', '<cmd>TroubleToggle<CR>')
map_key('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>')
map_key('n', '<leader>ts', '<cmd>TroubleToggle document_diagnostics<CR>')
map_key('n', '<leader>tq', '<cmd>TroubleToggle quickfix<CR>')
map_key('n', '<leader>tl', '<cmd>TroubleToggle loclist<CR>')
map_key('n', '<leader>gR', '<cmd>TroubleToggle lsp_references<CR>')

---- Telescope
map_key('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map_key('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map_key('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map_key('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')

---- Tree
map_key('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')

-- Auto commands
local autocmd = vim.api.nvim_create_autocmd

autocmd('InsertLeave', { command = 'set nopaste' })
autocmd('BufNewFile,BufRead', { pattern='*.es6', command='setf javascript' })
autocmd('BufNewFile,BufRead', { pattern='*.tsx', command='setf typescriptreact' })
autocmd('BufNewFile,BufRead', { pattern='*.md', command='set filetype=markdown' })
autocmd('BufNewFile,BufRead', { pattern='*.mdx', command='set filetype=markdown' })
autocmd('BufNewFile,BufRead', { pattern='*.go', command='set filetype=go' })
autocmd('BufNewFile,BufRead', { pattern='*.rb', command='set filetype=ruby' })
autocmd('FileType', { pattern = 'ruby', command='setlocal shiftwidth=2 tabstop=2' })
autocmd('FileType', { pattern = 'yaml', command='setlocal shiftwidth=2 tabstop=2' })
autocmd('FileChangedShellPost', { command='echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None'})
autocmd('BufEnter', { pattern = '*', command = 'EnableBlameLine' })
