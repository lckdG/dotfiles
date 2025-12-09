@echo off

CALL scoop bucket add extras

CALL scoop install make rustup
CALL scoop install ripgrep fd
CALL scoop install neovim

REM tree sitter setup
CALL cargo install --locked tree-sitter-cli

REM Install language servers
CALL scoop install lua-language-server clangd

REM Unrem these if you want to use neovide
REM CALL scoop install neovide

REM Unrem these if you want to use wezterm & starship
REM CALL scoop install wezterm starship

CALL scoop update *

CALL update-nvim.bat

