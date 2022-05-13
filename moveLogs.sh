# Crontab a cada 10 minutos
# */10 * * * 0 su - -c "sh /usr/local/bin/moveLog.sh >/dev/null 2> /dev/null"

# Compacta em gz os logs
tar -czvf /var/log/backupLogs-`date +%Y-%m-%d`.gz /var/log/cron-202* /var/log/httpd/*_log*

# Cria pasta de log e move o arquivo
mkdir /mnt/dados/logs/backupLogs-`date +%Y-%m-%d`
mv /var/log/backupLogs-`date +%Y-%m-%d`.gz /mnt/dados/logs/backupLogs-`date +%Y-%m-%d`/

# Removo e limpo os logs
rm -rf /var/log/cron-202* /var/log/httpd/*_log-*
>/var/log/httpd/access_log
>/var/log/httpd/error_log