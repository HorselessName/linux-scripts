#!/bin/bash
# Backup MySQL

BD_BANCO=''
BD_USER=''
BD_SENHA=''
BD_HOST=''

# Local que ficara armazenado localmente o backup
BKP_DIR=''

# Estrutura de config do OneDrive
# sync_dir = "/root/OneDrive"
# upload_only = "true"
# local_first = "true"
# no_remote_delete = "true"

# Diretorios do OneDrive e caso precise MySQL Extra File
ONEDRIVE_DIR=''
ONEDRIVE_SUB_DIR=''
MYSQL_EXTRA_FILE=''

# Estrutura de config do Extra File do MySQL:
# [client]
# user = "usuario"
# password = "senha"
# host = "localhost"

DATA=`date +%Y-%m-%d`

mysqldump -u"$BD_USER" -p"$BD_SENHA" -h "$BD_HOST" --opt --default-character-set=utf8mb4 --skip-set-charset "$BD_BANCO" > $BKP_DIR/$BD_BANCO-$DATA.sql
# Comando usando Extra File:
# mysqldump --defaults-extra-file=$MYSQL_EXTRA_FILE --opt --default-character-set=utf8mb4 --skip-set-charset "$BD_BANCO" > $BKP_DIR/$BD_BANCO-$DATA.sql

# Enviar BKP local p/ OneDrive
# Ferramenta utilizada: https://github.com/HorselessName/onedrive

# Sincroniza os arquivos de uma pasta com outra, e faz upload p/ OneDrive
rsync -a -v --ignore-existing $BKP_DIR/ $ONEDRIVE_DIR/
onedrive --synchronize --verbose --single-directory $ONEDRIVE_SUB_DIR