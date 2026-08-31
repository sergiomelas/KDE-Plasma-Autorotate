#!/bin/bash
##################################################################
# @Name:         build_autorotate_deb.sh
# @Package:      kde-autorotate-sml
# @Description:  Debian Package Builder for KDE Autorotate
# @Author:       Sergio Melas <sergiomelas@gmail.com>
##################################################################

set -e

PKG_NAME="kde-autorotate-sml"
PKG_VERSION="3.1-1"
PKG_ARCH="all"
BUILD_DIR="${PKG_NAME}_${PKG_VERSION}_${PKG_ARCH}"

echo "=========================================="
echo " Building Debian Package: ${BUILD_DIR}"
echo "=========================================="

rm -rf "$BUILD_DIR" "${BUILD_DIR}.deb"

# 1. Create Target Directory Hierarchy
mkdir -p "${BUILD_DIR}/DEBIAN"
mkdir -p "${BUILD_DIR}/etc/sddm.conf.d"
mkdir -p "${BUILD_DIR}/etc/xdg/autostart"
mkdir -p "${BUILD_DIR}/usr/bin"
mkdir -p "${BUILD_DIR}/usr/share/applications"
mkdir -p "${BUILD_DIR}/usr/share/icons"
mkdir -p "${BUILD_DIR}/usr/share/kde-autorotate"

# 2. Populate Assets From Payload
cp -r Payload/Theme_* "${BUILD_DIR}/usr/share/kde-autorotate/"
cp Payload/Theme_1/*.png "${BUILD_DIR}/usr/share/icons/"
cp Payload/virtualkbd.conf "${BUILD_DIR}/etc/sddm.conf.d/"
cp Payload/*.desktop "${BUILD_DIR}/usr/share/applications/"
cp Payload/Autorotate_*.sh "${BUILD_DIR}/usr/bin/"

# 3. Create Login Autostart Entry for Clean/Reset Script
cat << 'EOF' > "${BUILD_DIR}/etc/xdg/autostart/Autorotate_clean.desktop"
[Desktop Entry]
Comment=Clean and reset KDE Autorotate state on login
Exec=/usr/bin/Autorotate_clean.sh
Hidden=false
Name=Autorotate Clean
NoDisplay=true
Type=Application
X-KDE-autostart-phase=2
EOF

chmod 755 "${BUILD_DIR}/usr/bin/"*
chmod 644 "${BUILD_DIR}/etc/xdg/autostart/Autorotate_clean.desktop"

# 4. Generate DEBIAN/control
cat << 'EOF' > "${BUILD_DIR}/DEBIAN/control"
Package: kde-autorotate-sml
Version: 3.1-1
Section: utils
Priority: optional
Architecture: all
Maintainer: Sergio Melas <sergiomelas@gmail.com>
Depends: bash, libnotify-bin, iio-sensor-proxy, xdotool, onboard, zenity, pulseaudio-utils, x11-xserver-utils, x11-utils, xserver-xorg-input-wacom, kscreen, psmisc, procps, udev
Recommends: libqt5virtualkeyboard5, qtvirtualkeyboard-plugin, maliit-keyboard
Description: Automatic screen rotation & tablet management suite for KDE Plasma
 Provides unified hardware coordination including display geometry,
 Wacom touchscreen/stylus re-mapping, virtual keyboard integration,
 sound channel rotation, and physical backlight management for Plasma 6.
EOF

# 5. Generate DEBIAN/postinst
cat << 'EOF' > "${BUILD_DIR}/DEBIAN/postinst"
#!/bin/bash
set -e

# Persistent UDEV rule for keyboard LED brightness
cat << 'UDEV_EOF' > /etc/udev/rules.d/99-keyboard-backlight.rules
ACTION=="add", SUBSYSTEM=="leds", KERNEL=="*kbd_backlight", RUN+="/bin/chmod 666 /sys/class/leds/%k/brightness"
ACTION=="add", SUBSYSTEM=="leds", KERNEL=="*::kbd_backlight", RUN+="/bin/chmod 666 /sys/class/leds/%k/brightness"
UDEV_EOF

udevadm control --reload-rules 2>/dev/null || true
udevadm trigger --subsystem-match=leds 2>/dev/null || true
chmod -f 666 /sys/class/leds/*kbd_backlight/brightness 2>/dev/null || true
chmod -f 666 /sys/class/leds/*::kbd_backlight/brightness 2>/dev/null || true

# Dynamic hardware auto-detection
mkdir -p /usr/Autorotate
/usr/bin/Autorotate_autodetect.sh || true
chmod -R 777 /usr/Autorotate

# Default fallback icons
cp -f /usr/share/kde-autorotate/Theme_1/*.png /usr/share/icons/
chmod 777 /usr/share/icons/rstart*.png /usr/share/icons/rstop*.png /usr/share/icons/rstate.png 2>/dev/null || true
chmod 777 /usr/share/icons/'rstart hor'.png /usr/share/icons/'rstart ver'.png 2>/dev/null || true
chmod 777 /usr/share/icons/'rstop hor'.png /usr/share/icons/'rstop ver'.png 2>/dev/null || true

# Deploy Desktop Shortcut with full permissions to all user home directories
for user_home in /home/*; do
    if [ -d "$user_home" ]; then
        username=$(basename "$user_home")
        desktop_dir="$user_home/Desktop"

        if [ -d "$desktop_dir" ]; then
            cp -f /usr/share/applications/Autorotate.desktop "$desktop_dir/"
            chown "$username:$username" "$desktop_dir/Autorotate.desktop"
            chmod 777 "$desktop_dir/Autorotate.desktop"
        fi
    fi
done

# Interactive Theme Chooser with Wayland/X11 session support
ACTIVE_USER=$(who | awk '{print $1}' | head -n 1)
USER_ID=$(id -u "$ACTIVE_USER" 2>/dev/null || echo "1000")

if [ -n "$ACTIVE_USER" ] && [ -x /usr/bin/Autorotate_theme.sh ]; then
    sudo -u "$ACTIVE_USER" \
        DISPLAY="${DISPLAY:-:0}" \
        WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-0}" \
        XDG_RUNTIME_DIR="/run/user/$USER_ID" \
        DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus" \
        /usr/bin/Autorotate_theme.sh || true
fi

exit 0
EOF
chmod 755 "${BUILD_DIR}/DEBIAN/postinst"

# 6. Generate DEBIAN/prerm
cat << 'EOF' > "${BUILD_DIR}/DEBIAN/prerm"
#!/bin/bash
set -e

killall Autorotate_pos.sh 2>/dev/null || true
killall Autorotate_rot.sh 2>/dev/null || true
killall monitor-sensor 2>/dev/null || true

rm -rf /usr/Autorotate
rm -f /etc/udev/rules.d/99-keyboard-backlight.rules
rm -f /etc/xdg/autostart/Autorotate_clean.desktop

# Clean up Desktop shortcuts from user profiles
for user_home in /home/*; do
    if [ -d "$user_home/Desktop" ]; then
        rm -f "$user_home/Desktop/Autorotate.desktop"
    fi
done

rm -f /usr/share/icons/rstart*.png /usr/share/icons/rstop*.png /usr/share/icons/rstate.png
rm -f /usr/share/icons/'rstart hor'.png /usr/share/icons/'rstart ver'.png
rm -f /usr/share/icons/'rstop hor'.png /usr/share/icons/'rstop ver'.png

udevadm control --reload-rules 2>/dev/null || true

exit 0
EOF
chmod 755 "${BUILD_DIR}/DEBIAN/prerm"

# 7. Build and Cleanup
dpkg-deb --build --root-owner-group "$BUILD_DIR"
rm -rf "$BUILD_DIR"

echo "=========================================="
echo " Package successfully built: ${BUILD_DIR}.deb"
echo "=========================================="
