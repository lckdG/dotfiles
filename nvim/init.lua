vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.guifont = 'JetBrainsMono Nerd Font:h13'
vim.o.termguicolors = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 5

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.breakindent = true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250
vim.o.timeoutlen = 250

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ' , trail = '•', nbsp = '␣' }

vim.o.inccommand = 'split'
vim.o.confirm = true

-- Session configs
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- File type correction
vim.filetype.add {
    shader = 'hlsl',
    hlsl = 'hlsl'
}

if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.9
    vim.g.neovide_cursor_animate_command_line = false
end

if vim.fn.has("win32") then
    -- Set ups for using powershell with nvim
    vim.o.shell = "powershell.exe"
    vim.o.shellxquote = ''
    vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    vim.o.shellquote = ''
    vim.o.shellpipe = '| Out-File -Encoding UTF8 %s'
    vim.o.shellredir = '| Out-File -Encoding UTF8 %s'
end

vim.loader.enable()

-- LazyVim
require("config.lazy")
require('nvim-treesitter.install').compilers = { "clang", "gcc" }

-- Colorscheme options: onedark, gruvbox-material, oldworld
-- Remember to change lazy.lua to load the correct theme!
local colorscheme = 'gruvbox-material'
vim.cmd('colorscheme ' .. colorscheme)

require("config.keymaps")
require("config.autos")

-- StartUp Commands
vim.schedule(function ()
    vim.o.clipboard = 'unnamedplus'

    vim.o.cursorline = true
    vim.o.cursorlineopt = 'number'

    -- Required by harpoon
    require("harpoon"):setup()
end)
