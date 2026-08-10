local function create_custom_theme()
    local custom_theme = require 'lualine.themes.gruvbox-material'
    local modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }

    for _, mode in ipairs(modes) do
        local theme_mode = custom_theme[mode]
        if theme_mode then
            if theme_mode.z then
                theme_mode.z.gui = "None"
            elseif theme_mode.a then
                local a = theme_mode.a
                theme_mode.z = { bg = a.bg, fg = a.fg }
            end

            if theme_mode.c then
                theme_mode.c.bg = "282828"
            end
        end
    end

    return custom_theme
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        local custom_theme = create_custom_theme()

        require("lualine").setup {
            options = {
                theme = custom_theme,
                section_separators = { left = "", right = ""},
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = { },
                lualine_x = { "%S", "searchcount" },
                lualine_y = { "filetype", "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = { },
                lualine_x = { "searchcount" },
                lualine_y = { "progress" },
                lualine_z = { "filetype" },
            },
            extensions = {
                "quickfix",
            },
        }
    end
}
