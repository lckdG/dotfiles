#!/bin/bash

cd ~

sudo add-apt-repository ppa:dotnet/backports
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y ninja-build gettext cmake curl build-essential unzip dotnet-sdk-9.0

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly

git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Config dir: ~/.config/nvim
# Data dir: ~/.local/share/nvim

