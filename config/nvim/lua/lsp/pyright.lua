local mason_path = vim.fn.stdpath('data') .. '/mason/bin/'

local bin = nil
for _, name in ipairs({ 'basedpyright-langserver', 'pyright-langserver' }) do
    local mason_bin = mason_path .. name
    if vim.fn.executable(mason_bin) == 1 then
        bin = mason_bin
        break
    end

    local sys_bin = vim.fn.exepath(name)
    if sys_bin ~= '' then
        bin = sys_bin
    end
end

return bin and {
    cmd = { bin, '--stdio' },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = false,
                typeCheckingMode = "off"
            }
        }
    }
} or {}
