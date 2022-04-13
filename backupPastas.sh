#!/bin/bash
# Nome do Sistemas/Pasta
APP_NAME="Pasta dentro de HTML."
# Pastas a serem feito o BKP
BKP_SRC="/var/www/html"
# Local de destino do backup
BKP_DIR="/mnt/dados/backup"

# Estrutura de config do OneDrive
# sync_dir = "/root/OneDrive"
# upload_only = "true"
# local_first = "true"
# no_remote_delete = "true"
DATA=`date +%Y-%m-%d`

cp $BKP_SRC/$APP_NAME $BKP_DIR/$APP_NAME-$DATA

# Enviar BKP local p/ OneDrive
# Ferramenta utilizada: https://github.com/HorselessName/onedrive

# Sincroniza os arquivos de uma pasta com outra, e faz upload p/ OneDrive
rsync -a -v --ignore-existing $BKP_DIR/ $ONEDRIVE_DIR/
onedrive --synchronize --verbose --single-directory $ONEDRIVE_SUB_DIR