return {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    build = 'cargo build --release',
    dependencies = {
    {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
        end
        return 'make install_jsregexp'
        end)(),
        dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        -- {
        --   'rafamadriz/friendly-snippets',
        --   config = function()
        --     require('luasnip.loaders.from_vscode').lazy_load()
        --   end,
        -- },
        },
        opts = {},
    },
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
