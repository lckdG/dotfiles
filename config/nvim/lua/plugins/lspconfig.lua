return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
        local lsp_configs = {}

        for _, f in ipairs(vim.fn.readdir(lsp_dir)) do
            local server_name = f:gsub("%.lua", "")
            table.insert(lsp_configs, server_name)
        end

        vim.lsp.enable(lsp_configs)
    end
}

