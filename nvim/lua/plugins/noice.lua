return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lsp = {
            progress = {
                enabled = false,
            },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 7,
                    col = "50%",
                },
            },
            confirm = {
                position = {
                    row = 12,
                    col = "50%",
                },
            },
        },
    },
}
