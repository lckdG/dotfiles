return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        require("lualine").setup {
            options = {
                theme = "codedark",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = { },
                lualine_x = { "%S", "searchcount" },
                lualine_y = { "filetype" },
                lualine_z = { "location" },
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
