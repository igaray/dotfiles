#!/bin/bash

DOTFILES=$(pwd) # dotfiles repo location defaults to current directory
OS=$OSTYPE
if [[ ${OS:0:6} == "darwin" ]]; then
    OS="darwin"
elif [[ ${OS:0:5} == "linux" ]]; then
    OS="linux"
fi

LINK_MSG="Linking config files for"
UNLINK_MSG="Unlinking config files for"

# DEBUG
#echo HOME=$HOME
#echo DOTFILES=$DOTFILES
#echo OS=$OS
#echo ARG1=$1
#echo ARG2=$2

function usage() {
  echo "Usage:"
  echo "    ./dotfiles.sh help"
  echo "    ./dotfiles.sh deps OS"
  echo "    ./dotfiles.sh link TARGET"
  echo "    ./dotfiles.sh unlink TARGET"
  echo ""
  echo "OS may be one of: "
  echo "    arch | debian | void | darwin"
  echo ""
  echo "TARGET may be one of:"
  echo "    all | bash | git | htop | jrnl | mc | taskwarrior | tmux | vim | weechat | xorg"
}

function link_bash() {
  echo $LINK_MSG "bash..."

  if [[ $OS == "linux" ]]; then
    ln -s $DOTFILES/bash/linux/.bashrc ~/.bashrc
    ln -s $DOTFILES/bash/linux/.bash_logout ~/.bash_logout
    ln -s $DOTFILES/bash/linux/.bash_profile ~/.bash_profile
  fi

  if [[ $OS == "darwin" ]]; then
    ln -s $DOTFILES/bash/osx/.bashrc ~/.bashrc
    ln -s $DOTFILES/bash/osx/.bash_logout ~/.bash_logout
    ln -s $DOTFILES/bash/osx/.bash_profile ~/.bash_profile
  fi
}

function unlink_bash() {
  echo $UNLINK_MSG "bash..."
  rm -f ~/.bashrc
  rm -f ~/.bash_logout
  rm -f ~/.bash_profile
}

function link_git() {
  echo $LINK_MSG "git..."
  ln -s $DOTFILES/git/.gitconfig ~/.gitconfig
  ln -s $DOTFILES/git/.gitignore_global ~/.gitignore_global
}

function unlink_git() {
  echo $UNLINK_MSG "git..."
  rm -f ~/.gitconfig
  rm -f ~/.gitignore_global
}

function link_htop() {
  echo $LINK_MSG "htop..."
  mkdir -p ~/.config/htop
  ln -s $DOTFILES/htop/htoprc ~/.config/htop/htoprc
}

function unlink_htop() {
  echo $UNLINK_MSG "htop..."
  rm -rf ~/.config/htop
}

function link_jrnl() {
  echo $LINK_MSG "jrnl..."
  ln -s $DOTFILES/jrnl/.jrnl_config ~/.jrnl_config
}

function unlink_jrnl() {
  echo $UNLINK_MSG "jrnl..."
  rm -f ~/.jrnl_config
}

function link_mc() {
  echo $LINK_MSG "mc..."
  mkdir -p ~/.config/mc
  ln -s $DOTFILES/mc/ini ~/.config/mc/ini
  ln -s $DOTFILES/mc/mc.ext ~/.config/mc/mc.ext
  ln -s $DOTFILES/mc/mc.keymap ~/.config/mc/mc.keymap
  ln -s $DOTFILES/mc/skins ~/.config/mc/skins
}

function unlink_mc() {
  echo $UNLINK_MSG "mc..."
  rm -rf ~/.config/mc
}

function link_taskwarrior() {
  echo $LINK_MSG "taskwarrior..."
  ln -s $DOTFILES/task/.taskrc ~/.taskrc
}

function unlink_taskwarrior() {
  echo $UNLINK_MSG "taskwarrior..."
  rm -f ~/.taskrc
}

function link_tmux() {
  echo $LINK_MSG "tmux..."
  ln -s $DOTFILES/tmux/.tmux.conf ~/.tmux.conf
}

function unlink_tmux() {
  echo $UNLINK_MSG "tmux..."
  rm -f ~/.tmux.conf
}

function link_vim() {
  echo $LINK_MSG "vim..."
  mkdir -p ~/.vim/{backupdir,recoverydir,undodir}
  ln -s $DOTFILES/vim/.vimrc ~/.vimrc
  ln -s $DOTFILES/vim/.vim/autoload ~/.vim/autoload
  ln -s $DOTFILES/vim/.vim/bundle ~/.vim/bundle
}

function unlink_vim() {
  echo $UNLINK_MSG "vim..."
  rm -f ~/.vimrc
  rm -rf ~/.vim
}

function link_weechat() {
  echo $LINK_MSG "weechat..."
  mkdir -p ~/.weechat
  ln -s $DOTFILES/weechat/alias.conf ~/.weechat/alias.conf
  ln -s $DOTFILES/weechat/aspell.conf ~/.weechat/aspell.conf
  ln -s $DOTFILES/weechat/charset.conf ~/.weechat/charset.conf
  ln -s $DOTFILES/weechat/exec.conf ~/.weechat/exec.conf
  ln -s $DOTFILES/weechat/irc.conf ~/.weechat/irc.conf
  ln -s $DOTFILES/weechat/logger.conf ~/.weechat/logger.conf
  ln -s $DOTFILES/weechat/plugins.conf ~/.weechat/plugins.conf
  ln -s $DOTFILES/weechat/relay.conf ~/.weechat/relay.conf
  ln -s $DOTFILES/weechat/rmodifier.conf ~/.weechat/rmodifier.conf
  ln -s $DOTFILES/weechat/script.conf ~/.weechat/script.conf
  ln -s $DOTFILES/weechat/sec.conf ~/.weechat/sec.conf
  ln -s $DOTFILES/weechat/trigger.conf ~/.weechat/trigger.conf
  ln -s $DOTFILES/weechat/weechat.conf ~/.weechat/weechat.conf
  ln -s $DOTFILES/weechat/xfer.conf ~/.weechat/xfer.conf
  ln -s $DOTFILES/weechat/perl ~/.weechat/perl
  ln -s $DOTFILES/weechat/script ~/.weechat/script
  ln -s $DOTFILES/weechat/ssl ~/.weechat/ssl
}

function unlink_weechat() {
  echo $UNLINK_MSG "weechat..."
  rm -rf ~/.weechat
}

function link_xorg() {
  if [[ $OS == "linux" ]]; then
    echo $LINK_MSG "xorg..."
    ln -s $DOTFILES/xorg/.Xdefaults ~/.Xdefaults
    ln -s $DOTFILES/xorg/.xinitrc ~/.xinitrc
  fi
}

function unlink_xorg() {
  if [[ $OS == "linux" ]]; then
    echo $UNLINK_MSG "xorg..."
    rm -f ~/.Xdefaults
    rm -f ~/.xinitrc
  fi
}

function link_zsh() {
  echo $LINK_MSG "zsh..."

  if [[ $OS == "linux" ]]; then
    ln -s $DOTFILES/zsh/linux/.zlogout ~/.zlogout
    ln -s $DOTFILES/zsh/linux/.zprofile ~/.zprofile
    ln -s $DOTFILES/zsh/linux/.zshenv ~/.zshenv
    ln -s $DOTFILES/zsh/linux/.zshrc ~/.zshrc
  fi

  if [[ $OS == "darwin" ]]; then
    ln -s $DOTFILES/zsh/osx/.zlogout ~/.zlogout
    ln -s $DOTFILES/zsh/osx/.zprofile ~/.zprofile
    ln -s $DOTFILES/zsh/osx/.zshenv ~/.zshenv
    ln -s $DOTFILES/zsh/osx/.zshrc ~/.zshrc
  fi
}

function unlink_zsh {
  echo $UNLINK_MSG "zsh..."
  rm -f ~/.zlogout
  rm -f ~/.zprofile
  rm -f ~/.zshenv
  rm -f ~/.zshrc
}

function link_config {
  case $1 in
    "all")
      link_bash
      link_git
      link_htop
      link_jrnl
      link_mc
      link_taskwarrior
      link_tmux
      link_vim
      link_weechat
      link_xorg
      link_zsh
      ;;
    "bash")
      link_bash
      ;;
    "git")
      link_git
      ;;
    "htop")
      link_htop
      ;;
    "jrnl")
      link_jrnl
      ;;
    "mc")
      link_mc
      ;;
    "taskwarrior")
      link_taskwarrior
      ;;
    "tmux")
      link_tmux
      ;;
    "vim")
      link_vim
      ;;
    "weechat")
      link_weechat
      ;;
    "xorg")
      link_xorg
      ;;
    "zsh")
      link_zsh
      ;;
  esac
}

function unlink_config {
  case $1 in
    "all")
      unlink_bash
      unlink_git
      unlink_htop
      unlink_jrnl
      unlink_mc
      unlink_taskwarrior
      unlink_tmux
      unlink_vim
      unlink_weechat
      unlink_xorg
      unlink_zsh
      ;;
    "bash")
      unlink_bash
      ;;
    "git")
      unlink_git
      ;;
    "htop")
      unlink_htop
      ;;
    "jrnl")
      unlink_jrnl
      ;;
    "mc")
      unlink_mc
      ;;
    "taskwarrior")
      unlink_taskwarrior
      ;;
    "tmux")
      unlink_tmux
      ;;
    "vim")
      unlink_vim
      ;;
    "weechat")
      unlink_weechat
      ;;
    "xorg")
      unlink_xorg
      ;;
    "zsh")
      unlink_zsh
      ;;
  esac
}

function install_deps {
  case $1 in
    "arch")
      echo "Installing dependencies for" $1
      pacman -S git gnupg htop mc pass taskwarrior tmux vim weechat zsh
      ;;
    "debian")
      echo "Installing dependencies for" $1
      apt-get install git gnupg htop mc pass taskwarrior tmux vim weechat zsh python-pip
      pip install jrnl
      ;;
    "void")
      echo "Installing dependencies for" $1
      xbps install git gnupg htop mc pass taskwarrior tmux vim weechat zsh
      ;;
    "darwin")
      echo "Installing dependencies for" $1
      brew install git gnupg htop mc pass task tmux vim weechat zsh
      ;;
    *)
      echo "Error! Unrecognized option:" $1
      echo ""
      usage
      ;; 
  esac
}

case $1 in
  "deps")
    install_deps $2
    ;;
  "link")
    link_config $2
    ;;
  "unlink")
    unlink_config $2
    ;;
  ""|"help")
    usage
    ;;
  ""|"-h"|"--help"|"help")
    usage
    ;;
  *)
    echo "Error: unrecognized option:" $1 "\n"
    usage
    exit 1
esac