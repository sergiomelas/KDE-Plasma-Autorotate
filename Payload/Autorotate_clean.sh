#!/bin/bash

##################################################################
#         Autorotate_clean.sh   clean up on exit                 #
#              Developed by sergio melas 2021-23                 #
##################################################################


CUP=$HOME/.autorotate/.cup                #Toggle rotation up
CLEFT=$HOME/.autorotate/.cleft            #Toggle rotation left
CRIGHT=$HOME/.autorotate/.cright          #Toggle rotation right
CDOWN=$HOME/.autorotate/.cdown            #Toggle rotation down

MUP=$HOME/.autorotate/.mup                #Toggle last rotation up
MLEFT=$HOME/.autorotate/.mleft            #Toggle last rotation left
MRIGHT=$HOME/.autorotate/.mright          #Toggle last rotation right
MDOWN=$HOME/.autorotate/.mdown            #Toggle last rotation down

TOGGLE=$HOME/.autorotate/.toggle          #Toggle rotation on off
MTOGGLE=$HOME/.autorotate/.mtoggle        #One shot toggle



cp /usr/share/icons/'rstop hor.png' /usr/share/icons/rstate.png
killall  monitor-sensor
kill -9  $(pgrep -f '/usr/bin/Autorotate_rot.sh')

rm $CUP
rm $CLEFT
rm $CRIGHT
rm $CDOWN
rm $MUP
rm $MLEFT
rm $MRIGHT
rm $MDOWN
rm $TOGGLE
rm $MTOGGLE


GDK_BACKEND=x11 kstart5  cairo-dock

