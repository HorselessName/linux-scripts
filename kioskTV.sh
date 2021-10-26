#!/bin/bash
# Modo quiosque - Raspberry PI

SITE1=''
SITE2=''
SITE3=''

xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk $SITE1 $SITE2 $SITE3 &

while true; do
xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;
sleep 20
xvkbd -window Chromium -text "\Cr"
sleep 5
done