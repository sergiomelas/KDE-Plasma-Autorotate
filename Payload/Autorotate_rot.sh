#!/bin/bash

##################################################################
#          Autorotate_rot.sh   Rotate acreen                     #
#              Developed by sergio melas 2021-23                 #
##################################################################


#Initialize Global Variables
TRANSFORM='Coordinate Transformation Matrix'
TOGGLE=$HOME/.autorotate/.toggle          #Toggle rotation on off

MROT=$HOME/.autorotate/.mrot              #Toggle rotation not done

CUP=$HOME/.autorotate/.cup                #Toggle rotation up
CLEFT=$HOME/.autorotate/.cleft            #Toggle rotation left
CRIGHT=$HOME/.autorotate/.cright          #Toggle rotation right
CDOWN=$HOME/.autorotate/.cdown            #Toggle rotation down

MUP=$HOME/.autorotate/.mup                #Toggle last rotation up
MLEFT=$HOME/.autorotate/.mleft            #Toggle last rotation left
MRIGHT=$HOME/.autorotate/.mright          #Toggle last rotation right
MDOWN=$HOME/.autorotate/.mdown            #Toggle last rotation down



#Read COnfiguration
SNDrotate=$( cat /usr/Autorotate/SNDrotate.conf )
SCREEN=$( cat /usr/Autorotate/SCREEN.conf )
TOUCHSCREEN=$( cat /usr/Autorotate/TOUCHSCREEN.conf )
PEN=$( cat /usr/Autorotate/PEN.conf )
ERASER=$( cat /usr/Autorotate/ERASER.conf )
KEYBKLIGHT=$( cat /usr/Autorotate/KEYBKLIGHT.conf )
SINK=$( cat /usr/Autorotate/SINK.conf )
SETREVERSE=$( cat /usr/Autorotate/SETREVERSE.conf )


#Memorise Keybord britgtness
kbbrit=$(cat  $KEYBKLIGHT)

echo run

#Scan for orientation changes and if cative execute them
while [ -e $TOGGLE ]
do

   if [ -e $TOGGLE ] #If autorotate is active
   then
      sleep 0.1  #Timer to free cpu
      if [ -e $MROT ] #If rotation not done
      then

         #Activate left click
         xsetwacom --set   "$TOUCHSCREEN"    Gesture off

         sleep 1  #Timer to be shure rotation is not a wiggle
         if [ -e $MROT ] #If rotation confirmed
         then
            echo NEED ROTATE

            if [ -e $CLEFT ] #If rotation left
            then
               echo ROTATE LEFT

               #Memorise Keybord britgtness if we came from up and switch off
               if [ -e $MUP ]
               then
                   kbbrit=$(cat  $KEYBKLIGHT)
               fi

               if [[ $kbbrit -gt 0 ]]
               then
                  echo 0 > $KEYBKLIGHT
               fi

               #Kill Dock
               killall latte-dock
               killall plank
               killall cairo-dock
               killall crystal-dock
               #Kill on screen keyboard
               killall onboard

               #reset mouse and touchscreen that somtimes get stuck
               xdotool mouseup 3
               xinput --map-to-output "$TOUCHSCREEN" "$SCREEN"
               xinput --map-to-output "$PEN" "$SCREEN"
               xinput --map-to-output "$ERASER" "$SCREEN"


               #rotate display, touchscreen, pen and eraser
               xrandr --output $SCREEN  --rotate left &
               xinput set-prop "$TOUCHSCREEN"    "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
               xinput set-prop "$PEN"            "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
               xinput set-prop "$ERASER"         "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
               kscreen-doctor output.1.rotation.left


               #Start On screen Keyboard
               kstart5 onboard &

               #Remove reverse stereo from sound profiles
               pactl set-default-sink $SINK
               pactl unload-module module-remap-sink

               #play sound
               sleep 0.5
               paplay $SNDrotate &

               #Memorise Left state
               rm $MUP
               touch $MLEFT
               rm $MRIGHT
               rm $MDOWN

            fi

            if [ -e $CRIGHT ] #If rotation right
            then
               echo ROTATE RIGHT

               #Memorise Keybord britgtness if we came from up and switch off
               if [ -e $MUP ]
               then
                   kbbrit=$(cat  $KEYBKLIGHT)
               fi

               if [[ $kbbrit -gt 0 ]]
               then
                  echo 0 > $KEYBKLIGHT
               fi

               #Kill Dock
               killall latte-dock
               killall plank
               killall cairo-dock
               killall crystal-dock
               #Kill on screen keyboard
               killall onboard

               #reset mouse and touchscreen that somtimes get stuck
               xdotool mouseup 3
               xinput --map-to-output "$TOUCHSCREEN" "$SCREEN"
               xinput --map-to-output "$PEN" "$SCREEN"
               xinput --map-to-output "$ERASER" "$SCREEN"


               #rotate display, touchscreen, pen and eraser
               xrandr --output $SCREEN --rotate right &
               xinput set-prop "$TOUCHSCREEN"    "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
               xinput set-prop "$PEN"            "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
               xinput set-prop "$ERASER"         "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
               kscreen-doctor output.1.rotation.right

               #Start On screen Keyboard
               kstart5 onboard &

               #Remove reverse stereo from sound profiles
               pactl set-default-sink $SINK
               pactl unload-module module-remap-sink

               #play sound
               sleep 0.5
               paplay $SNDrotate &


               #Memorise Right state
               rm $MUP
               rm $MLEFT
               touch $MRIGHT
               rm $MDOWN

            fi

            if [ -e $CDOWN ] #If rotation Botto up
            then
               echo ROTATE DOWN

               #Memorise Keybord britgtness if we came from up and switch off
               if [ -e $MUP ]
               then
                   kbbrit=$(cat  $KEYBKLIGHT)
               fi

               if [[ $kbbrit -gt 0 ]]
               then
                  echo 0 > $KEYBKLIGHT
               fi

               #Kill Dock
               killall latte-dock
               killall plank
               killall cairo-dock
               killall crystal-dock
               #Kill on screen keyboard
               killall onboard

               #reset mouse and touchscreen that somtimes get stuck
               xdotool mouseup 3
               xinput --map-to-output "$TOUCHSCREEN" "$SCREEN"
               xinput --map-to-output "$PEN" "$SCREEN"
               xinput --map-to-output "$ERASER" "$SCREEN"

               #rotate display, touchscreen, pen and eraser
               xrandr --output $SCREEN --rotate inverted &
               xinput set-prop "$TOUCHSCREEN"    "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
               xinput set-prop "$PEN"            "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
               xinput set-prop "$ERASER"         "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
               kscreen-doctor output.1.rotation.inverted

               #Start On screen Keyboard
               kstart5 onboard &

               if [[ "$SETREVERSE" -gt 0.5 ]] #If reverse active
               then
                 #Add reverse stereo to sound profiles
                 pactl load-module module-remap-sink sink_name=Reverse master=$SINK \
                 channels=2 master_channel_map=front-left,front-right channel_map=front-right,front-left \
                 sink_properties="device.description='Reverse-Stereo'"

                 pactl set-default-sink Reverse
                 pactl set-sink-volume Reverse 100%
               fi
               #play sound
               sleep 0.5
               paplay $SNDrotate &

               #Memorise Down state
               rm $MUP
               rm $MLEFT
               rm $MRIGHT
               touch $MDOWN

            fi

            if [ -e $CUP ] #If rotation Normal
            then
               echo ROTATE UP


               #Kill Dock
               killall latte-dock
               killall plank
               killall cairo-dock
               killall crystal-dock
               #Kill on screen keyboard
               killall onboard

               #reset mouse and touchscreen that somtimes get stuck
               xdotool mouseup 3
               xinput --map-to-output "$TOUCHSCREEN" "$SCREEN"
               xinput --map-to-output "$PEN" "$SCREEN"
               xinput --map-to-output "$ERASER" "$SCREEN"

               #Rotate Screen and Touch and pen to Normal
               xrandr --output $SCREEN --rotate normal &
               xinput set-prop "$TOUCHSCREEN"    "$TRANSFORM" 1 0 0 0 1 0 0 0 1
               xinput set-prop "$PEN"            "$TRANSFORM" 1 0 0 0 1 0 0 0 1
               xinput set-prop "$ERASER"         "$TRANSFORM" 1 0 0 0 1 0 0 0 1
               kscreen-doctor output.1.rotation.normal

               #Start dock
               if [ $XDG_SESSION_TYPE  != 'x11' ] #if plasma wayland
               then
                 kstart5 crystal-dock &
               else                              #if plasma x11
                 kstart5 latte-dock --replace &
                 kstart5 plank &
                 kstart5 cairo-dock &
               fi

               #Restore keyboard backlight
               if [[ $kbbrit -gt 0 ]]
               then
                  echo $kbbrit > $KEYBKLIGHT
               fi

               #Remove reverse stereo from sound profiles
               pactl set-default-sink $SINK
               pactl unload-module module-remap-sink

               #play sound
               sleep 0.5
               paplay $SNDrotate &

               #Memorise Normal state
               touch $MUP
               rm $MLEFT
               rm $MRIGHT
               rm $MDOWN

               #Restore keyboard  backlight
               echo $kbbrit > $KEYBKLIGHT

            fi

            echo RORATION COMPLETE
            rm $MROT
            sleep 2

        fi
     fi

     #if rotating down force sound output
     if [[ "$SETREVERSE" -gt 0 ]] #If reverse active
     then

       if [ -e $MDOWN ];
       then
             #Put sound to Resverse
             pactl set-default-sink Reverse
             #Alwais force reverse volume
             pactl set-sink-volume Reverse 100%
             sleep 0.05
       else
         sleep 0.1
       fi
     fi
   else
     sleep 0.1
   fi

done

killall Autorotate_pos.sh



