# Linux configurations

I switched to Linux after a while working with distraction and slowness on Windows.

Back in the day where I was a student, I had several attempts with Ubuntu, however I wasn't comfortable enough for the OS. After learning a big bit from Neovim, here I am again :)

---

## Table of contents

- [Table of contents](#table-of-contents)
- [OS setup](#os-setup)
- [The Essentials](#the-essentials)
    - [Notes](#notes)
- [Utility Scripts](#utility-scripts)
- [Unity Patching](#unity-patching)

---

## OS setup

I am currently use [EndeavourOS](https://endeavouros.com/), an [Arch Linux](https://archlinux.org/) distro. Meaning that my scripts use *pacman* and *yay* as my AUR (Arch linux User Repository) helper to download and install packages.

The scripts set up a minimal work environment for me, after this some more actions need to be done in:
- Desktop Environment
- Keyboard
- Shell rc files
- Every other apps :)

## The Essentials

***Script: install-essentials.sh***

Execute the script to:
- Config basic git: convert CRLF to LF, use the OS' secretservice to store credentials
- Install some main applications:
    - Git-LFS, Cmake, *fastfetch*, *htop*, *ibus-bamboo* [^*].
    - Nerd font support, JetBrains Mono Nerd font.
    - Fish shell, Wezterm, VSCode, Neovim.
    - Rust, .NET (9.0).
    - Neovim stuffs: tree-sitter-cli, lua-language-server.
    - *Sourcegit*, *Pinta*, *Unity Hub* [^*]
- Apply configurations to:
    - Neovim
    - Wezterm
    - Fish shell

[^*]: Personal preferences or work related, removable.

### Notes

While most items in the scripts install themselves, you still need to download and put the Roslyn package to the preconfigured directory: *$HOME/Apps/Roslyn/*. Check the fish config for more informations.

## Utility Scripts

*TDB*

## Unity Patching

*TDB*

