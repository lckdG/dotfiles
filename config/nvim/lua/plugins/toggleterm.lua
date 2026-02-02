return {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermNew", "TermSelect" },
    event = { "CmdlineEnter" },
    config = function ()
        require('toggleterm').setup {}

        -- Lazygit integration
        local Terminal = require('toggleterm.terminal').Terminal
        Lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            on_open = function (term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", '<Esc>', '<Esc>', { noremap = true })
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-q>", "<Cmd>close<CR>", { noremap = true, silent = true })
            end,

            on_close = function (term)
                vim.cmd("startinsert!")
            end
        })
    end
}
