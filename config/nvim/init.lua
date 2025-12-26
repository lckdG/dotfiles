require('config.common')
require('config.filetypes')
require('config.lazy')

-- Colorscheme options: onedark, gruvbox-material, oldworld
local colorscheme = 'gruvbox-material'
vim.cmd('colorscheme ' .. colorscheme)

require('config.diagnostic')
require('config.keymaps')
require('config.autos')

-- StartUp Commands
vim.schedule(function ()
    vim.o.clipboard = 'unnamedplus'

    vim.o.cursorline = true
    vim.o.cursorlineopt = 'number'

    -- Required by harpoon
    require('harpoon'):setup()
end)
