#!/bin/bash
##################################################################
# @Name:         Autorotate_theme.sh
# @Package:      kde-autorotate-sml
# @Description:  Interactive Theme Switcher for KDE Autorotate
# @Author:       Sergio Melas <sergiomelas@gmail.com>
##################################################################

THEMES_DIR="/usr/share/kde-autorotate"

# Prompt the user with a graphical selection list
THEME=$(zenity --list --radiolist \
    --title="KDE Autorotate - Theme Selector" \
    --text="Choose your preferred status icon theme:" \
    --column="Select" --column="Theme Name" \
    TRUE  "Theme 1: Blue round arrow" \
    FALSE "Theme 2: Green Red iPad" \
    FALSE "Theme 3: Black Phone" \
    FALSE "Theme 4: White Phone" \
    FALSE "Theme 5: Brown Arrows" \
    FALSE "Theme 6: Rainbow Dark" \
    FALSE "Theme 7: Rainbow Light" 2>/dev/null)

if [ -z "$THEME" ]; then
    exit 0
fi

case "$THEME" in
    *"Theme 2"*) TARGET="Theme_2" ;;
    *"Theme 3"*) TARGET="Theme_3" ;;
    *"Theme 4"*) TARGET="Theme_4" ;;
    *"Theme 5"*) TARGET="Theme_5" ;;
    *"Theme 6"*) TARGET="Theme_6" ;;
    *"Theme 7"*) TARGET="Theme_7" ;;
    *)           TARGET="Theme_1" ;;
esac

# Deploy the selected theme icons into system icons directory
cp -f "$THEMES_DIR/$TARGET"/*.png /usr/share/icons/
chmod 666 /usr/share/icons/rstart*.png /usr/share/icons/rstop*.png /usr/share/icons/rstate.png 2>/dev/null

# Signal KDE to refresh the panel icon cache
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    dbus-send --session --type=signal /KGlobalSettings org.kde.KGlobalSettings.notifyChange int32:2 int32:0[cite: 7]
fi

notify-send -t 3000 "Autorotate Theme" "Icon theme updated to $TARGET" -i /usr/share/icons/rstate.png[cite: 7]
