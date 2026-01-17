local map = vim.keymap.set
map('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Keymaps
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map({ 'n', 'o', 'x' }, '<A-r>', '"', { noremap = true, silent = true, desc = "Registers" })

-- Search and focus
map('n', 'n', 'nzz')
map('n', '<S-n>', '<S-n>zz')

-- Quick line editing
map('n', '<leader>a;', '<S-a>;<Esc>', { desc = "Add a semicolon to EOL" })
map('n', '<leader>a,', '<S-a>,<Esc>', { desc = "Add a comma to EOL" })

-- Fake insert leader
map('i', '<C-e>b', "<C-c>o{<CR>", { remap = true, silent = true })
map('i', '<C-e>,', "<C-c><S-a>,", { remap = true, silent = true })
map('i', '<C-e>;', "<C-c><S-a>;", { remap = true, silent = true })

-- -- C++ specific
map('i', '<C-e>-', "->", { remap = true, silent = true })
map('i', '<C-e>s', "::", { remap = true, silent = true })

map('n', '<A-j>', ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
map('n', '<A-k>', ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move block up" })

map('', "H", "^", { noremap = true, desc = "^" })
map('', "L", "$", { noremap = true, desc = "$" })

map('n', '<C-q>', '<cmd>close<CR>', { desc = 'Close current buffer' } )
map('n', '<C-s>', '<cmd>w<CR>', { desc = "Quick save, in windows style" })

-- Windows manipulations
-- -- Focus
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- -- Tab splitting
map('n', '<leader>hs', '<cmd>split<CR>', { desc = 'Split window horizontally' })
map('n', '<leader>vs', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- -- Tab Sizing
local windowStep = 2
map('n', '<C-Right>', windowStep .. '<C-w>>', { desc = 'Increase window width', remap = true, silent = true } )
map('n', '<C-Left>', windowStep .. '<C-w><', { desc = 'Decrease window width', remap = true, silent = true } )
map('n', '<C-Up>', windowStep .. '<C-w>+', { desc = 'Increase window height', remap = true, silent = true } )
map('n', '<C-Down>', windowStep .. '<C-w>-', { desc = 'Decease window height', remap = true, silent = true } )

-- Telescope
map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Telescope fuzzy find files' })
map('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Telescope live grep' })
map('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Telescope buffers' })
map('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Telescope help tags' })
map('n', '<leader>tc', function () require('telescope.builtin').colorscheme() end, { noremap = true, silent = true, desc = 'Open colorscheme picker' })
map('n', '<leader>fs', function () require('telescope.builtin').grep_string() end, { desc = "Telescope grep string under the cursor" })

map('n', '<leader>ti', function ()
    vim.g.telescope_enable_ignore_patterns = not vim.g.telescope_enable_ignore_patterns

    require('telescope.config').set_defaults({
        file_ignore_patterns = vim.g.telescope_enable_ignore_patterns and telescope_ignore_patterns or {},
    })
end, { noremap = true, desc = "Toggle Telescope ignore patterns"})

-- Harpoon
map('n', '<leader>he', function()
    local harpoon = require('harpoon')
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon window" })

map('n', '<leader>ha', function() require('harpoon'):list():add() end, { desc = "Add file to harpoon" })
map('n', '<leader>hn', function () require('harpoon'):list():next() end, { desc = "Jump to next file in harpoon list" })
map('n', '<leader>hb', function () require('harpoon'):list():prev() end, { desc = "Jump to previous file in harpoon list" })

local harpoon_item_count = 6
for i = 1, harpoon_item_count, 1 do
    local keymap = '<leader>h' .. i
    local desc = "Jump to item #" .. i .. " in harpoon list"
    map('n',keymap, function () require('harpoon'):list():select(i) end, { desc = desc })
end

-- Oil
map('n', '<leader>e', '<cmd>Oil --float<CR>', { silent = true, desc = "Open parent directory" })

-- UFO
map('n', 'zR', function () require('ufo').openAllFolds() end)
map('n', 'zM', function () require('ufo').closeAllFolds() end)

-- Text objects
-- -- Selections
map({'x', 'o'}, 'af', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
end, { desc = "outer a function" } )

map({'x', 'o'}, 'if', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
end, { desc = "inner a function" } )

map({'x', 'o'}, 'ac', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@call.outer', 'textobjects')
end, { desc = "outer a call" } )

map({'x', 'o'}, 'ic', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@call.inner', 'textobjects')
end, { desc = "inner a call" } )

map({'x', 'o'}, 'ad', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@comment.outer', 'textobjects')
end, { desc = "outer a comment block" } )

map({'x', 'o'}, 'id', function()
    require('nvim-treesitter-textobjects.select').select_textobject('@comment.inner', 'textobjects')
end, { desc = "inner a comment block" } )

map({'x', 'o'}, 'as', 'a"', { remap = true, desc = 'outer ""' })
map({'x', 'o'}, 'is', 'i"', { remap = true, desc = 'inner ""' })

-- -- Jumps
map({'n', 'x', 'o'}, ']f', function ()
    require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
    vim.cmd("normal! zz")
end, { desc = "Jump to next function start" } )

map({'n', 'x', 'o'}, ']F', function ()
    require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
    vim.cmd("normal! zz")
end, { desc = "Jump to next function end" } )

map({'n', 'x', 'o'}, '[f', function ()
    require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
    vim.cmd("normal! zz")
end, { desc = "Jump to previous function start" } )

map({'n', 'x', 'o'}, '[F', function ()
    require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
    vim.cmd("normal! zz")
end, { desc = "Jump to previous function end" } )

-- ToggleTerm

map('n', '<leader>ttf', function ()
    vim.cmd("ToggleTerm direction=float")
end, { silent = true, desc = "Open floating terminal" })

map('n', '<leader>ttv', function()
    vim.cmd("ToggleTerm direction=vertical")
end, { silent = true, desc = "Open a vertical terminal" })

map('n', '<leader>tth', function()
    vim.cmd("ToggleTerm direction=horizontal")
end, { silent = true, desc = "Open a horizontal terminal" })

map('n', '<leader>ttn', function()
    vim.cmd("TermNew")
end, { silent = true, desc = "Open a new terminal, in current direction" })

map('n', '<leader>tts', function()
    vim.cmd("TermSelect")
end, { silent = true, desc = "Select a terminal to open" })

map('n', '<leader>ttr', function()
    vim.cmd("ToggleTermSetName")
end, { silent = true, desc = "Set name to a terminal" })

map('n', '<leader>ttc', function()
    vim.cmd("ToggleTerm")
end, { silent = true, desc = "Toggle terminal states"})

