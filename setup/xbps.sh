function base() {
    xbps-install -Su
    xbps-install \
        cryptsetup \
        curl \
        emacs \
        exa \
        fdupes \
        gcc \
        git \
        gnupg \
        mc \
        mosh \
        ncdu \
        neovim \
        nnn \
        pass \
        python \
        python-pip \
        python3 \
        python3-pip \
        task \
        the_silver_searcher \
        tmux \
        tree \
        vim \
        weechat \
        wget \
        xz \
        zsh \

    mkdir ~/sys
    cd ~/sys
    wget -O hoh.sh http://bit.ly/2nYN1PP
    sh unpack_hoh.sh
    ./hoh.sh install all

    cd ~/sys
    git clone git@github.com:igaray/dotfiles.git
}

function vbox_guest() {
    xbps-install -Sv dbus
    ln -s /etc/sv/dbus /var/service/

    xbps-install -Sv virtualbox-ose-guest
    ln -s /etc/sv/vboxservice /var/service/

}

function xorg() {
    xbps-install -S xorg dwm i3 i3status st dmenu
    xbps-install -S chromium firefox

}

base()
