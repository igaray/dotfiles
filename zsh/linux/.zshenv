
# set environment variables (important for autologin on tty)
export HOSTNAME=${HOSTNAME:-$(hostname)}
export PATH=./:$HOME/.local/bin:$PATH
export EDITOR=nvim

# make sure /usr/bin/id is available
if [[ -x /usr/bin/id ]] ; then
    [[ -z "$USER" ]] && export USER=$(/usr/bin/id -un)
    [[ $LOGNAME == LOGIN ]] && LOGNAME=$(/usr/bin/id -un)
fi

# MAKEDEV should be usable on udev as well by default:
export WRITE_ON_UDEV=yes

## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
