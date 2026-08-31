#!/bin/bash
##################################################################
#              Developed by Sergio Melas 2021-26                 #
##################################################################

echo "Removing KDE Autorotate..."

# Stop daemons
killall Autorotate_pos.sh 2>/dev/null || true
killall Autorotate_rot.sh 2>/dev/null || true
killall monitor-sensor 2>/dev/null || true

# Remove configurations and runtime states
sudo rm -rf /usr/Autorotate
rm -rf "$HOME/.autorotate"

# Remove binaries and launchers
sudo rm -f /usr/bin/Autorotate_*.sh
sudo rm -f /usr/share/applications/Autorotate*.desktop
rm -f "$HOME/Desktop/Autorotate.desktop"

# Remove UDEV rules and SDDM conf
sudo rm -f /etc/udev/rules.d/99-keyboard-backlight.rules
sudo udevadm control --reload-rules || true
sudo rm -f /etc/sddm.conf.d/virtualkbd.conf

# Purge all installed icons and themes
sudo rm -rf /usr/share/kde-autorotate
sudo rm -f /usr/share/icons/rstart*.png /usr/share/icons/rstop*.png /usr/share/icons/rstate.png
sudo rm -f /usr/share/icons/'rstart hor'.png /usr/share/icons/'rstart ver'.png
sudo rm -f /usr/share/icons/'rstop hor'.png /usr/share/icons/'rstop ver'.png

echo "KDE Autorotate has been completely removed."
