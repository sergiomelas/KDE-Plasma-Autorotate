#!/bin/bash
#Autorotate_toggle.sh

##################################################################
#         Autorotate_toggle.sh   toggle on/off the rotation      #
#              Developed by sergio melas 2021-23                 #
##################################################################




TOGGLE=$HOME/.autorotate/.toggle              #Toggle rotation on off
MTOGGLE=$HOME/.autorotate/.mtoggle            #One shot toggle

SNDon=$( cat /usr/Autorotate/SNDon.conf )     #Sound on
SNDoff=$( cat /usr/Autorotate/SNDoff.conf )   #Sound off

MUP=$HOME/.autorotate/.mup                    #Toggle last rotation up
MLEFT=$HOME/.autorotate/.mleft                #Toggle last rotation left
MRIGHT=$HOME/.autorotate/.mright              #Toggle last rotation right
MDOWN=$HOME/.autorotate/.mdown                #Toggle last rotation down

SCREEN=$( cat /usr/Autorotate/SCREEN.conf )
TOUCHSCREEN=$( cat /usr/Autorotate/TOUCHSCREEN.conf )
PEN=$( cat /usr/Autorotate/PEN.conf )
ERASER=$( cat /usr/Autorotate/ERASER.conf )



if [ -e $MTOGGLE ];
    then
    exit 0
fi

touch $MTOGGLE

if [ ! -e $TOGGLE ]; then

    #change icon and refresh desktop klicking
    #cp /usr/share/icons/'rstart'.png /usr/share/icons/rstate.png
    touch $TOGGLE

    #Start up rotation sensor and rotator
    kstart5 setsid '/usr/bin/Autorotate_pos.sh'  &
    kstart5 setsid '/usr/bin/Autorotate_rot.sh'  &


    paplay $SNDon &

    #Wait for bash are started
    while [ ! -e $MUP ] && [ ! -e $MLEFT ] && [ ! -e $MRIGHT ] && [ ! -e $MDOWN ]
      do
        sleep 0.1
      done

    #change icon and refresh desktop klicking
    if [ -e $MDOWN ];
       then
         cp /usr/share/icons/'rstart hor'.png /usr/share/icons/rstate.png
    fi
    if [ -e $MUP ];
       then
         cp /usr/share/icons/'rstart hor'.png /usr/share/icons/rstate.png
      fi
    if [ -e $MLEFT ];
       then
         cp /usr/share/icons/'rstart ver'.png /usr/share/icons/rstate.png
     fi
    if [ -e $MRIGHT ];
       then
         cp /usr/share/icons/'rstart ver'.png /usr/share/icons/rstate.png
    fi

    eval $(xdotool getmouselocation --shell)
    xdotool mousemove 2 100
    xdotool click 1
    xdotool click 1
    xdotool mousemove $X $Y
    xrefresh
    notify-send -t 2000 -e 'Autorotate Enabled ' -i /usr/share/icons/rstate.png -a 'KDE Autorotate' -u low &
    rm $MTOGGLE

    exit 0
fi

if [ -e $TOGGLE ]; then

    #change icon and refresh desktop klicking
    if [ -e $MDOWN ];
       then
         cp /usr/share/icons/'rstop hor'.png /usr/share/icons/rstate.png
    fi
    if [ -e $MUP ];
       then
         cp /usr/share/icons/'rstop hor'.png /usr/share/icons/rstate.png
    fi
    if [ -e $MLEFT ];
       then
         cp /usr/share/icons/'rstop ver'.png /usr/share/icons/rstate.png
    fi
    if [ -e $MRIGHT ];
       then
         cp /usr/share/icons/'rstop ver'.png /usr/share/icons/rstate.png
    fi

    eval $(xdotool getmouselocation --shell)
    xdotool mousemove 2 100
    xdotool click 1
    xdotool click 1
    xdotool mousemove $X $Y
    xrefresh

    notify-send -t 2000 -e 'Autorotate Disabled' -i /usr/share/icons/rstate.png -a 'KDE Autorotate' -u low &
    paplay $SNDoff &
    rm $TOGGLE
    rm $MTOGGLE

    #reset mouse and touchscreen that somtimes get stuck
    xdotool mouseup 3
    xinput --map-to-output "$TOUCHSCREEN" "$SCREEN"
    xinput --map-to-output "$PEN" "$SCREEN"
    xinput --map-to-output "$ERASER" "$SCREEN"

    exit 0
fi


