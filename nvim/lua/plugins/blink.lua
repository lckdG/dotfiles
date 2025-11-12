return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    version = '1.*',
    build = 'cargo build --release',
    dependencies = {
        'folke/lazydev.nvim',
    },
    opts = {
        keymap = {
            preset = 'default',
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Esc>"] = { "hide", "fallback" },
            ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
            ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
        }
    },
    appearance = {
        nerd_font_variant = 'mono',
    },
    completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 250 },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
}
