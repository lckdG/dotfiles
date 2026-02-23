return {
    'stevearc/oil.nvim',
    cmd = "Oil",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
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
        },
        use_default_keymaps = false,
        keymaps = {
            ["?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-p>"] = "actions.preview",
            ["<C-q>"] = { "actions.close", mode = "n" },
            ["<C-r>"] = "actions.refresh",
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["<C-o>"] = "actions.open_external",
            ["<C-h>"] = { "actions.toggle_hidden", mode = "n" },
            ["<C-t>"] = { "actions.toggle_trash", mode = "n" },
        }
    },
}
