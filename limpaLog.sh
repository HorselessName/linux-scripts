# Crontab a cada 10 minutos
# */10 * * * 0 su - -c "sh /usr/local/limpaLog.sh >/dev/null 2> /dev/null"

rm -rf /var/log/*.gz
rm -rf /var/log/syslog.*
journalctl --vacuum-size=200M >/dev/null
