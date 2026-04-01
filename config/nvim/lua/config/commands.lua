local isWindows = vim.fn.has('win32') == 1

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

vim.api.nvim_create_user_command("LazyGit", function ()
    if Lazygit == nil then
        vim.notify("Error: no lazygit terminal is loaded", vim.log.levels.ERROR)
    else
        Lazygit:toggle()
    end
end, {})

vim.api.nvim_create_user_command("LspLog", function ()
    vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
end, {})

-- Unreal suite, to be moved
local function OpenUproject(fileName)
    local execCmd
    if isWindows then
        execCmd = '!./"' .. fileName .. '"'
    else
        error("No command for Linux set!", 2)
    end
    vim.cmd(execCmd, {})
end

vim.api.nvim_create_user_command("UnrealOpenProject", function ()
    local cmd
    if isWindows then
        cmd = "!Get-ChildItem -Path . -Filter '*.uproject' | Select-Object -ExpandProperty FullName"
    else
        cmd = "!find . -name '*.uproject'"
    end

    local cmdOut = vim.api.nvim_exec2(cmd, { output = true })
    local projectFiles = {}

    local skipFirst = true
    for file in string.gmatch(cmdOut.output, "[^\r\n]+") do
        if skipFirst then
            skipFirst = false
        else
            local fileName = vim.fs.basename(file)
            table.insert(projectFiles, fileName)
        end
    end

    if #projectFiles == 1 then
        OpenUproject(projectFiles[1])
    else
        local prompt = "Multiple uprojects found, choose one:\n"
        for index, file in ipairs(projectFiles) do
            prompt = prompt .. tostring(index) .. ": " .. file .. "\n"
        end

        vim.ui.input({ prompt = prompt }, function (input)
            if input == nil or input == "" then
                return
            end

            local chosen = tonumber(input)
            OpenUproject(projectFiles[chosen])
        end)
    end
end, {})

vim.api.nvim_create_user_command("UnrealRebuildClangd", function ()
    if isWindows then
        -- Temporary solution!
        vim.cmd("!./RebuildClang.bat")
    else
        error("No command for Linux set!", 2)
    end
end, {})

