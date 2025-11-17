return {
    'oribarilan/lensline.nvim',
    event = 'LspAttach',
    config = function()
        require("lensline").setup({
            profiles = {
                {
                    name = "default",
                    providers = {
                        {
                            name = "usages",
                            enabled = true,
                            include = { "refs" },
                            breakdown = false,
                            show_zero = true,
                            labels = {
                                refs = "refs",
                                impls = "impls",
                                defs = "defs",
                                usages = "usages",
                            },
                            icon_for_single = "󰌹 ",
                            inner_separator = ", ",
                        },
                        {
                            name = "last_author",
                            enabled = false,
                            cache_max_files = 20,
                        },
                    },
                    style = {
                        separator = " • ",
                        highlight = "Comment",
                        prefix = "┃ ",
                        placement = "above",
                        use_nerdfont = true,
                        render = "all",
                    }
                }
            },
            limits = {
                exclude_append = {},       -- additional patterns to append to exclude list (empty by default)
                exclude_gitignored = true,  -- respect .gitignore by not processing ignored files
                max_lines = 1000,          -- process only first N lines of large files
                max_lenses = 70,          -- skip rendering if too many lenses generated
            },
            debounce_ms = 500,
            focused_debounce_ms = 150,
            silence_lsp = true,
            debug_mode = false,
        })
    end,
}
