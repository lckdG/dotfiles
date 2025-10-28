vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.guifont = 'JetBrainsMono Nerd Font:h13'
vim.o.termguicolors = true

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
require("config.keymaps")

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
-- Colorscheme options: onedark, kanagawa, gruvbox-material
    local colorscheme = 'gruvbox-material'
    vim.cmd('colorscheme ' .. colorscheme)
end)
