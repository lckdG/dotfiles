return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--enable-config",
    },
    init_options = {
        fallbackFlags = { '-std=c++17' },
    },
}
