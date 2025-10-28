vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('QuitPre', {
    desc = 'Clear buffers when exiting Vim',
    group = vim.api.nvim_create_augroup('exit-clear-buffers', { clear = true }),
    callback = function ()
        require('close_buffers').delete( { type = 'hidden' })
    end
})

