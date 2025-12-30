return {
    "rmagatti/auto-session",
    lazy = true,
    cmd = "AutoSession",
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_save = false,
    },
}
