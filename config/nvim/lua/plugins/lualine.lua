return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        require("lualine").setup {
            options = {
                theme = "gruvbox-material",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = { },
                lualine_x = { "%s", "searchcount" },
                lualine_y = { },
                lualine_z = { "filetype" },
            },
            inactive_sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = { },
                lualine_x = { "searchcount" },
                lualine_y = { },
                lualine_z = { "filetype" },
            },
            extensions = {

            },
        }
    end
}
