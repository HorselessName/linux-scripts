#!/bin/bash
# Modo quiosque - Raspberry PI
# Dependências necessárias: 
# unclutter xdotool xvkbd chromium-browser xvfb xorg xvfb gtk2-engines-pixbuf 
# dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable

LISTA_DE_PROBLEMAS=''
GRAFICOS=''
MAPA=''

# Não pisca a tela
xset s noblank
# Remove o Screen Saver
xset s off
# Desativa features de Energy Star
xset -dpms

# Esconde o mouse a não ser que ele seja ativado
unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

# Ajuste aqui de acordo com seu sistema.
/usr/bin/chromium-browser --display=:0 --force-device-scale-factor=0.90 --noerrdialogs --disable-infobars --kiosk $LISTA_DE_PROBLEMAS $GRAFICOS $MAPA &

while true; do
xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;
sleep 20
xvkbd -window Chromium -text "\Cr"
sleep 5
done