return {
    cmd = {
        "clangd",
        "--background-index",
        "-j=8",
        -- "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--enable-config",
    },
    init_options = {
        fallbackFlags = { '-std=c++20' },
    },
}
