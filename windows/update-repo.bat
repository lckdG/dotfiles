@echo off
robocopy %UserProfile%\AppData\Local\nvim nvim /mir

if exist %UserProfile%\.wezterm.lua (
    if not exist wezterm mkdir wezterm
    copy %UserProfile%\.wezterm.lua wezterm\.wezterm.lua
    echo Sync .wezterm.lua completed
) else (
    echo No .wezterm.lua file found, skip wezterm sync
)

PAUSE

