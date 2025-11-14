return {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function ()
        vim.g.gruvbox_material_background = 'hard'
        vim.g.gruvbox_material_foreground = 'original'
        vim.g.gruvbox_material_statusline_style = 'mix'
        vim.g.gruvbox_material_float_style = "dim"
        vim.g.gruvbox_material_transparent_background = 1
    end
}
