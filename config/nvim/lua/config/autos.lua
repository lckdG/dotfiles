vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grr', require('telescope.builtin').lsp_references, '[G]o to [R]eferences')
        map('gri', require('telescope.builtin').lsp_implementations, '[G]o to [I]mplementation')
        map('grd', require('telescope.builtin').lsp_definitions, '[G]o to [D]efinition')
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
        map('gf', function ()
            vim.lsp.buf.format()
        end, 'Format document', { 'n', 'v', 'x' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }), callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                end,
            })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function ()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
    desc = 'Auto handles when exiting Vim',
    group = vim.api.nvim_create_augroup('exit-cleanup', { clear = true }),
    callback = function ()
        local auto_session_config = require('auto-session.config')
        if auto_session_config.enabled then
            -- require('close_buffers').delete( { type = 'hidden' } )
            require('auto-session').save_session()
        end
    end
})

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = { "term://*" },
    group = vim.api.nvim_create_augroup('toggleterm-attach', { clear = true }),
    callback = function ()
        local opts = { buffer = 0 }
        local map = vim.keymap.set

        map('t', '<Esc>', [[ <C-\><C-n> ]], opts)
        map('t', '<C-h>', [[ <Cmd>wincmd h<CR> ]], opts)
        map('t', '<C-j>', [[ <Cmd>wincmd j<CR> ]], opts)
        map('t', '<C-k>', [[ <Cmd>wincmd k<CR> ]], opts)
        map('t', '<C-l>', [[ <Cmd>wincmd l<CR> ]], opts)
        map('t', '<C-q>', [[ <Cmd>wincmd q<CR> ]], opts)
    end
})

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

---@class (exact) UprojectFindOpts
---@field nameOnly boolean

-- For Unreal, to be moved
-- Still need testing and preparing for Linux
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('unreal-attach', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client == nil or client.name ~= "clangd" then
            return
        end

        ---Find uproject files in current directory
        ---@param opts UprojectFindOpts
        ---@return table
        local function findUprojects(opts)
            if opts == nil then
                opts = { nameOnly = false }
            end

            local files = vim.fs.find(function(name, _)
                return name:match('.*%.uproject')
            end, { type = "file" })

            if opts.nameOnly then
                local result = {}
                for _, file in ipairs(files) do
                    table.insert(result, vim.fs.basename(file))
                end

                return result
            end

            return files
        end

        -- Only enable if any uproject file is found
        local uprojectFiles = findUprojects { nameOnly = false }

        if #uprojectFiles == 0 then
            return
        end

        -- Switching between source and header files, with custom search, fallback to LSP function if the search fails
        vim.api.nvim_create_user_command("SwitchSourceHeader", function ()
            local extension = vim.fn.expand("%:t:e")
            local desiredExt = extension == "cpp" and "h" or "cpp"

            local fileName = vim.fn.expand("%:t:r")
            local switchingFiles = vim.fs.find(function (name, _)
                return name:match(fileName .. "%." .. desiredExt)
            end, { limit = 1, type = "file", path = "Source" })

            if #switchingFiles > 0 then
                vim.cmd("e " .. switchingFiles[1])
            else
                vim.cmd("LspClangdSwitchSourceHeader")
            end
        end, {})

        local isWindows = vim.fn.has('win32') == 1
        local function OpenUproject(fileName)
            local execCmd
            if isWindows then
                execCmd = '!./"' .. fileName .. '"'
            else
                error("No command for Linux set!", 2)
            end
            vim.cmd(execCmd, {})
        end

        vim.api.nvim_create_user_command("UnrealOpenProject", function ()
            local projectFiles = findUprojects { nameOnly = true }

            if #projectFiles == 1 then
                OpenUproject(projectFiles[1])
            else
                local prompt = "Multiple uprojects found, choose one:\n"
                for index, file in ipairs(projectFiles) do
                    prompt = prompt .. tostring(index) .. ": " .. file .. "\n"
                end

                vim.ui.input({ prompt = prompt }, function (input)
                    if input == nil or input == "" then
                        return
                    end

                    local chosen = tonumber(input)
                    OpenUproject(projectFiles[chosen])
                end)
            end
        end, {})

        vim.api.nvim_create_user_command("UnrealRebuildClangd", function ()
            if isWindows then
                -- Temporary solution!
                vim.cmd("!./RebuildClang.bat")
            else
                error("No command for Linux set!", 2)
            end
        end, {})

        -- Abbreviations
        local cabbr = vim.cmd.cabbrev
        local iabbr = vim.cmd.iabbrev

        cabbr("uo", "UnrealOpenProject")
        cabbr("uc", "UnrealRebuildClangd")
        cabbr("ss", "SwitchSourceHeader")

        iabbr("upr", "UPROPERTY()<Left>")
    end,
})
