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

