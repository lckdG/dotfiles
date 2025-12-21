# Linux configurations

I switched to Linux after a while working with distraction and slowness on Windows.

Back in the day where I was a student, I had several attempts with Ubuntu, however I wasn't comfortable enough for the OS. After learning a big bit from Neovim, here I am again :)

---

## Table of contents

- [Table of contents](#table-of-contents)
- [OS setup](#os-setup)
- [The Essentials](#the-essentials)
- [Utility Scripts](#utility-scripts)
- [Unity Patching](#unity-patching)
- [Switching Ibus](#switching-ibus)

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
    - wl-clipboard, Git-LFS, Cmake, *fastfetch*, *htop*, *ibus-bamboo* [^*].
    - Nerd font support, JetBrains Mono Nerd font.
    - Fish shell, Wezterm, VSCode, Neovim, Lazygit.
    - Rust, .NET (9.0).
    - Neovim stuffs: tree-sitter-cli, lua-language-server.
    - *Sourcegit*, *Pinta*, *Unity Hub* [^*]
<a id="configurations"></a>
- Apply configurations to:
    - Neovim
    - Wezterm
    - Fish shell

[^*]: Personal preferences or work related, removable.

> [!NOTE]
> While most items in the scripts install themselves, you still need to download and put the Roslyn package to the preconfigured directory: *$HOME/Apps/Roslyn/*. Check the fish config for more informations.

## Utility Scripts

***Script: link-config.sh***

**Prerequisites:** [GNU Stow](https://www.gnu.org/software/stow/)

This script creates symbolic links to the listed [configuration directories](#configurations). Any changes made in the repository will be reflected directly to the applications, and vice versa.

## Unity Patching

***Script: fix-unity.sh***

The script will attempt to:
- Extract the **Payload~** file present in the <EDITOR>/Editor/Data/PlaybackEngines/AndroidPlayer diretory (use the *modules.asset* as a marker).
- Fix broken links in the AndroidPlayer/NDK directory.

As it finds all editor versions from the *$UNITY_EDITOR_ROOT* and perform the patch, replace the path to match that on your machine.

The NDK links are broken because somehow there is a ***android-ndk-<version>/*** in the path. My script simply exclude that bit from all broken links and they work :)

## Switching Ibus

***Script: change-input.sh***

Assign this script to your system Shortcuts with a preferred keybindings, e.g. Alt+Shift.

You may need to disable ibus method switching shortcut by the following terminal command:

```bash
gsettings set org.freedesktop.ibus.general.hotkey triggers "[]"
```
