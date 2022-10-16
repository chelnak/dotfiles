vim.g.mapleader = ' '
local set = vim.keymap.set

set('n', '<S-C-p>', '"0p')
set('n', '<leader>d', '_d') -- delete without yanking
set('n', 'x', '"_x')
set('n','dw', 'vb"_d') -- delete word backwards
set('n', '<leader>aa', 'gg vb<S-v>G') -- select all
set('n', '<leader>]', '<cmd>bn<CR>') -- next buffer
set('n', '<leader>[', '<cmd>bp<CR>') -- previous buffer

-- Trouble
set('n', '<leader>tt', '<cmd>TroubleToggle<CR>')
set('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<CR>')
set('n', '<leader>ts', '<cmd>TroubleToggle document_diagnostics<CR>')
set('n', '<leader>tq', '<cmd>TroubleToggle quickfix<CR>')
set('n', '<leader>tl', '<cmd>TroubleToggle loclist<CR>')
set('n', '<leader>gR', '<cmd>TroubleToggle lsp_references<CR>')

-- Telescope
set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')

-- Tree
set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')

