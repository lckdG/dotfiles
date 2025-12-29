local lua_ls = require('lsp.lua_ls')
local roslyn = require('lsp.roslyn')
local clangd = require('lsp.clangd')
local pyright = require('lsp.pyright')
local ts_ls = require('lsp.ts_ls')

return {
    lua_ls = lua_ls,
    roslyn = roslyn,
    clangd = clangd,
    pyright = pyright,
    ts_ls = ts_ls,
}

