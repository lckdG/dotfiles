local ensure_installed = {
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'c_sharp',
    'cpp',
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = true,
    event = "BufRead",
    build = ":TSUpdate",
    config = function ()
        require("nvim-treesitter").install(ensure_installed)
        for _, parser in ipairs(ensure_installed) do
            local filetypes = parser
            vim.treesitter.language.register(parser, filetypes)

            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = filetypes,
                callback = function (event)
                    vim.treesitter.start(event.buf, parser)
                end,
            })
        end

        vim.api.nvim_create_autocmd({ "BufRead" }, {
            callback = function (event)
                local bufnr = event.buf
                local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

                if filetype == "" then
                    return
                end

                for _, installed in ipairs(ensure_installed) do
                    if filetype == installed then
                        return
                    end
                end

                local parser_name = vim.treesitter.language.get_lang(filetype)
                if not parser_name then
                    return
                end

                local parser_configs = require("nvim-treesitter.parsers")
                if not parser_configs[parser_name] then
                    return
                end

                local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
                if not parser_installed then
                    require("nvim-treesitter").install( { parser_name } ):wait(30000)
                end

                parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
                if parser_installed then
                    vim.treesitter.start(bufnr, parser_name)
                end
            end
        })
    end
}
