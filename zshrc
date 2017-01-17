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
zstyle ':vcs_info:git*' formats '(%b%c%u)'
zstyle ':vcs_info:git*' stagedstr '%F{green}%{±%G%}%f}'
zstyle ':vcs_info:git*' unstagedstr '%F{red}%{±%G%}%f'
precmd () {
    vcs_info
}


### Use vi keybindings
bindkey -v

setopt prompt_subst
PROMPT='[%B%F{red}%m%f%b:%F{yellow}%~%f]${vcs_info_msg_0_} $ '
RPROMPT="[%*]"

autoload -U compinit promptinit colors #add-zsh-hook
compinit
promptinit
colors

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LESS='-R'

REPORTTIME=1
TIMEFMT="%J completed in %*E"

HISTSIZE=10000
SAVEHIST=100000
HISTFILE=~/.history

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

eval $(dircolors ~/.dir_colors)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt extended_glob

function locate
{
	find $1 -name "$2" -print
}

setopt CORRECT

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
