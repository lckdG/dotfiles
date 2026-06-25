return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
    init_options = {
        fallbackFlags = { '-std=c++17' },
    },
}
