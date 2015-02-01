
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

# Sanoma software
# export PATH=$PATH:/home/floris/sanoma/mead/mead/bin
# bama 2014
export PATH=$PATH:/home/floris/bama/pintools/pin-2.14-67254-gcc.4.4.7-linux
export PIN_HOME=/home/floris/bama/pintools/pin-2.14-67254-gcc.4.4.7-linux

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

check_git() {
    # Git stuff
    GIT=""
    if [[ ! -n $(git status 2>&1 | grep "fatal") ]]; then
        GIT=$(git status | head -n 1)
        GIT=${GIT:10}
        if [[ -n $(git status | grep "not staged") ]]; then
            GIT=$RED$GIT
        else
            GIT=$GREEN$GIT
        fi
        GIT="($GIT$BLUE) "
    fi

    PS1="$user_col\u$hname $BLUE\w $GIT$GREEN\$ $RESET_COL"
}

eval $(dircolors -b)

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias lls='ls -lhAS'
alias ll='ls -lhA'
alias l='ls'
alias la='ls -a'
alias grep='grep -i'
alias cd..='cd ..'
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
alias airmon='airmon-ng start wlan0'
alias airmonstop='airmon-ng stop wlan0'
alias coolreader='cr3'
alias fbreader='FBReader'

if [ $UID -ne 0 ]; then
	alias reboot='sudo reboot'
	alias poweroff='sudo poweroff'
	alias pacman='sudo pacman'
    alias pkill='sudo pkill'
    alias umount='sudo umount'
    alias iotop='sudo iotop'
    alias pip2='sudo pip2'
    alias pip='sudo pip'
fi

alias sshuva='ssh ftkroon@sremote.science.uva.nl'
alias sshraspi='ssh thuis.floriskroon.nl -p 22220'
alias sshraspilocal='ssh 192.168.178.99 -p 22220'
alias sshdasvu='ssh fkn780@fs0.das4.cs.vu.nl -X'
alias sshdasuva='ssh fkroon@fs0.das4.cs.vu.nl -X'
alias sshkoeserv='ssh home.chozo.nl -p 22222'
alias sshsangkil='ssh floris@sangkil.science.uva.nl -p 8099'

# Webprog 2015
alias sshwebprog1="ssh -p 4004 floris@in04.webdb.fnwi.uva.nl"
alias sshwebprog2="ssh -p 4005 floris@in05.webdb.fnwi.uva.nl"
alias sshwebprog3="ssh -p 4008 floris@in08.webdb.fnwi.uva.nl"
alias sshwebprog4="ssh -p 4011 floris@in11.webdb.fnwi.uva.nl"

alias secondscreenon='xrandr --output VGA1 --auto && xrandr --output LVDS1 --below VGA1'
alias secondscreenoff='xrandr --output VGA1 --off'
alias fixwifi='nmcli radio wifi on'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Find a specific string IN a file (in all subdirs)
function findif() {
  find . -exec grep -n "$@" "{}" \; -print
}

# mkdir & cd into it
function mc() {
  mkdir -p "$*" && cd "$*" && pwd
}

# cd & ll
#alias lc="cl"
function cl () {
   if [ $# = 0 ]; then
      cd && ll
   else
      cd "$*" && ll
   fi
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



# PCS 2014
source /etc/profile.d/chplenv.sh

PROMPT_COMMAND=check_git
