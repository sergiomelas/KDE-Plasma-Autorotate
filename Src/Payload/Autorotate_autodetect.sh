#!/bin/bash
# Autorotate_autodetect.sh - Dynamic Hardware Auto-Detection
# Developed by sergio melas 2021-26

##################################################################
#         Autorotate_autodetect.sh   configure syste             #
#              Developed by sergio melas 2021-26                 #
##################################################################

CONF_DIR="/usr/Autorotate"
mkdir -p "$CONF_DIR"

# 1. Keyboard Backlight
KBD_PATH=$(ls /sys/class/leds/*kbd_backlight/brightness 2>/dev/null | head -n 1)
if [ -z "$KBD_PATH" ]; then
    KBD_PATH=$(ls /sys/class/leds/*::kbd_backlight/brightness 2>/dev/null | head -n 1)
fi
echo "${KBD_PATH:-/sys/class/leds/platform::kbd_backlight/brightness}" > "$CONF_DIR/KEYBKLIGHT.conf"

# 2. Audio Sinks
ACTIVE_SINK=""
if command -v pactl &>/dev/null; then
    ACTIVE_SINK=$(pactl info 2>/dev/null | grep "Default Sink:" | awk '{print $3}')
fi
echo "${ACTIVE_SINK:-alsa_output.pci-0000_03_00.6.HiFi__Speaker__sink}" > "$CONF_DIR/SINK.conf"
echo "0" > "$CONF_DIR/SETREVERSE.conf"

# 3. Sound Effects
echo "/usr/share/sounds/freedesktop/stereo/service-login.oga" > "$CONF_DIR/SNDon.conf"
echo "/usr/share/sounds/freedesktop/stereo/service-logout.oga" > "$CONF_DIR/SNDoff.conf"
echo "/usr/share/sounds/freedesktop/stereo/device-added.oga" > "$CONF_DIR/SNDrotate.conf"

# 4. Display Outputs (X11 and Wayland)
SCREEN_X11=""
if command -v xrandr &>/dev/null; then
    SCREEN_X11=$(xrandr 2>/dev/null | grep " connected primary" | awk '{print $1}')
    if [ -z "$SCREEN_X11" ]; then
        SCREEN_X11=$(xrandr 2>/dev/null | grep " connected" | head -n 1 | awk '{print $1}')
    fi
fi
echo "${SCREEN_X11:-eDP}" > "$CONF_DIR/SCREEN.conf"

SCREEN_WAYLAND=""
if command -v kscreen-doctor &>/dev/null; then
    SCREEN_WAYLAND=$(kscreen-doctor -o 2>/dev/null | grep -oP 'Output: \d+ \K\S+' | head -n 1)
fi
echo "${SCREEN_WAYLAND:-eDP-1}" > "$CONF_DIR/SCREENW.conf"

# 5. Digitizers & Inputs
TOUCH=""
PEN=""
ERASER=""
if command -v xinput &>/dev/null; then
    TOUCH=$(xinput list --name-only 2>/dev/null | grep -iE 'finger|touchscreen' | head -n 1)
    PEN=$(xinput list --name-only 2>/dev/null | grep -iE 'pen|stylus' | grep -iv 'eraser' | head -n 1)
    ERASER=$(xinput list --name-only 2>/dev/null | grep -i 'eraser' | head -n 1)
fi

echo "${TOUCH:-Wacom HID 524D Finger touch}" > "$CONF_DIR/TOUCHSCREEN.conf"
echo "${PEN:-Wacom HID 524D Pen stylus}" > "$CONF_DIR/PEN.conf"
echo "${ERASER:-Wacom HID 524D Pen eraser}" > "$CONF_DIR/ERASER.conf"
