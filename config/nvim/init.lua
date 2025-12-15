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
vim.o.laststatus = 0

vim.g.telescope_enable_ignore_patterns = true

-- Session configs
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- File type correction
vim.filetype.add {
    extension = {
        shader = 'hlsl',
        hlsl = 'hlsl',
    },
}

-- Fold configs
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

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
elseif vim.fn.has("linux") then
    vim.o.shell = "/usr/bin/fish"
end

vim.loader.enable()

-- LazyVim
require("config.lazy")

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
