#!/bin/bash
###################################################################################################################
usage: cd /tmp/ && wget -O xrdp && chmod +x xrdp && ./xrdp
###################################################################################################################

install_xrdp(){

sudo apt-get update

#Install and enable the xRDP tool:

sudo apt-get install xrdp
sudo systemctl enable xrdp

#Choose and set the environment, Xfce or MATE, and allow xRDP to use it:
#Xfce:

sudo apt-get install xfce4 xfce4-terminal
sudo sed -i.bak '/fi/a #xrdp multiple users configuration n xfce-session n' /etc/xrdp/startwm.sh

#MATE:
#sudo apt-get install mate-core mate-desktop-environment mate-notification-daemon
#sudo sed -i.bak '/fi/a #xrdp multiple users configuration n mate-session n' /etc/xrdp/startwm.sh

#Open the RDP port for remote connection:

sudo ufw allow 3389/tcp

#Restart the xRDP server for the changes to take effect:

export DISPLAY=:0.0
#setenv("DISPLAY", ":0", true);

sudo /usr/bin/xfconf-query -c xfce4-session -n -t bool -p /startup/screensaver/enabled -s false
sudo /usr/bin/xfconf-query -c xfwm4 -p /general/use_compositing -s false
sudo adduser xrdp ssl-cert
sudo /etc/init.d/xrdp restart
}

###################################################################################################################

################################################

install_xrdp
