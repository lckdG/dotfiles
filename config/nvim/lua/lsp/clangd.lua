local cmd = vim.fn.has("win32") == 1 and {
    vim.fn.expand("~") .. "/scoop/apps/clangd/current/bin/clangd"
} or {
    "clangd"
}

table.insert(cmd, "--background-index")
table.insert(cmd, "--clang-tidy")
table.insert(cmd, "--header-insertion=iwyu")

return {
    cmd = cmd,
    init_options = {
        fallbackFlags = { '-std=c++17' },
    },
}
