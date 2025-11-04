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


vim.api.nvim_create_autocmd('QuitPre', {
    desc = 'Auto handles when exiting Vim',
    group = vim.api.nvim_create_augroup('exit-clear-buffers', { clear = true }),
    callback = function ()
        local auto_session_config = require('auto-session.config')
        if auto_session_config.enabled then
            require('close_buffers').delete( { type = 'hidden' })
            require('auto-session').save_session()
        end
    end
})

