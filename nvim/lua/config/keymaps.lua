local map = vim.keymap.set

-- Keymaps
map('n', '<Esc>', '<cmd>nohlsearch<CR>» ')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<C-s>', '<cmd>w<CR>', { desc = "Quick save, in windows style" })

-- Focus switching
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Tab splitting
map('n', '<C-Down>', '<cmd>split<CR>', { desc = 'Split window horizontally' })
map('n', '<C-Right>', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- To quickly open Neotree
map('', '<C-S-e>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neotree'} )
map('n', '<C-S-Tab>', '<cmd>tabp<CR>', { desc = 'Go to previous tab'} )

map('n', '<C-q>', '<cmd>close<CR>', { desc = 'Close current buffer'} )

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })


