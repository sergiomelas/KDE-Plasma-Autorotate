#!/bin/bash
#This script will remove autorotate system for KDE

##################################################################
#              Developed by sergio melas 2021-26                    #
##################################################################

# Stop the background daemons safely
killall    Autorotate_pos.sh
killall    Autorotate_rot.sh

# Remove core configuration trees and state semaphores
sudo rm -r /usr/Autorotate
sudo rm -r $HOME/.autorotate

# Remove system binaries and launchers
sudo rm  /usr/bin/Autorotate_toggle.sh
sudo rm  /usr/bin/Autorotate_pos.sh
sudo rm  /usr/bin/Autorotate_rot.sh
sudo rm  /usr/bin/Autorotate_clean.sh
sudo rm  /usr/share/applications/Autorotate.desktop
rm  $HOME/Desktop/Autorotate.desktop

# Remove gtaphical objects
sudo rm  /usr/share/icons/rstart.png
sudo rm  /usr/share/icons/'rstart hor'.png
sudo rm  /usr/share/icons/'rstart ver'.png
sudo rm  /usr/share/icons/'rstop hor'.png
sudo rm  /usr/share/icons/'rstop ver'.png
sudo rm  /usr/share/icons/rstate.png

Remove the SDDM virtual keyboard override mod
sudo rm  /etc/sddm.conf.d/virtualkbd.conf

# Removing Rc local.
sudo rm  /etc/rc.local

echo "KDE Autorotate has been successfully and cleanly removed."
