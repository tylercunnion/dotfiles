if status --is-interactive
    fish_hybrid_key_bindings
end

set -x EDITOR vim
set -x VISUAL vim
set -x PAGER less
set -x LESS -R

if test -e ~/.config/fish/system.fish
    source ~/.config/fish/system.fish
end


thefuck --alias | source
