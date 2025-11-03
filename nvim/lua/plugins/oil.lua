return {
    'stevearc/oil.nvim',
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            "icon",
            "size",
            "mtime",
        },
        delete_to_trash = true,
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    }
}
