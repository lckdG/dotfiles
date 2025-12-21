return {
    "j-hui/fidget.nvim",
    version = "*",
    opts = {
        progress = {
            display = {
                render_limit = 8,
                done_ttl = 2,
            }
        },
        notification = {
            override_vim_notify = true,
            window = {
                winblend = 0,
            },
        },
    }
}
