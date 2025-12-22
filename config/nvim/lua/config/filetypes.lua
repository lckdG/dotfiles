vim.filetype.add {
    extension = {
        shader = 'glsl',
        cginc = 'glsl',
    },
    pattern = {
        ['%jenkinsfile.*'] = 'groovy',
    },
}
