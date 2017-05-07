pacman -Syu
pacman -S base-devel hwinfo

pacman -S virtualbox-guest-utils

pacman -S zsh mosh gnupg curl wget vim neovim emacs clang cloc fdupes git \
          tig the_silver_searcher ripgrep htop glances jq tmux mc ranger ncdu \
          tree task weechat lua tcl ruby aspell guile2.0

pacman -S xorg xorg-utils xorg-init rxvt-unicode rxvt-unicode-terminfo urxvt-pearls

pacman -S dwm i3 st dmenu rxvt-256color chromium firefox
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
