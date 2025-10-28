@echo off

CALL scoop bucket add extras

CALL scoop install lua luarocks lua-language-server
CALL scoop install make ripgrep fd
CALL scoop install neovim

REM Unrem these if you want to install msys2 & gcc
REM IMPORTANT: by default, gcc is not added to system PATH, please do it manually
REM CALL scoop install msys2
REM CALL msys2 -no-start -msys -c "pacman -S --noconfirm mingw-w64-ucrt-x86_64-gcc"

REM Unrem these if you want to use neovide
REM CALL scoop install rustup neovide

CALL update-nvim.bat

