@echo off

call rmdir %LOCALAPPDATA%\nvim
call del %USERPROFILE%\.wezterm.lua
call rmdir %LOCALAPPDATA%\lazygit

call mklink /D %LOCALAPPDATA%\nvim %~dp0..\config\nvim
call mklink %USERPROFILE%\.wezterm.lua %~dp0..\config\wezterm\wezterm.lua
call mklink /D %LOCALAPPDATA%\lazygit %~dp0..\config\lazygit

pause
