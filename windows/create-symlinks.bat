@echo off

if not exist %USERPROFILE%\.config mkdir %USERPROFILE%\.config

call rmdir %LOCALAPPDATA%\nvim
call rmdir %USERPROFILE%\.config\wezterm
call rmdir %LOCALAPPDATA%\lazygit

call mklink /D %LOCALAPPDATA%\nvim %~dp0..\config\nvim
call mklink /D %USERPROFILE%\.config\wezterm %~dp0..\config\wezterm
call mklink /D %LOCALAPPDATA%\lazygit %~dp0..\config\lazygit

pause
