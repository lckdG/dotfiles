@echo off

CALL scoop bucket add extras

CALL scoop install make llvm rustup
CALL scoop install ripgrep fd
CALL scoop install neovim

REM Unrem these if you want to use neovide
REM CALL scoop install neovide

REM Unrem these if you want to use wezterm
REM CALL scoop install wezterm

CALL scoop update *

CALL update-nvim.bat

