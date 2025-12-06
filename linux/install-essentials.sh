#!/bin/bash

# git operations
git config --global core.autocrlf input
git config --global credential.helper manager

# Main applications
sudo pacman -S git-lfs cmake fastfetch htop ibus-bamboo
sudo pacman -S ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono
sudo pacman -S fish wezterm code neovim

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install --locked tree-sitter-cli

# Language servers
sudo pacman -S lua-language-server
xdg-open https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.linux-x64/overview

# dotnet install
mkdir -p $HOME/Apps/dotnet
curl -L https://dot.net/v1/dotnet-install.sh -o $HOME/Apps/dotnet/dotnet-install.sh
chmod +x $HOME/Apps/dotnet/dotnet-install.sh
$HOME/Apps/dotnet/dotnet-install.sh --channel 9.0

# Apply configs
chmod +x update-nvim.sh update-wezterm.sh update-fish.sh
./update-nvim.sh
./update-wezterm.sh
./update-fish.sh

# AUR packages
yay -S google-chrome git-credential-manager-bin sourcegit pinta unityhub

