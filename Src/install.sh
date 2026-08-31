#!/bin/bash
##################################################################
#              Developed by Sergio Melas 2021-26                 #
##################################################################

echo "=========================================="
echo " Installing KDE Autorotate (Standalone)"
echo "=========================================="

# 1. Stop any running instances
killall Autorotate_pos.sh 2>/dev/null || true
killall Autorotate_rot.sh 2>/dev/null || true
killall monitor-sensor 2>/dev/null || true

# 2. Install persistent UDEV rule for keyboard backlight LED permissions
sudo tee /etc/udev/rules.d/99-keyboard-backlight.rules > /dev/null << 'EOF'
ACTION=="add", SUBSYSTEM=="leds", KERNEL=="*kbd_backlight", RUN+="/bin/chmod 666 /sys/class/leds/%k/brightness"
ACTION=="add", SUBSYSTEM=="leds", KERNEL=="*::kbd_backlight", RUN+="/bin/chmod 666 /sys/class/leds/%k/brightness"
EOF
sudo udevadm control --reload-rules || true
sudo udevadm trigger --subsystem-match=leds || true
sudo chmod -f 666 /sys/class/leds/*kbd_backlight/brightness 2>/dev/null || true
sudo chmod -f 666 /sys/class/leds/*::kbd_backlight/brightness 2>/dev/null || true

# 3. Run Hardware Auto-Detection
sudo mkdir -p /usr/Autorotate
chmod +x Payload/Autorotate_autodetect.sh
sudo ./Payload/Autorotate_autodetect.sh
sudo chmod -R 777 /usr/Autorotate

# 4. Copy Binaries to System Path
sudo cp Payload/Autorotate_*.sh /usr/bin/
sudo chmod 755 /usr/bin/Autorotate_*.sh

# 5. Copy Desktop Launchers to Menu and Desktop
sudo cp Payload/*.desktop /usr/share/applications/
if [ -d "$HOME/Desktop" ]; then
    cp Payload/Autorotate.desktop "$HOME/Desktop/"
    chmod +x "$HOME/Desktop/Autorotate.desktop"
fi

# 6. Setup Themes and Icons
sudo mkdir -p /usr/share/kde-autorotate
sudo cp -r Payload/Theme_* /usr/share/kde-autorotate/
sudo cp Payload/Theme_1/*.png /usr/share/icons/
sudo chmod 777 /usr/share/icons/rstart*.png /usr/share/icons/rstop*.png /usr/share/icons/rstate.png 2>/dev/null || true
sudo chmod 777 /usr/share/icons/'rstart hor'.png /usr/share/icons/'rstart ver'.png 2>/dev/null || true
sudo chmod 777 /usr/share/icons/'rstop hor'.png /usr/share/icons/'rstop ver'.png 2>/dev/null || true

# 7. SDDM Virtual Keyboard Config
sudo mkdir -p /etc/sddm.conf.d
sudo cp Payload/virtualkbd.conf /etc/sddm.conf.d/

# 8. Setup Auto-clean on Login
sudo mkdir -p /etc/xdg/autostart
sudo cp Payload/Autorotate_clean.desktop /etc/xdg/autostart/

# 9. Trigger Interactive Theme Selector
if [ -x /usr/bin/Autorotate_theme.sh ]; then
    /usr/bin/Autorotate_theme.sh || true
fi

echo "=========================================="
echo " KDE Autorotate installed successfully!"
echo "=========================================="
