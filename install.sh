#!/bin/bash
#This script will install autorotate system for KDE

echo  " "
echo  " ##################################################################"
echo  " #    Autorotate Script with Keyboard and Touchpad management     #"
echo  " #    Developed for X11 & KDE Plasma  by sergio melas 2021-23     #"
echo  " #                                                                #"
echo  " #                Emai: sergiomelas@gmail.com                     #"
echo  " #                   Released unde GPV V2.0                       #"
echo  " #                                                                #"
echo  " ##################################################################"
echo  " "

echo  ""

if [ $XDG_SESSION_TYPE  != 'x11' ] || ( [ $DESKTOP_SESSION != 'plasma' ] && [ $DESKTOP_SESSION != 'plasmax11' ] )
then
  echo  " "
  echo  " ##################################################################"
  echo  " #   KDE Autorotate support  systems with KDE Plasma on Wayland   #"
  echo  " #                     Installation for Wayland                   #"
  echo  " ##################################################################"
  echo  " "
else
  echo  " "
  echo  " ##################################################################"
  echo  " #      KDE Autorotate support  systems with KDE Plasma on Xorg   #"
  echo  " #                     Installation for X11                       #"
  echo  " ##################################################################"
  echo  " "
fi




VAR=$0
DIR="$(dirname "${VAR}")"
cd  "${DIR}"

echo -n "Did you prepared config file  (y/N)? "
read resp


if   [ -z $resp  ]
then
   echo  ""
   echo  "Plese read the readme.txt file to see how to proceed "
   echo  ""
   exit 0
fi

if   [ $resp == 'n' ] || [ $resp == 'N' ] || [ $resp != 'y' ] && [ $resp != 'Y' ]
then
   echo  ""
   echo  "Plese read the readme.txt file to see how to proceed "
   echo  ""
   exit 0
fi

echo  "Login as administrator to install"
sudo ls >/dev/null
echo  ""

echo  "Installing Libraries:"
echo  ""
sudo apt-get install libnotify-bin
sudo apt-get install onboard
sudo apt-get install xdotool
sudo apt-get install iio-sensor-proxy
sudo apt-get install zenity
sudo apt-get install libqt5virtualkeyboard5 qtvirtualkeyboard-plugin maliit-keyboard


while true
do

   echo  ""
   echo -n "Choose the theme : "
   array=('Blue round arrow rotation' 'Green Red ipad rotation'  'Black Phone rotation' 'White Phone rotation' 'Brown Arrows rotation' 'Rainbow Arrows rotation Dark' 'Rainbow Arrows rotation Light')
   Theme=$(zenity --entry --title "Window title" --text "${array[@]}" --text "Plese choose the theme set.")
   echo  -n "The iconset of $Theme is : "

   case $Theme in

     'Blue round arrow rotation')
       echo  "Blue round arrow rotation"
       sudo cp ./Payload/Theme_1/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_1/rstate.png /usr/share/icons/
       ;;
     'Green Red ipad rotation')
       echo  "Green Red ipad rotation"
       sudo cp ./Payload/Theme_2/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_2/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_2/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_2/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_2/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_2/rstate.png /usr/share/icons/
       ;;
     'Black Phone rotation')
       echo  "Black Phone rotation"
       sudo cp ./Payload/Theme_3/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_3/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_3/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_3/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_3/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_3/rstate.png /usr/share/icons/
       ;;
     'White Phone rotation')
       echo  "White Phone rotation"
       sudo cp ./Payload/Theme_4/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_4/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_4/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_4/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_4/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_4/rstate.png /usr/share/icons/
       ;;
     'Brown Arrows rotation')
       echo  "Brown Arrows rotation"
       sudo cp ./Payload/Theme_5/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_5/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_5/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_5/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_5/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_5/rstate.png /usr/share/icons/
       ;;
     'Rainbow Arrows rotation Dark')
       echo   "Rainbow Arrows rotation Dark"
       sudo cp ./Payload/Theme_6/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_6/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_6/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_6/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_6/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_6/rstate.png /usr/share/icons/
       ;;
     'Rainbow Arrows rotation Light')
       echo   "Rainbow Arrows rotation Light"
       sudo cp ./Payload/Theme_7/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_7/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_7/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_7/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_7/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_7/rstate.png /usr/share/icons/
       ;;
     *)
       echo  "Unknown Theme using default"
       sudo cp ./Payload/Theme_1/'rstart'.png /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstart hor'.png /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstart ver'.png /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstop hor'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_1/'rstop ver'.png  /usr/share/icons/
       sudo cp ./Payload/Theme_1/rstate.png /usr/share/icons/
       ;;
   esac
   sudo chmod 777 /usr/share/icons/rstate.png
   sudo chmod 777 /usr/share/icons/'rstart'.png
   sudo chmod 777 /usr/share/icons/'rstart hor'.png
   sudo chmod 777 /usr/share/icons/'rstart ver'.png
   sudo chmod 777 /usr/share/icons/'rstop hor'.png
   sudo chmod 777 /usr/share/icons/'rstop ver'.png

   notify-send -t 5000 '             Chosen Iconset' -i /usr/share/icons/'rstop hor'.png &
   echo  ""
   echo -n "Whant to change theme (y/N)? "
   read resp
   if [ -z $resp ]
   then
        break
   fi

   if [ $resp == 'n' ] || [ $resp == 'N' ] || [ $resp != 'y' ] && [ $resp != 'Y' ]
   then
        break
   fi
done

echo  "Creating system configuration files"

#Reset Position state
rm -r $HOME/.autorotate
mkdir  $HOME/.autorotate


#Prepare startup variables
sudo rm -r /usr/Autorotate
sudo mkdir /usr/Autorotate

#Install Stuff
sudo cp ./Payload/rc.local /etc/
sudo cp ./Payload/Autorotate.desktop /usr/share/applications/
sudo cp ./Payload/Autorotate_toggle.sh /usr/bin/
sudo cp ./Payload/Autorotate_pos.sh /usr/bin/
sudo cp ./Payload/Autorotate_rot.sh /usr/bin/
sudo cp ./Payload/Autorotate_clean.sh /usr/bin/
sudo cp ./Payload/virtualkbd.conf /etc/sddm.conf.d
cp ./Payload/Autorotate.desktop  $HOME/Desktop

#finish config
echo  "Populating system configuration files"
bash ./Payload/Autorotate_conf.sh




