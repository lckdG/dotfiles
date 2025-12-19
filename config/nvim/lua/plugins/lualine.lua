return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        require('lualine').setup {
            options = {
                theme = "codedark",
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = { 'filename' },
                lualine_x = { '%S', 'filetype' },
                lualine_y = { },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = { },
                lualine_b = { },
                lualine_c = { 'filename' },
                lualine_x = { 'filetype' },
                lualine_y = { },
                lualine_z = { 'location' },
            },
        }
    end
}
