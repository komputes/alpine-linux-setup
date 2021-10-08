#!/bin/ash

# install packages
apk add curl socat nmap net-tools build-base setxkbmap sudo xrandr bash termite zsh dbus dbus-x11 lightdm-gtk-greeter i3wm i3status libxcb-dev i3lock xf86-video-vmware dmenu mesa-gl glib feh firefox-esr accountsservice openvpn
setup-xorg-base xfce4 xfce4-terminal lightdm dbus-x11 

# install vm and container packages (optional)
apk add open-vm-tools open-vm-tools-guestinfo open-vm-tools-deploypkg open-vm-tools-gtk docker docker-compose
touch /vm_docker_installed

# add user
echo Creating and configuring a non-root user. What username would you like?
echo Username:
read addusername
echo It\'s nice to meet you $addusername
adduser $addusername

# user setup $addusername
mkdir -p /home/$addusername/wallpaper
mkdir -p /$addusername/.config/i3
cp ./files/wallpaper/wallpaper.png /home/$addusername/wallpaper/wallpaper.png
cp ./files/.config/i3/config /home/$addusername/.config/i3/config
cp ./files/.profile /home/$addusername/.profile
mkdir -p /home/$addusername/.scripts
cp ./files/login-script.sh /home/$addusername/.scripts/login-script.sh
chown -R $addusername:$addusername /home/$addusername

# add $addusername to sudoers
cat ./$addusername/sudoers >> /etc/sudoers
sed -i s/YOUR_USER_NAME_HERE/${echo $addusername}/g /etc/sudoers


# greeter background
echo "background=/home/$addusername/wallpaper/wallpaper.png" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./$addusername/wallpaper.conf /var/lib/AccountsService/users/$addusername
sed -i s/YOUR_USER_NAME_HERE/${echo $addusername}/g /var/lib/AccountsService/users/$addusername
chown root:root /var/lib/AccountsService/users/$addusername

# give $addusername write access to /opt dir
chown $addusername:$addusername /opt


if test -f "/vm_docker_installed";
then
    # add user to docker
    addgroup $addusername docker

    # enable copy paste in vmware
    chmod g+s /usr/bin/vmware-user-suid-wrapper

    # mkdir /opt/docker
    mkdir -p /opt/docker
    cp ./docker/* /opt/docker/
    chown $addusername:$addusername /opt/docker

cat >> /vm_docker_installed << EOF2
# The following changes have been made to this machine to set it up with Docker and Virtual Machine support
# Source: https://github.com/komputes/alpine-linux-setup

# vm and container packages
apk add open-vm-tools open-vm-tools-guestinfo open-vm-tools-deploypkg open-vm-tools-gtk docker docker-compose
    
# add user to docker
addgroup $USER docker

# enable copy paste in vmware
chmod g+s /usr/bin/vmware-user-suid-wrapper

# mkdir /opt/docker
mkdir -p /opt/docker
cp ./docker/* /opt/docker/
chown $USER:$USER /opt/docker
EOF2

else
    echo "Looks like you don't need Docker and VM Support."
fi