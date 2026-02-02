return  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "BufReadPre",
    opts = {
        preset = "modern",
        options = {
            use_icons_from_diagnostic = true,
            show_related = {
                enabled = false,
            },
        },
    }
};
