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

-- LazyVim
require("config.lazy")
require('nvim-treesitter.install').compilers = { "clang", "gcc" }

-- Required by harpoon
require("harpoon"):setup()

require("config.keymaps")
require("config.autos")

-- Session configs
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- File type correction
vim.filetype.add {
    shader = 'hlsl',
    hlsl = 'hlsl'
}

vim.lsp.enable("lua_ls")
vim.lsp.enable("roslyn_ls")
vim.lsp.enable("clangd")
vim.lsp.enable('pyright')

-- StartUp Commands
vim.schedule(function ()
    vim.o.clipboard = 'unnamedplus'

-- Colorscheme options: onedark, kanagawa, gruvbox-material
-- Remember to change lazy.lua to load the correct theme!
    local colorscheme = 'onedark'
    vim.cmd('colorscheme ' .. colorscheme)

    vim.o.cursorline = true
    vim.o.cursorlineopt = 'number'
end)
