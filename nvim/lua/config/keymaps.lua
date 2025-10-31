local map = vim.keymap.set

map('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Keymaps
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Search and focus
map('n', 'n', 'nzz')
map('n', '<S-n>', '<S-n>zz')

-- Quick line editing
map('n', '<leader>a;', '<S-a>;<Esc>', { desc = "Add a semicolon to EOL" })
map('n', '<leader>a,', '<S-a>,<Esc>', { desc = "Add a comma to EOL" })

map('n', '<A-j>', ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
map('n', '<A-k>', ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move block up" })

map({ 'n', 'v' }, "H", "^", { noremap = true, desc = "^" })
map({ 'n', 'v' }, "L", "$", { noremap = true, desc = "$" })

map('n', '<C-q>', '<cmd>close<CR>', { desc = 'Close current buffer' } )
map('n', '<C-s>', '<cmd>w<CR>', { desc = "Quick save, in windows style" })

map('', '<F11>', function ()
        if vim.g.neovide then
            if vim.g.neovide_fullscreen then
                vim.g.neovide_fullscreen = false
            else
                vim.g.neovide_fullscreen = true
            end
        end
    end,
    { desc = "Toggle fullscreen while in Neovide" }
)

-- Copy & paste with the system clipboard
map('v', '<leader>y', '"+y', { desc = "Yank current selection to the system clipboard" })
map('n', '<leader>yy', '"+yy', { desc = "Yank current line to the system clipboard" })
map({ 'n', 'v' }, '<leader>p', '"+p', { desc = "Paste below from the system clipboard" })
map({ 'n', 'v' }, '<leader>P', '"+P', { desc = "Paste above from the system clipboard" })

-- Focus switching
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<C-Tab>', '<cmd>tabn<CR>', { desc = 'Go to next tab' } )
map('n', '<C-S-Tab>', '<cmd>tabp<CR>', { desc = 'Go to previous tab' } )

-- Tab splitting
map('n', '<C-Down>', '<cmd>split<CR>', { desc = 'Split window horizontally' })
map('n', '<C-Right>', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- To quickly open Neotree
map('', '<C-S-e>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neotree' } )

-- Telescope
local telescope = require('telescope.builtin')
map('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })

-- Close buffers
local close_buffers = require('close_buffers')
map('n', '<leader>bdh', function()
        close_buffers.delete( { type = 'hidden', force = true } )
    end,
    { desc = "Delete all hidden buffers" }
)

map('n', '<leader>bdn', function ()
    close_buffers.delete( { type = 'nameless' } )
    end,
    { desc = "Delete nameless buffers" }
)

map('n', '<leader>bdw', function ()
        close_buffers.wipe( { type = 'all', force = true} )
    end,
    { desc = "Wipe out all buffers" }
)

