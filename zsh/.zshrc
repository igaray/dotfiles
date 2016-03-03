
os=$OSTYPE
if [[ ${os:0:6} == "darwin" ]]; then
    os="darwin"
elif [[ ${os:0:5} == "linux" ]]; then
    os="linux"
fi

#case $os in
#    "darwin") 
#        echo "1"
#        ;;
#    "linux") 
#        echo "2"
#        ;;
#esac

#if [[ $os == "" ]]; then
#fi

###############################################################################
# VARIABLES

# set $PATH
export PATH=$PATH:./:$HOME/bin
export EDITOR=vim

# RVM
if [[ $os == "darwin" ]]; then
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
    export PATH=$PATH:$HOME/bin:$HOME/.rvm/bin
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
COMPLETION_WAITING_DOTS="true"

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

#if [[ $os == "linux" ]]; then
#    # create a zkbd compatible hash;
#    # to add other keys to this hash, see: man 5 terminfo
#    typeset -A key
#    key[Home]=${terminfo[khome]}
#    key[End]=${terminfo[kend]}
#    key[Insert]=${terminfo[kich1]}
#    key[Delete]=${terminfo[kdch1]}
#    key[Up]=${terminfo[kcuu1]}
#    key[Down]=${terminfo[kcud1]}
#    key[Left]=${terminfo[kcub1]}
#    key[Right]=${terminfo[kcuf1]}
#    key[PageUp]=${terminfo[kpp]}
#    key[PageDown]=${terminfo[knp]}
#
#    # setup key accordingly
#    [[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
#    [[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
#    [[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
#    [[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
#    [[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
#    [[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
#    [[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
#    [[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
#
#    # Finally, make sure the terminal is in application mode, when zle is
#    # active. Only then are the values from $terminfo valid.
#
#    if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then 
#        function zle-line-init () {
#            echoti smkx
#        }
#        function zle-line-finish () {
#            echoti rmkx
#        }
#        zle -N zle-line-init
#        zle -N zle-line-finish
#    fi
#
#    # only show past commands which start with the current input
#    bindkey "^[[A" history-beginning-search-backward
#    bindkey "^[[B" history-beginning-search-forward
#fi

###############################################################################
# THEME

# load vcs info and colors for prompt
autoload -Uz vcs_info
autoload -U colors && colors
setopt prompt_subst

# prompt theme
 autoload -U promptinit
 promptinit
#prompt adam1
#prompt adam2
#prompt bart
#prompt bigfade
#prompt clint
#prompt elite
#prompt elite2
#prompt fade
#prompt fire
#prompt off
#prompt oliver
#prompt pws
#prompt redhat
#prompt suse
#prompt walters
#prompt zefram

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

case $os in
    "darwin") 
        alias           ..='cd ..'
        alias           ls='ls -G'
        alias           la='ls -G -A'
        alias            l='ls -G -l -h'
        ;;
    "linux") 
        alias           ..='cd ..'
        alias           ls='ls --group-directories-first --color=auto -X'
        alias           la='ls --group-directories-first --color=auto -X -a'
        alias           ll='ls --group-directories-first --color=auto -X -l -h'
        alias           l1='ls --group-directories-first --color=auto -X -1 -h'
        alias           lk="ls --group-directories-first --color=auto -X -lSr"  # sort by size, biggest last
        alias           lt="ls --group-directories-first --color=auto -X -ltr"  # sort by date, most recent last
        alias          lsr="tree -Csu"                                          # nice alternative to 'recursive ls'
        alias           nv="nvim"
        alias     sizesort='du -s *    | sort -n | cut -f 2- | while read a; do du -hs "$a"; done'
        alias      weechat='weechat-curses'
        alias       volume='alsamixer -g'
        alias       winmnt='sudo mount /dev/sda1 /home/igaray/win -o uid=$(id -u),gid=$(id -g)'
        alias      winumnt='sudo umount /home/igaray/win'
        alias      extumnt='sync; sudo umount /home/igaray/tera'
        alias      usbumnt='sync; sudo umount /home/igaray/usb'
        alias        music='ncmpcpp'
        alias filenamedate='date +"%Y_%m_%d_%H_%M"'
        alias autodestruct='sudo shutdown -h now'
        alias   whispervpn='sudo openvpn /etc/openvpn/whisper/client.conf'
        alias     inakavpn='sudo openvpn /etc/openvpn/inaka/client.conf'
        alias       review='rbt post --description "$(git log HEAD...origin/master)" --summary "$(git log -1 --pretty=format:%s | head -1)" --testing-done "Common Test Suites" --target-groups="DX-Software" --server=http://review.dssd.com'
        ;;
esac

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
    dir=${1:-"./"}
    sudo find "$dir" | while read file
    do 
        echo "$file"
        if [ -d "$file" ]
            then sudo chmod 770 "$file"
            else sudo chmod 660 "$file"
        fi
        sudo chown -h $(id -u) "$file"
        sudo chgrp -h $(id -g) "$file"
    done
}

#------------------------------------------------------------------------------#
# USB mount

# usbmnt
# usbmnt fs
# usbmnt fs drive
# usbmnt fs drive mountpoint
#
# fs may be ntfs, fat, ext and defaults to ntfs
# drive should be b, c, c1, d, d3, etc abd defaults to b1
# mountpoint should be a directory and defaults to /home/igaray/usb

if [[ $os == "linux" ]]; then
    usbmnt() {
        fs=${1:-ntfs}
        drive=${2:-b1}
        mountpoint=${3:-/home/igaray/usb}

        if [[ $fs == ext ]]; then
            sudo mount /dev/sd$drive $mountpoint
        elif [[ $fs == fat ]]; then
            sudo mount /dev/sd$drive $mountpoint -o rw,uid=$(id -u),gid=$(id -g);
        elif [[ $fs == ntfs ]]; then
            sudo mount /dev/sd$drive $mountpoint -o rw,uid=$(id -u),gid=$(id -g),fmask=133,dmask=022;
        else
            echo Unknown filetype.
        fi
    }
fi

#------------------------------------------------------------------------------#
# Intelligent extract

if [[ $os == "linux" ]]; then
    extract() {
        file=$1
        dir=$2
        if [ -z $dir ]
        then
            echo "No directory set, creating and moving into" $dir
            ext=$( echo $file | awk -F . '{print $NF}' )
            dir=$(basename $file .$ext)
            mkdir $dir
            mv $file $dir
            cd $dir
        else
            echo "Directory set, creating and moving into" $dir
            mkdir -p $dir
            mv $file $dir
            cd $dir
        fi
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)   tar xvjf $file    ;;
                *.tar.gz)    tar xvzf $file    ;;
                *.tar.xz)    tar xvJf $file    ;;
                *.bz2)       bunzip2 $file     ;;
                *.rar)       unrar x $file     ;;
                *.gz)        gunzip $file      ;;
                *.tar)       tar xvf $file     ;;
                *.tbz2)      tar xvjf $file    ;;
                *.tgz)       tar xvzf $file    ;;
                *.zip)       unzip $file       ;;
                *.Z)         uncompress $file  ;;
                *.7z)        7z x $file        ;;
                *.jar)       unzip $file       ;;
                *)           echo "don't know how to extract '$file'..." ;;
            esac
        else
            echo "'$1' is not a valid file!"
        fi
    }
fi

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


