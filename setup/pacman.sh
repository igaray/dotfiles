pacman -Syu
pacman -S base-devel

pacman -S virtualbox-guest-utils

pacman -S \
          aspell \
          clang \
          clisp \
          cloc \
          cmake \
          curl \
          e2fsprogs \
          ecl \
          emacs \
          fdupes \
          ghc \
          git \
          glances \
          gnupg \
          guile2.0 \
          htop \
          hwinfo \
          jq \
          lua \
          mc \
          mlocate \
          mosh \
          ncdu \
          neovim \
          pass \
          python-pip \
          python2-pip \
          r \
          ranger \
          ripgrep \
          ruby \
          sbcl \
          swi-prolog \
          task \
          tcl \
          the_silver_searcher \
          tig \
          tmux \
          tree \
          unrar \
          unzip \
          vim \
          weechat \
          wget \
          zip \
          zsh

pip install jrnl

# Install X
pacman -S \
          artwiz-fonts \
          awesome \
          chromium \
          chromium \
          concky \
          dmenu \
          dwm \
          feh \
          feh \
          firefox
          firefox \
          i3 \
          rxvt-unicode \
          rxvt-unicode-terminfo \
          scrot \
          st \
          ttf-bitstream-vera \
          ttf-dejavu \
          ttf-ms-fonts \
          urxvt-pearls \
          vlc \
          xorg \
          xorg-init \
          xorg-utils

useradd -G users,storage,video,wheel,power -m -s /usr/bin/zsh -p askatasuna -U igaray

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

# AUR
pacaur -S kakoune-git
pacaur -S nnn

# CONFIGURE ST

# GET kttk, hoh and dotfiles
mkdir sys
cd sys
wget -O kttk.sh http://bit.ly/2ju8KQ5
wget -O hoh.sh http://bit.ly/2nYN1PP
git clone git@github.com:igaray/dotfiles.git

sudo updatedb
