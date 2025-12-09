#!/bin/bash

rsync -vr $HOME/.config/nvim/ nvim/
rsync -vr $HOME/.config/wezterm/wezterm.lua wezterm/.wezterm.lua
rsync -vr $HOME/.config/fish/config.fish fish/config.fish
