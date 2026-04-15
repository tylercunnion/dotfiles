if test -e ~/.config/fish/system.fish
    source ~/.config/fish/system.fish
end

# Install Fisher if not already installed
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
end

if status --is-interactive
    fish_hybrid_key_bindings
    set -x GPG_TTY (tty 2>/dev/null || echo "/dev/tty")
    fish_config theme choose solarized
end

set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less
set -x LESS -R

if test -e ~/.config/fish/fish_aliases
    source ~/.config/fish/fish_aliases
end

eval (dircolors -c ~/.dir_colors)

