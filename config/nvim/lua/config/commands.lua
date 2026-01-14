-- Auto Session
vim.api.nvim_create_user_command("ReloadSession", function ()
    require('auto-session').restore_session(nil, { show_message = true, is_autorestore = false, is_startup_autorestore = false })
end, {})

-- Close buffers
vim.api.nvim_create_user_command("CloseHiddenBufs", function ()
    require('close_buffers').delete({ type = 'hidden', force = true })
end, {})
vim.api.nvim_create_user_command("CloseNamelessBufs", function ()
    require('close_buffers').delete({ type = 'nameless' })
end, {})

-- Quickfix list
vim.api.nvim_create_user_command("Quickfix", function()
    vim.ui.input({ prompt = "Enter severities (1=E, 2=W, 3=I, 4=H): "}, function (input)
        if input == nil or input == "" then
            return
        end

        local severities = {}
        for char in string.gmatch(input, "[1-4]") do
            table.insert(severities, tonumber(char))
        end

        vim.diagnostic.setqflist({
            severity = severities
        })
    end)
end, {})

vim.api.nvim_create_user_command("ClearTrailingSpaces", function ()
    vim.cmd([[ %s/\s\+\n/\r/g ]])
    vim.cmd([[ wa ]])
end, {})

