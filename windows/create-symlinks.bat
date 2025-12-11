@echo off

call rmdir %LOCALAPPDATA%\nvim
call del %LOCALAPPDATA%\wezterm.lua

call mklink /D %LOCALAPPDATA%\nvim %~dp0..\.config\nvim
call mklink %USERPROFILE%\.wezterm.lua %~dp0..\.config\wezterm\wezterm.lua

pause
