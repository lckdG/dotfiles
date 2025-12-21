return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "BufRead",
    init = function ()
        vim.g.no_plugin_maps = true
    end,
    config = function ()
        require('nvim-treesitter-textobjects').setup {
            select = {
                lookahead = true,
                include_surrounding_whitespace = false,
            },
            move = {
                set_jumps = false,
            },
        }
    end
}

