pacman -Syu
pacman -S base-devel hwinfo

pacman -S virtualbox-guest-utils

pacman -S zsh mosh gnupg pass curl wget vim neovim emacs clang cloc fdupes git \
          tig the_silver_searcher ripgrep htop glances jq tmux mc ranger ncdu \
          tree task weechat lua tcl ruby aspell guile2.0 mlocate \
          python-pip python2-pip

pip install jrnl

pacman -S xorg xorg-utils xorg-init rxvt-unicode rxvt-unicode-terminfo urxvt-pearls

pacman -S dwm i3 st dmenu feh concky chromium firefox
pacman -S chromium firefox

useradd -G wheel -m -s /usr/bin/zsh -p askatasuna -U igaray

# SET FRAMEBUFFER RESOLUTION
#
# If you use GRUB as your bootloader, you can edit /etc/default/grub to include
# this kernel parameter in the GRUB_CMDLINE_LINUX_DEFAULT list, like so:
#
# GRUB_CMDLINE_LINUX_DEFAULT="quiet video=1280x800"
#
# The GRUB menu itself may also be easily set to optimal resolution, by editing
# the GRUB_GFXMODE option on the same configuration file:
#
# GRUB_GFXMODE="1280x800x24"
#
# On a standard Arch setup, you would then run
# grub-mkconfig -o /boot/grub/grub.cfg to commit these changes to the bootloader.

# SET CONSOLE FONT
#
# The FONT variable in /etc/vconsole.conf is used to set the font at boot,
# persistently for all consoles
#
# FONT=Lat2-Terminus16

# SET X CONFIG
VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --seamless
VBoxClient --display
VBoxClient --checkhostversion

# CONFIGURE ST

# GET kttk, hoh and dotfiles
mkdir sys
cd sys
wget -O kttk.sh http://bit.ly/2ju8KQ5
wget -O hoh.sh http://bit.ly/2nYN1PP
git clone git@github.com:igaray/dotfiles.git

sudo updatedb

####################################################################################################
# Install Base System

# Edit /boot/grub/menu.lst
# Add vga=792 to the kernel line, and uncomment the windows loader.

# copy over /etc/rc.conf

# Ugrade system.
pacman -Syy
pacman -Syu

# copy over /etc/pacman.conf
# Ignoring Configuration Files
# You can "protect" your configuration/system files from being overwritten during "pacman -Su" using the following option in your /etc/pacman.conf
# NoUpgrade = etc/lilo.conf boot/grub/menu.lst

# copy over /etc/pacman.d/mirrors

# add user
# useradd -m -G [groups] -s [login_shell] [username]
useradd -m -G users,audio,optical,storage,video,wheel,power -s /bin/bash igaray
passwd igaray

# install sudo
# copy over the configuration file

# configure ALSA

# Install basic utilities and libraries.
pacman -S cmake
pacman -S abs
pacman -S e2fsprogs
pacman -S zip unzip unrar

# Power management
pacman -S acpi
pacman -S powertop
pacman -S cpurequtils
pacman -S pm-utils
pacman -S laptop-mode-tools

# Configure /etc/laptop-mode.conf:
CONTROL_HD_POWERMGMT=1

BATT_HD_POWERMGMT=255
LM_AC_HD_POWERMGMT=255
NOLM_AC_HD_POWERMGMT=255

# Set noatime on partitions in fstab

# Install Wifi drivers

####################################################################################################
# Install X
pacman -S xorg mesa libgl xf86-video-intel proto xcb
pacman -S ttf-ms-fonts ttf-dejavu ttf-bitstream-vera artwiz-fonts
pacman -S xproto

# Configure X
# Copy xorg.conf /etc/X11/

# Configure input hotplugging
pacman -S hal dbus xf86-input-evdev xf86-input-synaptics

cp  /usr/share/hal/fdi/policy/10osvendor/10-keymap.fdi /etc/hal/fdi/policy
vim /etc/hal/fdi/policy/10-keymap.fdi

####################################################################################################
# GUI

# Install Awesome
pacman -S awesome
pacman -S feh
pacman -S scrot

# Configure Awesome
# Copy rc.lua to /home/igaray/.config/awesome
# Copy theme.lua to /home/igaray/.config/awesome

# Install terminal:
pacman -Sy rxvt-unicode-256color

# Install MC (midnight commander)
pacman -S mc

# Configure MC
# Copy over the .mc/ini and .mc/bindings files

#####################################################################################################
# Editors

# OpenOffice
pacman -S openoffice-base pstoedit

#####################################################################################################
# Internet:

# Firefox: Vimperator, XMarks, FastDial
pacman -S firefox flashplugin gecko-mediaplayer

# Weechat
pacman -S weechat

# Skype

#####################################################################################################
# Programming:

# Vim
pacman -S vim

# Emacs 23.1
pacman -S emacs

# R: R
pacman -S r

# Erlang: erlang
pacman -S erlang

# Prolog: SWI Prolog
pacman -S swi-prolog

# Haskell: glasgow haskell compiler
pacman -S ghc

# LISP: GNU Common Lisp
pacman -S sbcl clisp ecls

# Lua
pacman -S lua

# Python: Python 3.0
# C: gcc / eclipse
# c++: g++ / eclipse
# Java: jdk / netbeans
pacman -S jre

#####################################################################################################
# Science:

# GNU Octave / QtOctave
pacman -S octave gnuplot rlwrap tk

# Maxima / wxMaxima
pacman -S maxima

#####################################################################################################
# Media:

# Codecs
pacman -S gstreamer0.10-base
pacman -S gstreamer0.10-good
pacman -S gstreamer0.10-good-plugins
pacman -S gstreamer0.10-bad
pacman -S gstreamer0.10-bad-plugins
pacman -S gstreamer0.10-ugly
pacman -S gstreamer0.10-ugly-plugins
pacman -S gstreamer0.10-ffmpeg

# moc (music on console)
pacman -S moc

# Configure MOC colors

# Amarok
pacman -S amarok loudmouth qca

# Grip
pacman -S grip

# Kid3
pacman -S kid3

# pyRenamer
# download the AUR package for pyrenamer
# untar
makepg -s
# install new package via pacman -U new_package

# VLC
pacman -S vlc

# KB3
pacman -S kb3 cdrtools dvd+rw-tools

#####################################################################################################
# Latex editing environment
pacman -S tetex ghostscript psutils

#####################################################################################################
# Blender3D
pacman -S blender
