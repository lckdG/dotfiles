local config = require('config')
config.initialize()

-- Colorscheme options: onedark, gruvbox-material, oldworld
local colorscheme = 'gruvbox-material'
vim.cmd('colorscheme ' .. colorscheme)

config.hook_workflow()
config.hook_commands()

-- StartUp Commands
vim.schedule(function ()
    vim.o.clipboard = 'unnamedplus'

    vim.o.cursorline = true
    vim.o.cursorlineopt = 'number'

    -- Required by harpoon
    require('harpoon'):setup()
end)
