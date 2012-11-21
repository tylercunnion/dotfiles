zmodload -i zsh/zutil
zmodload -i zsh/compctl
zmodload -i zsh/complete
zmodload -i zsh/complist
zmodload -i zsh/computil
zmodload -i zsh/main
zmodload -i zsh/zle
zmodload -i zsh/rlimits
zmodload -i zsh/parameter

autoload -Uz vcs_info

### Include system-specific config
if [[ -e ~/.zshrc.system ]] then 
    source ~/.zshrc.system
fi

### Source control
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats       '[%b]'
precmd () {
    vcs_info
}

setopt prompt_subst
PROMPT='[%n@%m:%~]${vcs_info_msg_0_} $ '
RPROMPT="[%*]"

autoload -U compinit promptinit colors #add-zsh-hook
compinit
promptinit
colors

export EDITOR='vim'
export VISUAL='vim'

REPORTTIME=1
TIMEFMT="%J completed in %*E"

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

eval $(dircolors ~/.dir_colors)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt extended_glob

function locate
{
	find $1 -name "$2" -print
}

function search
{
    local search_dir
    if [[ -z $2 ]] then
        search_dir='.'
    else
        search_dir=$2 
    fi
    find $search_dir -exec grep "$1" '{}' \; -print
}

setopt CORRECT
setopt RM_STAR_WAIT

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
