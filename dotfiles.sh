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
  echo "    ./dotfiles.sh link TARGET"
  echo "    ./dotfiles.sh unlink TARGET"
  echo ""
  echo "TARGET may be one of:"
  echo "    all | bash | git | emacs | htop | i3 | kak | mc | nvim | tmux | vim | weechat | xorg"
}

function link_bash() {
  echo $LINK_MSG "bash..."

  if [[ $OS == "linux" ]]; then
    ln "$DOTFILES/bash/linux/.bashrc" ~/.bashrc
    ln "$DOTFILES/bash/linux/.bash_logout" ~/.bash_logout
    ln "$DOTFILES/bash/linux/.bash_profile" ~/.bash_profile
  fi

  if [[ $OS == "darwin" ]]; then
    ln "$DOTFILES/bash/osx/.bashrc" ~/.bashrc
    ln "$DOTFILES/bash/osx/.bash_logout" ~/.bash_logout
    ln "$DOTFILES/bash/osx/.bash_profile" ~/.bash_profile
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
  mkdir -p ~/.local/bin
  ln "$DOTFILES/git/.gitconfig" ~/.gitconfig
  ln "$DOTFILES/git/.gitignore_global" ~/.gitignore_global
  ln "$DOTFILES/git/diff-so-fancy" ~/.local/bin
  chmod +x ~/.local/bin/diff-so-fancy
}

function unlink_git() {
  echo $UNLINK_MSG "git..."
  rm -f ~/.gitconfig
  rm -f ~/.gitignore_global
  rm -f ~/.local/bin/diff-so-fancy
}

function link_emacs() {
  echo $LINK_MSG "emacs..."
  ln -s "$DOTFILES/emacs/.emacs.d" ~/.emacs.d
}

function unlink_emacs() {
  echo $UNLINK_MSG "emacs..."
  rm -rf ~/.emacs.d
}

function link_htop() {
  echo $LINK_MSG "htop..."
  mkdir -p ~/.config/htop
  ln "$DOTFILES/htop/htoprc" ~/.config/htop/htoprc
}

function unlink_htop() {
  echo $UNLINK_MSG "htop..."
  rm -rf ~/.config/htop
}

function link_i3() {
  echo $LINK_MSG "i3..."
  mkdir -p ~/.config/i3
  ln "$DOTFILES/i3/config" ~/.config/i3/config
}

function unlink_i3() {
  echo $UNLINK_MSG "i3..."
  rm -rf ~/.config/i3
}

function link_kak() {
  echo $LINK_MSG "kak..."
  mkdir -p ~/.config/kak
  ln "$DOTFILES/kak/kakrc" ~/.config/kak/kakrc
}

function unlink_kak() {
  echo $UNLINK_MSG "kak..."
  rm -rf ~/.config/kak
}

function link_mc() {
  echo $LINK_MSG "mc..."
  mkdir -p ~/.config/mc
  ln "$DOTFILES/mc/ini" ~/.config/mc/ini
  ln "$DOTFILES/mc/mc.ext" ~/.config/mc/mc.ext
  ln "$DOTFILES/mc/mc.keymap" ~/.config/mc/mc.keymap
  ln -s "$DOTFILES/mc/skins" ~/.config/mc/skins
}

function unlink_mc() {
  echo $UNLINK_MSG "mc..."
  rm -rf ~/.config/mc
}

function link_nvim() {
  echo $LINK_MSG "nvim..."
  mkdir -p ~/.config/nvim/{autoload,plugged}
  ln "$DOTFILES/nvim/init.vim" ~/.config/nvim/init.vim
  ln "$DOTFILES/nvim/autoload/plug.vim" ~/.config/nvim/autoload/plug.vim
}

function unlink_nvim() {
  echo $UNLINK_MSG "nvim..."
  rm -rf ~/.config/nvim
}

function link_tmux() {
  echo $LINK_MSG "tmux..."
  ln "$DOTFILES/tmux/.tmux.conf" ~/.tmux.conf
}

function unlink_tmux() {
  echo $UNLINK_MSG "tmux..."
  rm -f ~/.tmux.conf
}

function link_vim() {
  echo $LINK_MSG "vim..."
  mkdir -p ~/.vim/{backupdir,recoverydir,undodir}
  ln "$DOTFILES/vim/.vimrc" ~/.vimrc
  ln -s "$DOTFILES/vim/.vim/autoload" ~/.vim/autoload
  ln -s "$DOTFILES/vim/.vim/bundle" ~/.vim/bundle
}

function unlink_vim() {
  echo $UNLINK_MSG "vim..."
  rm -f ~/.vimrc
  rm -rf ~/.vim
}

function link_weechat() {
  echo $LINK_MSG "weechat..."
  mkdir -p ~/.weechat
  ln "$DOTFILES/weechat/alias.conf" ~/.weechat/alias.conf
  ln "$DOTFILES/weechat/aspell.conf" ~/.weechat/aspell.conf
  ln "$DOTFILES/weechat/charset.conf" ~/.weechat/charset.conf
  ln "$DOTFILES/weechat/exec.conf" ~/.weechat/exec.conf
  ln "$DOTFILES/weechat/irc.conf" ~/.weechat/irc.conf
  ln "$DOTFILES/weechat/logger.conf" ~/.weechat/logger.conf
  ln "$DOTFILES/weechat/plugins.conf" ~/.weechat/plugins.conf
  ln "$DOTFILES/weechat/relay.conf" ~/.weechat/relay.conf
  ln "$DOTFILES/weechat/rmodifier.conf" ~/.weechat/rmodifier.conf
  ln "$DOTFILES/weechat/script.conf" ~/.weechat/script.conf
  ln "$DOTFILES/weechat/sec.conf" ~/.weechat/sec.conf
  ln "$DOTFILES/weechat/trigger.conf" ~/.weechat/trigger.conf
  ln "$DOTFILES/weechat/weechat.conf" ~/.weechat/weechat.conf
  ln "$DOTFILES/weechat/xfer.conf" ~/.weechat/xfer.conf
  ln -s "$DOTFILES/weechat/perl" ~/.weechat/perl
  ln -s "$DOTFILES/weechat/script" ~/.weechat/script
  ln -s "$DOTFILES/weechat/ssl" ~/.weechat/ssl
}

function unlink_weechat() {
  echo $UNLINK_MSG "weechat..."
  rm -rf ~/.weechat
}

function link_xorg() {
  if [[ $OS == "linux" ]]; then
    echo $LINK_MSG "xorg..."
    ln "$DOTFILES/xorg/.Xdefaults" ~/.Xdefaults
    ln "$DOTFILES/xorg/.xinitrc" ~/.xinitrc
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
    ln "$DOTFILES/zsh/linux/.zlogout" ~/.zlogout
    ln "$DOTFILES/zsh/linux/.zprofile" ~/.zprofile
    ln "$DOTFILES/zsh/linux/.zshenv" ~/.zshenv
    ln "$DOTFILES/zsh/linux/.zshrc" ~/.zshrc
  fi

  if [[ $OS == "darwin" ]]; then
    ln "$DOTFILES/zsh/osx/.zlogout" ~/.zlogout
    ln "$DOTFILES/zsh/osx/.zprofile" ~/.zprofile
    ln "$DOTFILES/zsh/osx/.zshenv" ~/.zshenv
    ln "$DOTFILES/zsh/osx/.zshrc" ~/.zshrc
  fi
}

function unlink_zsh() {
  echo $UNLINK_MSG "zsh..."
  rm -f ~/.zlogout
  rm -f ~/.zprofile
  rm -f ~/.zshenv
  rm -f ~/.zshrc
}

function link_config() {
  case $1 in
    "all")
      link_bash
      link_emacs
      link_git
      link_htop
      link_i3
      link_mc
      link_nvim
      link_tmux
      link_vim
      link_weechat
      link_xorg
      link_zsh
      ;;
    "bash") link_bash ;;
    "emacs") link_emacs ;;
    "git") link_git ;;
    "htop") link_htop ;;
    "i3") link_i3 ;;
    "kak") link_kak ;;
    "mc") link_mc ;;
    "nvim") link_nvim ;;
    "tmux") link_tmux ;;
    "vim") link_vim ;;
    "weechat") link_weechat ;;
    "xorg") link_xorg ;;
    "zsh") link_zsh ;;
    *)
      echo "Error: unrecognized option:" $1
      usage
      exit 1
  esac
}

function unlink_config() {
  case $1 in
    "all")
      unlink_bash
      unlink_emacs
      unlink_git
      unlink_htop
      unlink_i3
      unlink_mc
      unlink_nvim
      unlink_tmux
      unlink_vim
      unlink_weechat
      unlink_xorg
      unlink_zsh
      ;;
    "bash") unlink_bash ;;
    "emacs") unlink_emacs ;;
    "git") unlink_git ;;
    "htop") unlink_htop ;;
    "i3") unlink_i3 ;;
    "kak") unlink_kak ;;
    "mc") unlink_mc ;;
    "nvim") unlink_nvim ;;
    "tmux") unlink_tmux ;;
    "vim") unlink_vim ;;
    "weechat") unlink_weechat ;;
    "xorg") unlink_xorg ;;
    "zsh") unlink_zsh ;;
    *)
      echo "Error: unrecognized option:" $1
      usage
      exit 1
  esac
}

function relink_config() {
  unlink_config $1
  link_config $1
}

function download() {
  wget https://dl.dropboxusercontent.com/u/9332961/kttk.sh
  wget https://dl.dropboxusercontent.com/u/9332961/hoh.sh
}

case $1 in
  "download")
    download
    ;;
  "link")
    link_config $2
    ;;
  "unlink")
    unlink_config $2
    ;;
  "relink")
    relink_config $2
    ;;
  ""|"-h"|"--help"|"help")
    usage
    ;;
  *)
    echo "Error: unrecognized option:" $1 "\n"
    usage
    exit 1
esac
