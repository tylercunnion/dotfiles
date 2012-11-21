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

zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:git*' check-for-changes true
#zstyle ':vcs_info:git*' unstagedstr '!'
#zstyle ':vcs_info:git*' stagedstr '¡'
zstyle ':vcs_info:git*' formats       '[%b]'
#zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind git-remotebranch

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

source ~/.alias

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

eval $(dircolors ~/.dir_colors)
#export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ManPath additions
#MANPATH=MANPATH:/usr/share/man:/usr/openwin/man:/usr/local/man:/usr/local/pgsql/man:/usr/local/samba/man:/usr/local/mysql/man:/opt/sfw/man:/usr/sfw/man:/opt/csw/man:~/local/share/man:~/local/man
#export MANPATH

#LD_LIBRARY_PATH=~/local/lib:~/local/include:~/local/include/ncurses:~/local/include/ncursesw:/usr/local/include/ncurses:/usr/local/include/readline:/usr/local/ssl/lib:/usr/lib:/usr/local/lib:/opt/sfw/lib:/usr/sfw/lib:/lib:/usr/local/mysql/lib:/home/scooter/toddl/swift/lib:/home/scooter/toddl/pkg/ImageMagick-6.2.2/lib; 

#export LD_LIBRARY_PATH

#CC=gcc; export CC

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
