#!/bin/bash
#Autorotate_conf.sh

            ##################################################################
            #               Autorotate Configuration file                    #
            #              Developed by sergio melas  2021-25                #
            ##################################################################




#########################################################################################
#KEYBOARD BACKLIGHT:Update this according to output form command: ls /sys/class/leds/
#add "/brightness" at the end,ie :/sys/class/leds/<KEYBOARD BACKLIGHT>/brightness
KEYBKLIGHT=/sys/class/leds/platform::kbd_backlight/brightness


#########################################################################################
#SOUND:Update this according to output form command:pactl list sinks short
#xx   yyyyyyyyyyyyyyyyyyyyyyyyyyy
#using yyyyyyyyyyyyyyyyyyyyyyyyyyy:
#Note if using pulseeffect or easyeffects use it instead of phisical output
SINK=alsa_output.pci-0000_03_00.6.HiFi__hw_Generic_1__sink
#SINK=easyeffects_sink
#SINK=PulseEffects_mic

#########################################################################################
#SOUND:Activate reverse stero in down position

SETREVERSE=0
#SETREVERSE=1


#####################################OPTIONAL############################################
#SOUNDS: activation, desactivation, each rotation
SNDon=/usr/share/sounds/freedesktop/stereo/service-login.oga
SNDoff=/usr/share/sounds/freedesktop/stereo/service-logout.oga
SNDrotate=/usr/share/sounds/freedesktop/stereo/device-added.oga


#########################################################################################
#                           Related only to X11 dont fill if wayland only               #
#########################################################################################

#SCREEN: Update this according to output form command: xrandr|grep "connected primary"
#In multimonitor setup choose the screen atthached to the laptop
#Need to be executed in a X11 Session
# xxxx connected primary ......
#SCREEN="xxxx"
SCREEN="eDP"

#########################################################################################
#                           Related only to Wayland dont fill if x11 only               #
#########################################################################################


#SCREEN: Update this according to output form command: kscreen-doctor -o
#Need to be executed in a Wayland Session
#Output: y xxxx
#SCREENW="xxxx"
SCREENW="eDP-1"

#DIGITIZERS:Update this according to output form command: xinput list
TOUCHSCREEN="Wacom HID 524D Finger touch"
PEN="Wacom HID 524D Pen stylus"
ERASER="Wacom HID 524D Pen eraser"

















#########################################################################################
#########################################################################################
#########################################################################################
#                              Do not edit below this point                             #
#########################################################################################
#########################################################################################
#########################################################################################

echo
echo $SNDon       | sudo tee -a /usr/Autorotate/SNDon.conf       > /dev/null
echo $SNDoff      | sudo tee -a /usr/Autorotate/SNDoff.conf      > /dev/null
echo $SNDrotate   | sudo tee -a /usr/Autorotate/SNDrotate.conf   > /dev/null
echo $SCREEN      | sudo tee -a /usr/Autorotate/SCREEN.conf      > /dev/null
echo $SCREENW     | sudo tee -a /usr/Autorotate/SCREENW.conf      > /dev/null
echo $TOUCHSCREEN | sudo tee -a /usr/Autorotate/TOUCHSCREEN.conf > /dev/null
echo $PEN         | sudo tee -a /usr/Autorotate/PEN.conf         > /dev/null
echo $ERASER      | sudo tee -a /usr/Autorotate/ERASER.conf      > /dev/null
echo $KEYBKLIGHT  | sudo tee -a /usr/Autorotate/KEYBKLIGHT.conf  > /dev/null
echo $SINK        | sudo tee -a /usr/Autorotate/SINK.conf        > /dev/null
echo $SETREVERSE  | sudo tee -a /usr/Autorotate/SETREVERSE.conf  > /dev/null



