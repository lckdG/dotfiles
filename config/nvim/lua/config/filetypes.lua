vim.filetype.add {
    extension = {
        shader = 'glsl',
        cginc = 'glsl',
        hlsl = 'glsl',
    },
    pattern = {
        ["[Jj]enkinsfile.*"] = 'groovy',
    },
    filename = {
        [".clangd"] = 'yaml',
    }
}

local ft_augroup = vim.api.nvim_create_augroup('ft_settings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = "dart",
    group = ft_augroup,
    callback = function ()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = "yaml",
    group = ft_augroup,
    callback = function ()
        vim.opt_local.expandtab = false
    end
})
