#!/bin/bash
# Usage:
# ./dotfiles.sh install
# ./dotfiles.sh uninstall

DOTFILES=${2:-$(pwd)} # dotfiles repo location defaults to current directory
OS=$OSTYPE
if [[ ${OS:0:6} == "darwin" ]]; then
    OS="darwin"
elif [[ ${OS:0:5} == "linux" ]]; then
    OS="linux"
fi

INSTALL_MSG="Installing config files for "
UNINSTALL_MSG="Uninstalling config files for "

# DEBUG
# echo COMMAND=$1
# echo HOME=$HOME
# echo DOTFILES=$DOTFILES
# echo OS=$OS

function install_bash() {
  echo $INSTALL_MSG "bash..."

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

function uninstall_bash() {
  echo $UNINSTALL_MSG "bash..."
  rm -f ~/.bashrc
  rm -f ~/.bash_logout
  rm -f ~/.bash_profile
}

function install_git() {
  echo $INSTALL_MSG "git..."
  ln -s $DOTFILES/git/.gitconfig ~/.gitconfig
  ln -s $DOTFILES/git/.gitignore_global ~/.gitignore_global
}

function uninstall_git() {
  echo $UNINSTALL_MSG "git..."
  rm -f ~/.gitconfig
  rm -f ~/.gitignore_global
}

function install_gpg() {
  echo $INSTALL_MSG "gpg..."
  cp -R ~/Dropbox/Private/gpg/.gnupg ~/.gnupg
}

function uninstall_gpg() {
  echo $UNINSTALL_MSG "gpg..."
  rm -rf ~/.gnupg
}

function install_htop() {
  echo $INSTALL_MSG "htop..."
  mkdir -p ~/.config/htop
  ln -s $DOTFILES/htop/htoprc ~/.config/htop/htoprc
}

function uninstall_htop() {
  echo $UNINSTALL_MSG "htop..."
  rm -f ~/.config/htop
}

function install_jrnl() {
  echo $INSTALL_MSG "jrnl..."
  ln -s $DOTFILES/jrnl/.jrnl_config ~/.jrnl_config
}

function uninstall_jrnl() {
  echo $UNINSTALL_MSG "jrnl..."
  rm -f ~/.jrnl_config
}

function install_mc() {
  echo $INSTALL_MSG "mc..."
  mkdir -p ~/.config/mc
  ln -s $DOTFILES/mc/ini ~/.config/mc/ini
  ln -s $DOTFILES/mc/mc.ext ~/.config/mc/mc.ext
  ln -s $DOTFILES/mc/mc.keymap ~/.config/mc/mc.keymap
  ln -s $DOTFILES/mc/skins ~/.config/mc/skins
}

function uninstall_mc() {
  echo $UNINSTALL_MSG "mc..."
  rm -f ~/.config/mc
}

function install_pass() {
  echo $INSTALL_MSG "pass..."
  ln -s ~/Dropbox/Private/pass/.password-store ~/.password-store
}

function uninstall_pass() {
  echo $UNINSTALL_MSG "pass..."
  rm -f .password-store
}

function install_ssh() {
  echo $INSTALL_MSG "ssh..."
  cp -R ~/Dropbox/private/ssh/.ssh ~/.ssh
  chmod 600 ~/.ssh/*
  chmod 700 ~/.ssh
}

function uninstall_ssh() {
  echo $UNINSTALL_MSG "ssh..."
  rm -rf ~/.ssh
}

function install_task() {
  echo $INSTALL_MSG "task..."
  ln -s $DOTFILES/task/.taskrc ~/.taskrc
}

function uninstall_task() {
  echo $UNINSTALL_MSG "task..."
  rm -f ~/.taskrc
}

function install_tmsu() {
  echo $INSTALL_MSG "tmsu..."
  ln -s ~/Dropbox/Private/tmsu/.tmsu ~/.tmsu
}

function uninstall_tmsu() {
  echo $UNINSTALL_MSG "tmsu..."
  rm -f ~/.tmsu
}

function install_tmux() {
  echo $INSTALL_MSG "tmux..."
  ln -s $DOTFILES/tmux/.tmux_config ~/.tmux_conf
}

function uninstall_tmux() {
  echo $UNINSTALL_MSG "tmux..."
  rm -f ~/.tmux_conf
}

function install_vim() {
  echo $INSTALL_MSG "vim..."
  mkdir -p ~/.vim/{backupdir,recoverydir,undodir}
  ln -s $DOTFILES/vim/.vimrc ~/.vimrc
  ln -s $DOTFILES/vim/.vim/autoload ~/.vim/autoload
  ln -s $DOTFILES/vim/.vim/bundle ~/.vim/bundle
}

function uninstall_vim() {
  echo $UNINSTALL_MSG "vim..."
  rm -f ~/.vimrc
  rm -rf ~/.vim
}

function install_weechat() {
  echo $INSTALL_MSG "weechat..."
  mkdir -p ~/.weechat
  # ln -s $DOTFILES/weechat/.weechat ~/.weechat
}

function uninstall_weechat() {
  echo $UNINSTALL_MSG "weechat..."
  rm -f ~/.weechat
}

function install_xorg() {
  if [[ $OS == "linux" ]]; then
    echo $INSTALL_MSG "xorg..."
  fi
  
}

function uninstall_xorg() {
  if [[ $OS == "linux" ]]; then
    echo $UNINSTALL_MSG "xorg..."
  fi
}

function install_zsh() {
  echo $INSTALL_MSG "zsh..."

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

function uninstall_zsh() {
  echo $UNINSTALL_MSG "zsh..."
  rm -f ~/.zlogout
  rm -f ~/.zprofile
  rm -f ~/.zshenv
  rm -f ~/.zshrc
}

function install_config() {
  install_bash
  # install_git
  # install_gpg
  # install_htop
  # install_jrnl
  # install_mc
  # install_pass
  # install_ssh
  # install_task
  # install_tmsu
  # install_tmux
  # install_vim
  # install_weechat
  # install_xorg
  install_zsh
}

function uninstall_config() {
  uninstall_bash
  # uninstall_git
  # uninstall_gpg
  # uninstall_htop
  # uninstall_jrnl
  # uninstall_mc
  # uninstall_pass
  # uninstall_ssh
  # uninstall_task
  # uninstall_tmsu
  # uninstall_tmux
  # uninstall_vim
  # uninstall_weechat
  # uninstall_xorg
  uninstall_zsh
}

case $1 in
  "install")
    install_config
    ;;
  "uninstall")
    uninstall_config
    ;;
esac
