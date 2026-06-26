@echo off

CALL scoop bucket add extras

CALL scoop install make rustup
CALL scoop install 7zip fd fzf imagemagick jq poppler zoxide
CALL scoop install neovim yazi lazygit

REM tree sitter setup
CALL cargo install --locked tree-sitter-cli

REM Unrem these if you want to use neovide
REM CALL scoop install neovide

REM Unrem these if you want to use wezterm & starship
REM CALL scoop install wezterm starship

CALL scoop update *

