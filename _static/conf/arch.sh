echo 'Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch' > /etc/pacman.d/mirrorlist
echo '[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
' >> /etc/pacman.conf
pacman -Sy
pacman -S archlinuxcn-keyring
pacman -Sy
pacman -S yay
# input method
#fcitx-sogoupinyin fcitx-im
yay -S fcitx-qt5 \
fcitx-gtk3 \
fctix-googlepinyin \
shadowsocks-qt5 \
google-chrome \
go goland pycharm datagri \
netease-cloud-music \
wps-offie \
ttf-wps-fonts \
ttf-dejavu wqy-zenhei wqy-microhei \
wireshark-qt \
#don't forget gpasswd -a username wireshark

#deepin.com.qq.im
# add env to .xinitrc or profile

#vmware 
linux-headers \

vmware-modconfig --console --install-all
modprobe vmmon
modprobe vmci
modprobe vmnet
# need start service
#vmware-hostd vmware-networks vmware-usbarbitrator

# uninstall
yay -Rsn firefox \
steam-manjaro
