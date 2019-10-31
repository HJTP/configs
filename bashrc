# Check for an interactive session
[ -z "$PS1" ] && return

shopt -s checkwinsize

shopt -s histappend
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth

export EDITOR=vim
export BROWSER=firefox

# Added because of ls sorting
export LC_COLLATE=en_GB.UTF8

# Fix some autocomplete stuff
# With foxitreader selected, only show pdf files
_xspecs[foxitreader]='!*.@(pdf)'
complete -F _filedir_xspec foxitreader
# With love selected, only show love files
_xspecs[love]='!*.@(love)'
complete -F _filedir_xspec love
# With coolreader selected, only show epub files
_xspecs[coolreader]='!*.@(epub)'
complete -F _filedir_xspec coolreader
# With fbreader selected, only show epuc files
_xspecs[fbreader]='!*.@(epub)'
complete -F _filedir_xspec fbreader

RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
BLUE="\[\e[1;34m\]"
CYAN="\[\e[1;36m\]"
WHITE="\[\e[1;37m\]"
YELLOW="\[\e[1;93m\]"
RESET_COL="\[\e[0m\]"

user_col=${GREEN}
if [ $UID -eq 0 ]; then
    user_col=${RED}
fi

hname=""
if [[ "${HOSTNAME}" == "raspi" ]]; then
    hname="$CYAN@raspi"
elif [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    hname="$WHITE@$HOSTNAME"
fi

screen=""
if [ -n "$STY" ]; then
    screen="$CYAN{screen} "
elif [ -n "$TMUX" ]; then
    screen="$CYAN{tmux} "
fi

check_git() {
    # Git stuff
    GIT=""
    if [[ ! -n $(git status 2>&1 | grep "fatal") ]]; then
        GIT=$(git status | head -n 1)
        GIT=${GIT:10}
        if [[ -n $(git status | grep "not staged") ]]; then
            GIT=$RED$GIT
        elif [[ -n $(git status | grep "to be committed") ]]; then
            GIT=$YELLOW$GIT
        else
            GIT=$GREEN$GIT
        fi
        GIT="($GIT$BLUE) "
    fi

	VIRTENV=""
	if [[ -n "$VIRTUAL_ENV" ]]; then
		VIRTENV="$YELLOW{$(basename $VIRTUAL_ENV)} "
	fi

    PS1="$user_col\u$hname $screen$BLUE\w $VIRTENV$BLUE$GIT$GREEN\$ $RESET_COL"
    PS1="${WHITE}[\D{%F %T}] $user_col\u$hname $screen$BLUE\w $GIT$GREEN\$ $RESET_COL"
}

eval $(dircolors -b)

alias ls='ls --color=auto'
alias grep='grep -i --color=auto'

alias lls='ls -lhAS'
alias ll='ls -lhA'
alias l='ls'
alias la='ls -a'
alias ..='cd ..'
alias df='df -h'
alias du='du -c -h'
alias locate='locate -i'
alias gs='git status'
alias ack='ack -i'

alias more='less'
alias hist='history|grep $1'
alias da='date "+%A, %B, %d, %Y [%T]"'
alias dul='du --max-depth=1 | sort -h'
alias tmux='tmux -2' # Forces 256 color
alias coolreader='cr3'
alias fbreader='FBReader'
alias info='info --vi-keys'

if [ $UID -ne 0 ]; then
	alias reboot='sudo reboot'
	alias poweroff='sudo poweroff'
	alias pacman='sudo pacman'
    alias pkill='sudo pkill'
    alias umount='sudo umount'
    alias iotop='sudo iotop'
    alias pip2='sudo pip2'
    alias pip='sudo pip'
    alias tcpdump='sudo tcpdump'
fi

alias secondscreenon='xrandr --output VGA1 --auto && sleep 5 && xrandr --output LVDS1 --below VGA1'
alias secondscreenoff='xrandr --output VGA1 --off'
alias fixwifi='nmcli radio wifi on'

# Used to be in inputrc
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# mkdir & cd into it
function mc() {
  mkdir -p "$*" && cd "$*" && pwd
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
                *.tar.bz2) tar xjf $1 ;;
                *.tar.gz) tar xzf $1 ;;
                *.bz2) bunzip2 $1 ;;
                *.rar) unrar e $1 ;;
                *.gz) gunzip $1 ;;
                *.tar) tar xf $1 ;;
                *.tbz2) tar xjf $1 ;;
                *.tgz) tar xzf $1 ;;
                *.zip) unzip $1 ;;
                *.Z) uncompress $1 ;;
                *.7z) 7z x $1 ;;
                *) echo "'$1' cannot be extracted via extract()" ;;
                 esac
        else
        echo "'$1' is not a valid file"
     fi
}

PROMPT_COMMAND=check_git
