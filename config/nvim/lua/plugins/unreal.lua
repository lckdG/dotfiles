return {
    "lckdG/unreal.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        cmd_abbreviations = {
            uo  = "OpenProject",
            uc  = "RebuildClangd",
            uss = "SwitchSourceHeader",
            uci = "CreateImpl",
            ucm = "CompleteMacro",
            ufs = "FindSource",
            ugs = "GrepSource",
        },
    }
}
