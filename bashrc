
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
export PATH=$PATH:/home/floris/sanoma/mead/mead/bin
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
YELLOW="\[\e[1;93m\]"
RESET_COL="\[\e[0m\]"


user_col=${GREEN}
if [ $UID -eq 0 ]; then
    user_col=${RED}
fi

hname=""
if [[ "${HOSTNAME}" == "raspi" ]]; then
    hname="$CYAN@raspi"
elif [[ "${HOSTNAME}" == "sremote" || "${HOSTNAME}" == "deze" ||
    "${USER}" == "ftkroon" ]]; then
    hname="$YELLOW@UvA"
elif [[ "${HOSTNAME:0:2}" == "in" ]]; then
    number="${HOSTNAME:2}"
    hname="$YELLOW@webdb$number"
fi


PS1="$user_col\u$hname $BLUE\w $GREEN\$ $RESET_COL"

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

alias af='cd /home/floris/Afstudeerproject/python'
alias the='cd /home/floris/Afstudeerproject/thesis'

if [ $UID -ne 0 ]; then
	alias reboot='sudo reboot'
	alias poweroff='sudo poweroff'
	alias update='sudo pacman -Su'
	alias pacman='sudo pacman'
    alias airmon-ng='sudo airmon-ng'
    alias pkill='sudo pkill'
    alias wireshark='sudo wireshark'
    alias umount='sudo umount'
    alias iotop='sudo iotop'
    alias xampp='sudo xampp'
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

alias vbox='virtualbox'
alias secondscreenon='xrandr --output VGA1 --auto && xrandr --output LVDS1 --below VGA1'
alias secondscreenoff='xrandr --output VGA1 --off'
alias fixwifi='nmcli radio wifi on'


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
