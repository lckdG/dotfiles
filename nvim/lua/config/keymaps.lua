local map = vim.keymap.set

-- Keymaps
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', 'n', 'nzz')
map('n', '<S-n>', '<S-n>zz')

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
map('', '<C-S-e>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neotree' } )

map('n', '<C-Tab>', '<cmd>tabn<CR>', { desc = 'Go to next tab' } )
map('n', '<C-S-Tab>', '<cmd>tabp<CR>', { desc = 'Go to previous tab' } )

map('n', '<C-q>', '<cmd>close<CR>', { desc = 'Close current buffer' } )

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


-- ToggleTerm
map('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" } )
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Move to left window" } )
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Move to bottom window" } )
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Move to above window" } )
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Move to right window" } )

map('n', '<C-`>', [[<Cmd>ToggleTerm<CR>]], { desc = "Toggle the terminal" } )
map('t', '<C-`>', [[<Cmd>ToggleTermToggleAll<CR>]] )

