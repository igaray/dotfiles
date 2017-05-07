
os=$OSTYPE
if [[ ${os:0:6} == "darwin" ]]; then
    os="darwin"
elif [[ ${os:0:5} == "linux" ]]; then
    os="linux"
fi

###############################################################################
# ENVIRONMENT VARIABLES

export PATH=./:$HOME/.local/bin:$PATH
export EDITOR=nvim
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export COMPLETION_WAITING_DOTS="true"

# ERLANG
. /usr/local/erlang/activate

# ELIXIR
[[ -s "$HOME/.kiex/scripts/kiex" ]] && source "$HOME/.kiex/scripts/kiex"

###############################################################################
# OPTIONS

# vim-style line editing
 bindkey -v
 bindkey "jj" vi-cmd-mode
 bindkey '^R' history-incremental-search-backward

# enable autocompletion
 autoload -U compinit
 compinit

# autocompletion with menu select
 zstyle ':completion:*' menu select

# enable alias completion
 setopt completealiases

# with autocd you can type the name of the directory and it will become the
# current directory
 setopt autocd 
 setopt extendedglob 
 setopt nomatch 
 setopt notify
# correct will enable spelling correction for commands
 setopt correct
# correctall will enable spelling correction for parameters
 unsetopt correctall

# noclobber will prevent accidentally overwriting an existing file
# If you really do want to clobber a file, you can use the >! operator.
 setopt noclobber

# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
 setopt append_history

###############################################################################
# THEME

# load vcs info and colors for prompt
autoload -Uz vcs_info
autoload -U colors && colors
setopt prompt_subst

# prompt theme
 autoload -U promptinit
 promptinit

prompt_igaray_precmd () {
    setopt localoptions
    local exitstatus=$?
    
    zstyle ':vcs_info:*' enable git svn
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr   '+'
    zstyle ':vcs_info:*' unstagedstr '-'
    zstyle ':vcs_info:*' formats '%F{red}[%f %b%u%c %F{red]%f'
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats "%b%c%u"
    } else {
        zstyle ':vcs_info:*' formats "%b%c%u*"
    }
    
    vcs_info
    psvar=()
    [[ $exitstatus -ge 128 ]] && psvar[1]="$signals[$exitstatus-127]" || psvar[1]=""
    [[ -n $vcs_info_msg_0_ ]] && psvar[2]="$vcs_info_msg_0_"
}

prompt_igaray_setup () {
    local -a pcc
    local -A pc
    local p_date p_tty p_plat p_ver p_userpwd p_apm p_shlvlhist p_rc p_end p_win
    
    # Defines default prompt color codes in an array
    # cyan green yellow white
    pcc[1]=${1:-${${SSH_CLIENT+'yellow'}:-'red'}}
    pcc[2]=${2:-'white'}
    pcc[3]=${3:-'blue'}
    pcc[4]=${4:-'green'}
    pcc[5]=${5:-'yellow'}
    
    # Defines default prompt commands in an array.
    pc['bo']="%F{$pcc[1]}[%f"
    pc['bc']="%F{$pcc[1]}]%f"
    pc['ao']="%F{$pcc[1]}<%f"
    pc['ac']="%F{$pcc[1]}>%f"
    pc['po']="%F{$pcc[1]}(%f"
    pc['pc']="%F{$pcc[1]})%f"
    
    # Defines the different parts of the prompt.
    p_user="$pc['bo']%F{$pcc[4]}%n@%m$pc['bc']:"
    p_pwd="$pc['bo']%F{$pcc[3]}%~$pc['bc']"
    p_vcs="$pc['bo']%(2v.%U%2v%u.)$pc['bc']"
    p_time="$pc['bo']%F{$pcc[2]}%D{%R}$pc['bc']"
    p_end="%B%#%b "
    
    prompt="$p_time$p_pwd$p_vcs
$p_end"
    PS2='%(4_.\.)%3_> %E'
    
    add-zsh-hook precmd prompt_igaray_precmd
}
 prompt_igaray_setup "$@"

###############################################################################
# ALIAS

alias           ..='cd ..'
alias           ls='ls -G'
alias           la='ls -G -A'
alias           ll='ls -G -l -h'
alias           l1='ls -1'
alias           lr="tree -Csu"
alias           nv="nvim"
alias           ss='du -s * | sort -n | cut -f 2- | while read a; do du -hs "$a"; done'
alias      weechat='weechat-curses'
alias filenamedate='date +"%Y_%m_%d_%H_%M"'

###############################################################################
# FUNCTIONS

#------------------------------------------------------------------------------#
# Colors
#
# To print success
# green "Task has been completed"
# To print error
# red "The configuration file does not exist"
# To print warning
# yellow "You have to use higher version."

NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function red() {
    echo -e "$RED$*$NORMAL"
}

function green() {
    echo -e "$GREEN$*$NORMAL"
}

function yellow() {
    echo -e "$YELLOW$*$NORMAL"
}

#------------------------------------------------------------------------------#
# Jump Marks

export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

#------------------------------------------------------------------------------#
# Fix Permissions & Ownership.
#
# The script will recursively list all directories and files within the first argument 
# and call 'chmod 770' if it is a directory and 'chmod 660' otherwise, 
# and change the ownership to username.groupname of all directory contents.

function fixperm {
    dir=${1:-"."}
    sudo find "$dir" | while read file
    do 
        if [ -d "$file" ]
            then sudo chmod 770 "$file"
            else sudo chmod 660 "$file"
        fi
        sudo chown -h $(id -u) "$file"
        sudo chgrp -h $(id -g) "$file"
    done
}

#------------------------------------------------------------------------------#
# Copy with progres indicator

function cpp() {
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

###############################################################################
# MOTD

echo Pride is not the opposite of shame, but its source.
echo True humility is the only antidote to shame.

## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
