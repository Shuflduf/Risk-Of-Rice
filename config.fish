if status is-interactive
    starship init fish | source
    zoxide init fish | source

    alias cd="z"
    alias ls="eza --long"
    alias la="eza --all --long"
    alias lt="eza --tree -L 2"

    abbr -a -- pac pacsea
    abbr -a -- hx helix
    abbr -a -- lg lazygit
end
