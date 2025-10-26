# dotfiles

My personal archive for the dotfiles that I am using, which is fairly minimal with some key bindings and features very close to VSCode (my last text editor :) ).

## Plugins

---

- **lazy.nvim** - Package Manager
- **auto-session** - Session Manager
- **neo-tree.nvim** - File Explorer
- **telescope.nvim** - Fuzzy finder
- **nvim-treesitter** - Syntax highlighting
- **blink.cmp** - Auto Complete
- **vim-autopairs** - QoL for brackets, parentheses pairing
- **nvim-lspconfig** - LSP configurations
- **lensline.nvim** - Codelens
- **tiny-inline-diagnostic.nvim** - Improve the diagnostic messages
- **lazydev.nvim** - LuaLS for NeoVim configurations
- **noice.nvim** - UI improvements
- **nvim-web-devicons** - Well, icons ;)
- **markview.nvim** - Markdown, LaTeX previews
- **gitsigns.nvim** - Very nice git utilities
- **which-key.nvim** - To memorize all the keybinds

## Themes

---

Theme is loaded right after LazyVim, set up in *init.lua* file.
- **onedark.nvim**

## Dependencies

---

As I work mostly on Windows, I use [scoop](https://scoop.sh/) to install the packages. There are many dependencies to those plugins to run, below is the list of tools, executables that I used (can be more):
- Lua & Luarocks
- Rust & Cargo (I use [Neovide](https://neovide.dev/) on top of nvim, for some nice, juicy cursor animations!).
- Ripgrep

## Language Servers
- lua-language-server (installed from scoop).
- Pyright (installed from pip).
- Roslyn analyzer - Used to program in Unity C# (refer to lspconfig for installation instruction).

