set -g fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    set -x DOTNET_ROOT $HOME/.dotnet

    fish_add_path $HOME/.dotnet
    fish_add_path $HOME/.dotnet/tools
    fish_add_path $HOME/.local/share/gem/ruby/3.4.0/bin
    fish_add_path $HOME/Apps/flutter/bin/

    # Abbreviations

    abbr -a ff fastfetch
    abbr -a lg lazygit
    abbr -a yz yazi

    abbr -a sdh shutdown -h
    abbr -a sdr shutdown -r

    abbr -a --position anywhere -- --bg "> /dev/null 2>&1 &"
end

zoxide init fish | source

