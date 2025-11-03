return {
    'stevearc/oil.nvim',
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            "icon",
            "size",
            -- "mtime",
        },
        delete_to_trash = true,
        watch_for_changes = true,
        view_options = {
            natural_order = true,
        },
        float = {
            border = "rounded",
            preview_split = "above",
        }
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    }
}
