# Export other directories to PATH
GOPATH=/home/igaray/Desktop/golang/

# Set prompt
set_prompt_style () {
  PS1="[\[\e[32m\]\w\[\e[0m\]]\n$ "
  #PS1="[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n$ "
  #PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "
  #PS1='\[\e[0;32m\][\u \[\e[0;34m\]\W\[\e[0;32m\]]\$\[\e[0m\]'
}
set_prompt_style

# Check for an interactive session. If not running interactively, don't do anything
[ -z "$PS1" ] && return

#export TERM=xterm-256color
export EDITOR='vim'
export FCEDIT='vim'

# Set history variables 
export HISTFILESIZE="1000"
export HISTCONTROL="ignoredups"

# Colorful manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Normal colour scheme
function normalcolours {
  if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P8555555" #darkgrey
    echo -en "\e]P1AA0000" #darkred
    echo -en "\e]P9FF5555" #red
    echo -en "\e]P200AA00" #darkgreen
    echo -en "\e]PA55FF55" #green
    echo -en "\e]P3AA5500" #brown
    echo -en "\e]PBFFFF55" #yellow
    echo -en "\e]P40000AA" #darkblue
    echo -en "\e]PC5555FF" #blue
    echo -en "\e]P5AA00AA" #darkmagenta
    echo -en "\e]PDFF55FF" #magenta
    echo -en "\e]P600AAAA" #darkcyan
    echo -en "\e]PE55FFFF" #cyan
    echo -en "\e]P7AAAAAA" #lightgrey
    echo -en "\e]PFFFFFFF" #white
    clear                  #for background artifacting
  fi
}

# zenburn theme
function zenburn {
  if [ "$TERM" = "xterm-256color" ]; then
    echo -en "\e]P01e2320" #zen-black (norm. black)
    echo -en "\e]P0000000" #zen-black (norm. black)
    echo -en "\e]P8709080" #zen-bright-black (norm. darkgrey)
    echo -en "\e]P1705050" #zen-red (norm. darkred)
    echo -en "\e]P9dca3a3" #zen-bright-red (norm. red)
    echo -en "\e]P260b48a" #zen-green (norm. darkgreen)
    echo -en "\e]PAc3bf9f" #zen-bright-green (norm. green)
    echo -en "\e]P3dfaf8f" #zen-yellow (norm. brown)
    echo -en "\e]PBf0dfaf" #zen-bright-yellow (norm. yellow)
    echo -en "\e]P4506070" #zen-blue (norm. darkblue)
    echo -en "\e]PC94bff3" #zen-bright-blue (norm. blue)
    echo -en "\e]P5dc8cc3" #zen-purple (norm. darkmagenta)
    echo -en "\e]PDec93d3" #zen-bright-purple (norm. magenta)
    echo -en "\e]P68cd0d3" #zen-cyan (norm. darkcyan)
    echo -en "\e]PE93e0e3" #zen-bright-cyan (norm. cyan)
    echo -en "\e]P7dcdccc" #zen-white (norm. lightgrey)
    echo -en "\e]PFffffff" #zen-bright-white (norm. white)
    clear                  # avoid 'artifacts'
fi
}

# jasonwryan's dark theme
function jasonwryan {
  if [ "$TERM" = "xterm-256color" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P83d3d3d" #darkgrey
    echo -en "\e]P18c4665" #darkred
    echo -en "\e]P9bf4d80" #red
    echo -en "\e]P2287373" #darkgreen
    echo -en "\e]PA53a6a6" #green
    echo -en "\e]P37c7c99" #brown
    echo -en "\e]PB9e9ecb" #yellow
    echo -en "\e]P4395573" #darkblue
    echo -en "\e]PC477ab3" #blue
    echo -en "\e]P55e468c" #darkmagenta
    echo -en "\e]PD7e62b3" #magenta
    echo -en "\e]P631658c" #darkcyan
    echo -en "\e]PE6096bf" #cyan
    echo -en "\e]P7899ca1" #lightgrey
    echo -en "\e]PFc0c0c0" #white
    clear                  
  fi
}

jasonwryan

PROMPT_COMMAND='history -a'

# Colorful grep output
export GREP_COLOR="1;33"
alias grep='grep --color=auto'

# Fast shellcompletion
set show-all-if-ambiguous on

#set -o vi

# Smart shellcompletion
#if [ -f /etc/bash_completion ]
#then . /etc/bash/completion
#fi

# Tab-completion for sudo
complete -cf sudo 

# Useful shortcuts
 alias         ..='cd ..'
 alias         ls='ls'       #
 alias         l1='ls -1'    #
 alias         la='ls -a'    #
 alias         ll='ls -l -h' #
 alias         lk="ls -lSr"  # sort by size, biggest last
 alias         lc="ls -ltcr" # sort by and show change time, most recent last
 alias         lu="ls -ltur" # sort by and show access time, most recent last
 alias         lt="ls -ltr"  # sort by date, most recent last
 alias         lr="ls -lR"   # recursive ls
 alias        lsr="tree -Csu"                                          # nice alternative to 'recursive ls'
 alias   sizesort='du -s *    | sort -n | cut -f 2- | while read a; do du -hs "$a"; done'
 alias  sizesorta='du -s * .* | sort -n | cut -f 2- | while read a; do du -hs "$a"; done'

# Bash Directory Bookmarks
#alias m1='alias g1="cd `pwd`"'
#alias m2='alias g2="cd `pwd`"'
#alias m3='alias g3="cd `pwd`"'
#alias m4='alias g4="cd `pwd`"'
#alias m5='alias g5="cd `pwd`"'
#alias m6='alias g6="cd `pwd`"'
#alias m7='alias g7="cd `pwd`"'
#alias m8='alias g8="cd `pwd`"'
#alias m9='alias g9="cd `pwd`"'
#alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bookmarks'
#alias lma='alias | grep -e "alias g[0-9]"|grep -v "alias m"|sed "s/alias //"'
#touch ~/.bookmarks
#source ~/.bookmarks

# Functions

#------------------------------------------------------------------------------#
# usb mount

usbmnt() {
    # drive should be the b, c, c1, d, d3, etc
    # defaults to b1
    # mountpoint should be a directory and defaults to /home/igaray/usb
    drive=${1:-b1}
    mountpoint=${2:-/home/igaray/usb}
    sudo mount /dev/sd$drive $mountpoint -o rw,uid=$(id -u),gid=$(id -g)
}

#------------------------------------------------------------------------------#
# Print working directory after a cd.
#cd () {
#    if [[ $@ == '-' ]]; then
#        builtin cd "$@" > /dev/null  # We'll handle pwd.
#    else
#        builtin cd "$@"
#    fi
#    echo -e "   \033[1;30m"`pwd`"\033[0m"
#}

#------------------------------------------------------------------------------#
# Intelligent extract
extract() {
    file=$1
    dir=$2
    if [ -z $dir ]
    then
        echo "No directory set, extracting here."
    else
        echo Directory set, creating and moving into $dir
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
# Prints all users, divided by login ability and homedir:
#function userinfo {
#    echo "----- Users that can login -----"
#    awk -F":" '!/bin\/false/ { print "username: " $1 ", uid: " $3 ", homedir: " $6 }' /etc/passwd
#
#    echo -e "\n----- And have /home dir -----"
#    awk -F":" '!/bin\/false/ && /\/home/ { print "username: " $1 ", uid: " $3 ", homedir: " $6 }' /etc/passwd
#
#    echo -e "\n----- Users that can't login -----"
#    awk -F":" '/\/bin\/false/ { print "username: " $1 ", uid: " $3 ", homedir: " $6 }' /etc/passwd
#    echo ""
#}

#------------------------------------------------------------------------------#
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

#------------------------------------------------------------------------------#
# example: translate hello en fr
#translate() {
#    wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=${2:-en}|${3:-es}" | sed -E -n 's/[[:alnum:]": {}]+"translatedText":"([^"]+)".*/\1/p';
#    echo ''
#    return 0;
#    }

#------------------------------------------------------------------------------#
#function eth0up {
#    echo "ifconfig eth0 up"
#    sudo ifconfig eth0 up
#    echo "iwconfig eth0 essid \"Garay\""
#    sudo iwconfig eth0 essid "Garay"
#    echo "sleep 10"
#    sleep 10
#    echo "wpa_supplicant -B -Dwext -i eth0 -c /etc/wpa_supplicant.conf"
#    sudo wpa_supplicant -B -Dwext -i eth0 -c /etc/wpa_supplicant.conf
#    echo "sleep 5"
#    sleep 5
#    echo "dhcpcd eth0"
#    sudo dhcpcd eth0
#    }
#
#function eth1up {
#    echo "ifconfig eth1 up"
#    sudo ifconfig eth1 up
#    echo "iwconfig eth1 essid \"Garay\""
#    sudo iwconfig eth1 essid "Garay"
#    echo "sleep 5"
#    sleep 5
#    echo "wpa_supplicant -B -Dwext -i eth1 -c /etc/wpa_supplicant.conf"
#    sudo wpa_supplicant -B -Dwext -i eth1 -c /etc/wpa_supplicant.conf
#    echo "sleep 5"
#    sleep 5
#    echo "dhcpcd eth1"
#    sudo dhcpcd eth1
#    }

#------------------------------------------------------------------------------#
