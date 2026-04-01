-- :h :cabbrev
local cabbr = vim.cmd.cabbrev

-- Abbrev builtin commands
cabbr("Qa", "qa")
cabbr("ch", "checkhealth")

-- Lazy.nvim
cabbr("Lz", "Lazy")
cabbr("lz", "Lazy")

-- Reload last session
cabbr("rl", "ReloadSession")

-- Lsp commands
cabbr("lsr", "lsp restart")
cabbr("lsl", "LspLog") -- Defined in commands.lua
cabbr("lss", "lsp start")
cabbr("lsS", "lsp stop")

-- Quickfix
cabbr("qf", "Quickfix")

-- Registers
cabbr("re", "reg")
cabbr("Reg", "reg")

cabbr("cts", "ClearTrailingSpaces")
cabbr("lg", "LazyGit")

