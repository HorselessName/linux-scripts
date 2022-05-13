# Crontab a cada 10 minutos
# */10 * * * 0 su - -c "sh /usr/local/limpaLog.sh >/dev/null 2> /dev/null"

# Remove arquivos que terminal em gz
rm -rf /var/log/*.gz

# Remove arquivos de log
rm -rf /var/log/syslog.*
rm -rf /var/log/messages-*
rm -rf /var/log/cron-*

# Limpa logs journal acima de 200M
journalctl --vacuum-size=200M >/dev/null