set -g fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    set -x DOTNET_ROOT $HOME/.dotnet

    fish_add_path $HOME/.dotnet
    fish_add_path $HOME/.dotnet/tools
    fish_add_path $HOME/.local/share/gem/ruby/3.4.0/bin
    fish_add_path $HOME/Apps/flutter/bin/

    # Functions
    function yz
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        command rm -f -- "$tmp"
    end

    # Abbreviations

    abbr -a ff fastfetch
    abbr -a lg lazygit

    abbr -a sdh shutdown -h
    abbr -a sdr shutdown -r

    abbr -a --position anywhere -- --bg "> /dev/null 2>&1 &"
end

zoxide init fish | source

