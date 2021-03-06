if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if status --is-interactive
    fish_hybrid_key_bindings
end

set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less
set -x LESS -R
set -x GPG_TTY (tty)

eval (gdircolors -c ~/.dir_colors)

if test -e ~/.config/fish/system.fish
    source ~/.config/fish/system.fish
end

if test -e ~/.config/fish/fish_aliases
    source ~/.config/fish/fish_aliases
end
