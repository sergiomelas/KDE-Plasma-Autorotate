#!/bin/bash
#Autorotate_route_sound.sh

##################################################################
#          Autorotate_route_sound.sh   Rotate sound              #
#              Developed by sergio melas 2021-23                 #
##################################################################

#Work in progress to move all sounds sources to a sink


echo "Setting default sink to: $1";
pactl set-default-sink "$1"
pactl list clients short |  cut -f 3 | while read -r line; do
  echo "Moving input: ";
  echo "$line" ;
  echo "to sink: $1";
  pactl move-sink-input "$(echo "$line" ' ')" "$1"
done

