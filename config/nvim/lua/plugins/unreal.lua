local function IgnoreDirToPattern(dir)
    local slash = package.config:sub(1, 1)
    return "%f[^" .. slash .. "%z]" .. dir .. slash
end

return {
    "lckdG/unreal.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        cmd_abbreviations = {
            uo  = "Project Open",
            uc  = "Build Clangd",
            uci = "Code Impl",
            ucm = "Code Macro",
            uss = "Code SwitchSourceHeader",
            ufs = "Search Files",
            ugs = "Search Grep",
        },
    },
    extensions = {
        telescope = {
            ignores = {
                "%.exe", -- Executables
                "%.dll",
                "%.lib",
                "%.modules", -- Libraries, modules, etc.
                "%.uasset",
                "%.umap",
                "%.pdb",
                "%.archive",
                "%.natvis", -- Unreal specific
                "%.po",
                "%.manifest", -- Localization assets
                "%.uexp",
                "%.dmp",
                "%.pb",
                "%.bin", -- Something I dont really know :)

                -- Generated Directories
                IgnoreDirToPattern("Binaries"),
                IgnoreDirToPattern("Build"),
                IgnoreDirToPattern("DerivedDataCache"),
                IgnoreDirToPattern("Intermediate"),
                IgnoreDirToPattern("Cooked"),
            },
        }
    }
}
