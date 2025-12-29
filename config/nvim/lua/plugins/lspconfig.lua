return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfigs = require('lsp')
        for server, config in pairs(lspconfigs) do
            vim.lsp.enable(server)
            vim.lsp.config(server, config)
        end
    end
}

