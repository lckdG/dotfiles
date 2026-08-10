return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--enable-config",
        "-j=8"
    },
    init_options = {
        fallbackFlags = { '-std=c++20' },
    },
}
