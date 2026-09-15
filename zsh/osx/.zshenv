
# set environment variables (important for autologin on tty)
export HOSTNAME=${HOSTNAME:-$(hostname)}

# make sure /usr/bin/id is available
if [[ -x /usr/bin/id ]] ; then
    [[ -z "$USER" ]] && export USER=$(/usr/bin/id -un)
    [[ $LOGNAME == LOGIN ]] && LOGNAME=$(/usr/bin/id -un)
fi

export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=./:$PATH

export EDITOR=kak
export COMPLETION_WAITING_DOTS="true"
export LC_ALL=en_US.UTF-8

export HISTFILE=~/.histfile
# Maximum lines kept in memory
export HISTSIZE=100000
# Maximum lines saved to $HISTFILE
export SAVEHIST=100000

# MAKEDEV should be usable on udev as well by default:
export WRITE_ON_UDEV=yes
