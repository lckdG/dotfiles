local cmd = vim.fn.has("win32") == 1 and {
    vim.fn.expand("~") .. "/scoop/apps/clangd/current/bin/clangd"
} or {
    "clangd"
}

return {
    cmd = cmd,
}
