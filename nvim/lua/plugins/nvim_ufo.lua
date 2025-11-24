return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        prodiver_selector = function (bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
        end
    }
}
