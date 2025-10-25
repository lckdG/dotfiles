vim.g.mapleader = '<Space>'
vim.g.maplocalleader = '<Space>'

vim.o.guifont = 'JetBrainsMono Nerd Font:h13'

vim.o.number = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ' , trail = '•', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.confirm = true

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>» ')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = "Quick save, in windows style" })

-- Focus switching
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Tab splitting
vim.keymap.set('n', '<C-Down>', '<cmd>split<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<C-Right>', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- To quickly open Neotree
vim.keymap.set('', '<C-S-e>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neotree'} )
vim.keymap.set('n', '<C-S-Tab>', '<cmd>tabp<CR>', { desc = 'Go to previous tab'} )

vim.keymap.set('n', '<C-q>', '<cmd>close<CR>', { desc = 'Close current buffer'} )

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set ups for using powershell with nvim
vim.o.shell = "powershell.exe"
vim.o.shellxquote = ''
vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
vim.o.shellquote = ''
vim.o.shellpipe = '| Out-File -Encoding UTF8 %s'
vim.o.shellredir = '| Out-File -Encoding UTF8 %s'

-- LazyVim
require("config.lazy")
require('onedark').load()

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })

vim.lsp.enable("lua_ls")
vim.lsp.enable("roslyn_ls")
vim.lsp.enable("clangd")
vim.lsp.enable('pyright')

-- StartUp Commands
vim.schedule(function ()
    vim.cmd("Neotree")
end)
