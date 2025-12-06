if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    set -x DOTNET_ROOT $HOME/.dotnet

    fish_add_path $HOME/.dotnet
    fish_add_path $HOME/Apps/Roslyn/content/LanguageServer/linux-x64/
end
