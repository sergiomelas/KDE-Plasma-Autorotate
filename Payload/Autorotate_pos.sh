#!/bin/bash
#Autorotate_pos.sh

##################################################################
#          Autorotate_pos.sh   Calculate position of the pc      #
#              Developed by sergio melas 2021-23                 #
##################################################################



#Initialize Global Variables
MROT=$HOME/.autorotate/.mrot             #Toggle rotation not done

CUP=$HOME/.autorotate/.cup                #Toggle rotation up
CLEFT=$HOME/.autorotate/.cleft            #Toggle rotation left
CRIGHT=$HOME/.autorotate/.cright          #Toggle rotation right
CDOWN=$HOME/.autorotate/.cdown            #Toggle rotation down

MUP=$HOME/.autorotate/.mup                #Toggle last rotation up
MLEFT=$HOME/.autorotate/.mleft            #Toggle last rotation left
MRIGHT=$HOME/.autorotate/.mright          #Toggle last rotation right
MDOWN=$HOME/.autorotate/.mdown            #Toggle last rotation down

TOGGLE=$HOME/.autorotate/.toggle          #Toggle rotation on off

echo run

#Scan for orientation changes
monitor-sensor | while read line
do

   #Memorize position
   if [[ $line =~ .*left-up.* ]] #If left up
   then

         #Activate  Left rotation
        rm $CUP
        touch $CLEFT
        rm $CRIGHT
        rm $CDOWN

        #Update Status Icon
        cp /usr/share/icons/'rstart ver'.png /usr/share/icons/rstate.png

        #manage if rotation if necessary
        if [ ! -e $MLEFT ];
        then
           touch $MROT
           while [ ! -e $MROT ]
           do
             sleep 0.1
           done
        fi

        echo LEFT
   fi

   if [[ $line =~ .*right-up.* ]] #If right up
   then

        #Activate Right rotation
        rm $CUP
        rm $CLEFT
        touch $CRIGHT
        rm $CDOWN

        #Update Status Icon
        cp /usr/share/icons/'rstart ver'.png /usr/share/icons/rstate.png

        #manage if rotation necessary
        if [ ! -e $MRIGHT ];
        then
           touch $MROT
           while [ ! -e $MROT ]
           do
             sleep 0.1
           done
        fi

        echo RIGHT
   fi

   if [[ $line =~ .*bottom-up.* ]] #If Bottom up
   then

        #Activate Up rotation
        rm $CUP
        rm $CLEFT
        rm $CRIGHT
        touch $CDOWN

        #Update Status Icon
        cp /usr/share/icons/'rstart hor'.png /usr/share/icons/rstate.png

        #manage if rotation necessary
        if [ ! -e $MDOWN ];
        then
           touch $MROT
           while [ ! -e $MROT ]
           do
             sleep 0.1
           done
        fi

        echo INVERTED
   fi

   if [[ $line =~ .*normal.* ]] #In normal
   then

        #Activate Up rotation
        touch $CUP
        rm $CLEFT
        rm $CRIGHT
        rm $CDOWN

        #Update Status Icon
        cp /usr/share/icons/'rstart hor'.png /usr/share/icons/rstate.png

        #manage if rotation necessary
        if [ ! -e $MUP ];
        then
           touch $MROT
           while [ ! -e $MROT ]
           do
             sleep 0.1
           done
        fi

        echo NORMAL
   fi

   sleep 0.1
   if [ ! -e $TOGGLE ]; then
       kill -- -$$
   fi
done
echo done

