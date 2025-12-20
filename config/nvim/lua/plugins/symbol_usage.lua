local SymbolKind = vim.lsp.protocol.SymbolKind

return {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre',
    config = function ()
        require('symbol-usage').setup({
            filetypes = {
                cs = {
                    kinds = {
                        SymbolKind.Method,
                        SymbolKind.Event,
                        SymbolKind.Property,
                    },
                },
            }
        })
    end
}
