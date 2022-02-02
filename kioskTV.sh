#!/bin/bash
# Modo quiosque - Raspberry PI

LISTA_DE_PROBLEMAS=''
GRAFICOS=''
MAPA=''

xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

/usr/bin/chromium-browser --force-device-scale-factor=0.90 --noerrdialogs --disable-infobars --kiosk $LISTA_DE_PROBLEMAS $GRAFICOS $MAPA &

while true; do
xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;
sleep 20
xvkbd -window Chromium -text "\Cr"
sleep 5
done