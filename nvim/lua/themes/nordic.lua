return {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('nordic').setup({
            bright_border = true,
            telescope = {
                style = 'classic',
            },
        })
    end
}
