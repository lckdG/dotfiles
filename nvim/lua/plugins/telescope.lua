local ignore_patterns = {
    ".wav", ".flac", ".mp3", ".bnk", -- Sounds
    ".mesh", ".fbx", ".obj", -- 3D models
    ".otf$", ".ttf$", -- Fonts
    ".exe", -- Executables
    ".asmdef", ".dll", -- Libraries
    ".tga$", ".png$", ".jpg$", ".jpeg$", ".psd$", ".gif$", ".tif$", ".svg$", -- Images, phew
    ".unity$", ".prefab$", ".anim$", ".mesh$", -- Unity specific, but don't ignore the .metas
}

return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }
    },
    config = function ()
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                theme = 'dropdown',
                layout_strategy = 'vertical',
                layout_config = {
                    prompt_position = 'bottom',
                    width = 0.75,
                    height = 0.9,
                    preview_height = 0.5,
                },
                file_ignore_patterns = ignore_patterns,
            },
        })

        telescope.load_extension('fzf')
    end
}
