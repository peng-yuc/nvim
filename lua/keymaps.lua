-- macOS: make sure to map Option key to Esc+ in iTerm2 to let 'A' works
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   'n' := normal mode
--   'i' := insert mode
--   'v' := visual mode
--   'x' := visual block mode
--   't' := terminal mode
--   'c' := command mode

-- Toggle explorer
keymap('n', '<C-b>', ':Lex 30<CR>', opts)

-- Navigate windows
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<C-k>', '<C-w>k', opts)

-- Resize windows
keymap('n', '<A-w>', ':resize +2<CR>', opts)
keymap('n', '<A-s>', ':resize -2<CR>', opts)
keymap('n', '<A-d>', ':vertical resize +2<CR>', opts)
keymap('n', '<A-a>', ':vertical resize -2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Press jk fast to enter
keymap('i', 'jk', '<Esc>', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Make yank -> visual select -> paste handy
keymap('v', 'p', '"_dP', opts)

-- Move lines up and down like a pro (option + J/K)
keymap('n', '<A-j>', ':move .+1<CR>==', opts)
keymap('n', '<A-k>', ':move .-2<CR>==', opts)
keymap('i', '<A-j>', '<Esc>:move .+1<CR>==gi', opts)
keymap('i', '<A-k>', '<Esc>:move .-2<CR>==gi', opts)
keymap('v', '<A-j>', ":move '>+1<CR>gv=gv", opts)
keymap('v', '<A-k>', ":move '>-2<CR>gv=gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv=gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv=gv", opts)

-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)
