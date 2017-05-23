xbps-install -Su

xbps-install -Sv dbus
ln -s /etc/sv/dbus /var/service/

xbps-install -Sv virtualbox-ose-guest
ln -s /etc/sv/vboxservice /var/service/

xbps-install curl wget
xbps-install -S xorg dwm i3 i3status st dmenu
xbps-install -S gcc
xbps-install -S chromium firefox

wget -O unpack_kttk.sh http://bit.ly/2ju8KQ5
sh unpack_kttk.sh
./kttk.sh install all

wget -O hoh.sh http://bit.ly/???????
sh unpack_hoh.sh
./hoh.sh install all
