return {
    'saghen/blink.cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    version = '1.*',
    build = 'cargo build --release',
    dependencies = {

    },
    opts = function(_, opts)
        opts.enabled = function ()
            local filetype = vim.bo[0].filetype
            if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
                return false
            end

            return true
        end

        opts.keymap = {
            preset = 'default',
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<Esc>"] = { "hide", "fallback" },
            ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
            ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
        }

        opts.completion = {
            menu = {
                border = "single"
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 250
            },
        }

        opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
            providers = {
                lazydev = { module = "lazydev.integrations.blink", score_offset =  100 }
            },
        })

        opts.cmdline = {
            enabled = true
        }

        -- opts.signature = { enabled = true }
    end,
}
