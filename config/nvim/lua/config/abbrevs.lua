-- :h :cabbrev
local cabbr = vim.cmd.cabbrev

-- Abbrev builtin commands
cabbr("Qa", "qa")
cabbr("ch", "checkhealth")

-- Lazy.nvim
cabbr("Lz", "Lazy")
cabbr("lz", "Lazy")

-- Lsp commands
cabbr("lsr", "LspRestart")
cabbr("lsl", "LspLog")
cabbr("lss", "LspStart")
cabbr("lsS", "LspStop")

