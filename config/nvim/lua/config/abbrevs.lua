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
cabbr("lsr", "LspRestart")
cabbr("lsl", "LspLog")
cabbr("lss", "LspStart")
cabbr("lsS", "LspStop")

-- Quickfix
cabbr("qf", "Quickfix")

-- Registers
cabbr("re", "reg")
cabbr("Reg", "reg")

