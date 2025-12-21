# Neovim configurations

My setup mostly focus on functionalities, with minimal improvements to the UI, a nerd font and a terminal that supports true color is required.

The specific plugin options can be found in **lua/plugins/<plugin_name>.lua**. Overall, the structure is fairly simple with 3 directories:
- **config** to store *lazy.nvim* bootstrap, my *keymaps* and *auto*-command settings.
- **plugins** for,... well, plugins ;)
- **themes** for the themes that I actually use.

---

## Table of contents

- [Table of contents](#table-of-contents)
- [Plugins](#plugins)
- [Themes](#themes)
- [Language Servers](#language-servers)
- [Running on Windows](#running-on-windows)

---

## Plugins

### System

- **lazy.nvim** - Package Manager
- **oil.nvim** - File Manager
- **auto-session** - Session Manager
- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native.nvim** - Telescope extension
- **nvim-treesitter** - Syntax highlighting
- **blink.cmp** - Auto Complete
- **nvim-ufo** - Fold improvements

### Language Server

- **nvim-lspconfig** - LSP configurations
- **symbol-usage.nvim** - Codelens
- **tiny-inline-diagnostic.nvim** - Improve the diagnostic messages
- **roslyn.nvim** - Roslyn LSP improvements

### TUI

- **todo-comments.nvim** - Highlight & quickly find TODOs, HACKs, BUGs comments
- **nvim-web-devicons** - Well, icons ;)

### Quality of Life

- **nvim-treesitter-textobjects** - Improve textobjects manipulation
- **vim-sandwich** - QoL for handling brackets, parentheses of current selection
- **vim-autopairs** - QoL for brackets, parentheses pairing
- **rainbow-delimiters.nvim** - QoL to look at the brackets clearly
- **which-key.nvim** - To memorize all the keybinds

### Utilities

- **markview.nvim** - Markdown, LaTeX previews
- **gitsigns.nvim** - Very nice git utilities, used for line blame, tracking changes
- **close-buffers.nvim** - Close redundant buffers
- **harpoon** - Quickly jump between working files

## Themes

Theme is loaded right after LazyVim, set up in *init.lua* file.
- **onedark.nvim**
- **oldworld.nvim**
- **gruvbox-material.nvim**

## Language Servers

- lua-language-server
- Pyright
- Roslyn - Used to program in Unity C#
- clangd

> [!NOTE]
> **Installations**:
>
> I used to use mason.nvim to install the language servers, however I decided to switch to the brute-force myself to install and add the executables to the shell paths. Either approaches work, but I feel it's fun to dig into each source to know how they are built, what are the steps, etc.
>
> **Roslyn**: go to [this link](https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl) and filter for **Microsoft.CodeAnalysis.LanguageServer**, then choose the desired Roslyn language server that matches your OS, download it, *extract as zip*, then add the language server to PATH and start using.

## Running on Windows

### Scoop

I use [scoop](https://scoop.sh/) to install the packages. There are many dependencies to those plugins to run, below is the list of tools, executables that I used (can be more):
- tree-sitter-cli
- ~Lua & Luarocks~
- Rust & Cargo
- ripgrep & fd-find

### Lua & Luarocks

Lua and Luarocks are optional, it's cumbersome to install them on Windows so I opted to exclude them. If they're installed, consider enable rocks in lazy.nvim config.

