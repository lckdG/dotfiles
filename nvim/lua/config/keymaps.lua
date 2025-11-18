local map = vim.keymap.set

map('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Keymaps
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

map('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Search and focus
map('n', 'n', 'nzz')
map('n', '<S-n>', '<S-n>zz')

-- Quick line editing
map('n', '<leader>a;', '<S-a>;<Esc>', { desc = "Add a semicolon to EOL" })
map('n', '<leader>a,', '<S-a>,<Esc>', { desc = "Add a comma to EOL" })
map('i', 'uu', 'jko{<CR>', { remap = true, silent = true })
map('i', 'u;', 'jk<S-a>;<CR>', { remap = true, silent = true })

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
map({ 'n', 'v' }, '<leader>pc', '"+p', { desc = "Paste below from the system clipboard" })
map({ 'n', 'v' }, '<leader>PC', '"+P', { desc = "Paste here from the system clipboard" })
map({ 'n', 'v' }, '<leader>py', '"0p', { desc = "Paste below last yanked text" })
map({ 'n', 'v' }, '<leader>PY', '"0P', { desc = "Paste here last yanked text" })

-- Focus switching
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' } )
map('n', '<leader>tb', '<cmd>tabp<CR>', { desc = 'Go to previous tab' } )

-- Tab splitting
map('n', '<C-Down>', '<cmd>split<CR>', { desc = 'Split window horizontally' })
map('n', '<C-Right>', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- Telescope
map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Telescope fuzzy find files' })
map('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Telescope live grep' })
map('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Telescope buffers' })
map('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Telescope help tags' })
map('n', '<leader>tt', '<cmd>Telescope colorscheme<CR>', { noremap = true, silent = true, desc = 'Open colorscheme picker' })

-- Close buffers
map('n', '<leader>bdh', function()
        require('close_buffers').delete( { type = 'hidden', force = true } )
    end,
    { desc = "Delete all hidden buffers" }
)

map('n', '<leader>bdn', function ()
    require('close_buffers').delete( { type = 'nameless' } )
    end,
    { desc = "Delete nameless buffers" }
)

map('n', '<leader>bdw', function ()
        require('close_buffers').wipe( { type = 'all', force = true } )
    end,
    { desc = "Wipe out all buffers" }
)

-- Harpoon
map('n', '<leader>he', function()
    local harpoon = require('harpoon')
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon window" })
map('n', '<leader>ha', function() require('harpoon'):list():add() end, { desc = "Add file to harpoon" })

map('n', '<leader>h1', function () require('harpoon'):list():select(1) end, { desc = "Jump to 1st file in harpoon list" })
map('n', '<leader>h2', function () require('harpoon'):list():select(2) end, { desc = "Jump to 2nd file in harpoon list" })
map('n', '<leader>h3', function () require('harpoon'):list():select(3) end, { desc = "Jump to 3rd file in harpoon list" })
map('n', '<leader>h4', function () require('harpoon'):list():select(4) end, { desc = "Jump to 4th file in harpoon list" })

map('n', '<leader>hn', function () require('harpoon'):list():next() end, { desc = "Jump to next file in harpoon list" })
map('n', '<leader>hb', function () require('harpoon'):list():prev() end, { desc = "Jump to previous file in harpoon list" })

-- Oil
map('n', '<leader>e', '<cmd>Oil --float<CR>', { silent = true, desc = "Open parent directory" })

-- Auto Session
map('', '<F8>', function()
    require("auto-session").restore_session(nil, { show_message = true, is_autorestore = false, is_startup_autorestore = false } )
end)

