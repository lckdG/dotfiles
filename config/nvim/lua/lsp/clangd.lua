local cmd = vim.fn.has("win32") == 1 and {
    vim.fn.expand("~") .. "/scoop/apps/clangd/current/bin/clangd"
} or {
    "clangd"
}

table.insert(cmd, "--background-index")
table.insert(cmd, "--clang-tidy")

return {
    cmd = cmd,
}
