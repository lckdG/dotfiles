## clangd
On Windows:

- Install clangd with scoop
```
scoop install clangd
```

- Update with command:
```
scoop update clangd
```

On Linux:
- Install and update with your package manager, e.g. Arch-based distros:
```
sudo pacman -S clang
```

- Or install full LLVM package:
```
sudo pacman -S llvm
```

## gopls
https://go.dev/gopls/

Install [Go](https://go.dev/), then run command:

```
go install golang.org/x/tools/gopls@latest
```

## lua_ls
https://luals.github.io/#neovim-install

On Windows:
- Install with scoop:
```
scoop install lua-language-server
```

- Update with command:
```
scoop update lua-language-server
```

On Linux:
- Install with your package manager, e.g. Arch-based:
```
sudo pacman -S lua-language-server
```

## pyright
https://github.com/microsoft/pyright

> [!NOTE]
> Pyright is obviously used for python code. However it is recommended to install the LSP through npm
> ¯\\_(ツ)_/¯

Installation steps:
- Ensure [Node](https://nodejs.org/en) is installed.
- Run command
```
npm install -g pyright
```

## roslyn
Download link for:
- [Windows](https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.win-x64/overview/)
- [Linux](https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.linux-x64/overview/)
- [OSX-x64](https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.osx-x64/overview/)
- [OSX-ARM](https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.osx-arm64/overview/)

Installation steps:
- Ensure required [.NET version](https://dotnet.microsoft.com/en-us/download/dotnet) is installed.
- Follow the link that matches your OS.
- Download the nupkg, *extract as zip*.
- Add <path_to_Roslyn>/content/LanguageServer/<OS>/ to your *PATH*

> [!NOTE]
> Customize Analysis:
> - Copy **roslyn/.editorconfig** to the root of your project
> - Edit the file, [instruction here](https://learn.microsoft.com/en-us/visualstudio/code-quality/use-roslyn-analyzers?view=visualstudio#manually-configure-rule-severity-in-an-editorconfig-file)

## ts_ls
https://github.com/typescript-language-server/typescript-language-server

Installation steps:
- Ensure [Node](https://nodejs.org/en) is installed.
- Run command
```
npm install -g typescript typescript-language-server
```

