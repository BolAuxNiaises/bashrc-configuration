# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f ~/.git-flow-completion.bash ]; then
  . ~/.git-flow-completion.bash
fi

# You may uncomment the following lines if you want `ls' to be colorized:
 export LS_OPTIONS='--color=auto'
 eval "`dircolors`"
 alias ls='ls $LS_OPTIONS'
 alias ll='ls $LS_OPTIONS -l'
 alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
 alias rm='rm -i'
 alias cp='cp -i'
 alias mv='mv -i'

# utilisation des couleurs pour certaines commandes
eval "`dircolors -b`"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# affichage sympathique de la ligne de commande
PS1="[\t] \[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ "

# permettre une complétion plus "intelligente" des commandes (question de goût)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# lecture colorée de logs
logview()
{
    ccze -A < $1 | less -R
}

# lecture colorée de logs en directfunction logview()
logtail()
{
    tail -f $1 | ccze
}

# Remonter d'un dossier et ls
alias u="cd .. && ls --color"

alias du='du -h --max-depth=1'
alias dusort='du -x --block-size=1048576 | sort -nr'
alias df='df -h'
alias ap="apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoclean && apt-get clean && apt-get autoremove && debclean"

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
 
function proml {
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac
 
PS1="${TITLEBAR}\
$LIGHT_GRAY\u@\h:$WHITE\w$LIGHT_GREEN\$(parse_git_branch)\
$LIGHT_GRAY\$ "
PS2='> '
PS4='+ '
}
proml
