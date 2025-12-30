local M = {}

M.initialize = function()
    require('config.common')
    require('config.lazy')
end

M.hook_workflow = function ()
    require('config.filetypes')
    require('config.diagnostic')
    require('config.keymaps')
    require('config.autos')
end

M.hook_commands = function ()
    require('config.abbrevs')
    require('config.commands')
end

return M
