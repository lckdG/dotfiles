return {
    "nvim-flutter/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim', -- For vim.ui.select
    },
    config = function ()
        require('flutter-tools').setup({
            -- Empty for now
        })
    end
}
