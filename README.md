# dotfiles

My personal archive for the dotfiles that I am using, which is fairly minimal with some key bindings and features very close to VSCode (my last text editor :) ).

## Plugins

---

### System
- **lazy.nvim** - Package Manager
- **auto-session** - Session Manager
- **neo-tree.nvim** - File Explorer
- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native.nvim** - Telescope extension
- **nvim-treesitter** - Syntax highlighting
- **blink.cmp** - Auto Complete
### Language Server
- **nvim-lspconfig** - LSP configurations
- **lensline.nvim** - Codelens
- **tiny-inline-diagnostic.nvim** - Improve the diagnostic messages
- **lazydev.nvim** - LuaLS for NeoVim configurations
### TUI
- **noice.nvim** - UI improvements
- **lightline.vim** - Statusline & tabline decorator
- **nvim-web-devicons** - Well, icons ;)
### Quality of Life
- **dropbar.nvim** - IDE-like breadcrumbs, great to know which part of the document I'm at
- **vim-autopairs** - QoL for brackets, parentheses pairing
- **rainbow-delimiters.nvim** - QoL to look at the brackets clearly
- **which-key.nvim** - To memorize all the keybinds
### Utilities
- **markview.nvim** - Markdown, LaTeX previews
- **gitsigns.nvim** - Very nice git utilities, used for line blame, tracking changes
- **lazygit.nvim** - [lazygit](https://github.com/jesseduffield/lazygit) integration in neovim

## Themes

---

Theme is loaded right after LazyVim, set up in *init.lua* file.
- **onedark.nvim**
- **kanagawa.nvim**
- **gruvbox-material.nvim**

## Dependencies

---

As I work mostly on Windows, I use [scoop](https://scoop.sh/) to install the packages. There are many dependencies to those plugins to run, below is the list of tools, executables that I used (can be more):
- A C Compiler
- Lua & Luarocks
- Rust & Cargo (I use [Neovide](https://neovide.dev/) on top of nvim, for some nice, juicy cursor animations!).
- ripgrep & fd

## Language Servers

---

- lua-language-server (installed from scoop).
- Pyright (installed from pip).
- Roslyn analyzer - Used to program in Unity C# (refer to lspconfig for installation instruction).
- A C/C++ language server (TBD)

