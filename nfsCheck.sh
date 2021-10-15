#!/bin/bash
# Verifica se os arquivos de rede via NFS estao montados

# Feito por Raul Chiarella
# Objetivo desse Shell Script é armazenar os valores de STATUS do NFS para consultar no Zabbix
# Entende - se que o Zabbix Agent já está instalado e configurado no server em questão que terá esse Shell Script
# Execute esse Shell ao menos uma vez no terminal, por causa das permissões necessárias...

# ----------------------------------------------------------------------------------------
# UserParameter Zabbix: UserParameter=nfsStatus,sh /etc/zabbix/zabbix_agentd.d/nfsCheck.sh
# ----------------------------------------------------------------------------------------

# Verificar se o volume está montado
NFS_SHARE='/mnt/dados'
NFS_SERVER='IP do Servidor NFS'

# Criar o arquivo p/ testar o NFS e permissões
>$NFS_SHARE/nfsTest
chmod 777 $NFS_SHARE/nfsTest
chown zabbix:zabbix $NFS_SHARE/nfsTest

# ACERTOS/ERROS em JSON:
# Diretorio NFS esta/nao esta montado -> NFS_MOUNT
# Falha/sucesso na gravacao do arquivo -> NFS_WRITE
# Ping no servidor NFS OK/Falhou -> NFS_PING

mountpoint -q $NFS_SHARE

# $? é utilizado p/ ver o valor de sucesso ultimo comando executado
# Se comando OK 0 porem se retorna erro volta 1

if [ $? -eq 0 ]
then
    # "Diretorio NFS esta montado"
    NFS_MOUNT=1
    touch /mnt/dados/nfsTest 2>/dev/null
    if [ $? -eq 0 ]
    then
        # "Consegui gravar arquivo no ponto montado..."
        NFS_WRITE=1
        NFS_PING=1
    else
        # "ERRO: Falha ao gravar arquivo no NFS Share"
        NFS_WRITE=0
        NFS_PING=0
    fi

else
    # "ERRO: Diretorio NFS nao esta montado"
    NFS_MOUNT=0
    NFS_WRITE=0
    # "IP do Servidor NFS: " $NFS_SERVER
    ping -c 3 -w 3 $NFS_SERVER 1>/dev/null 2>&1
    if [ $? -eq 0 ]
    then
	    # "Ping no servidor NFS OK"
        NFS_PING=1
    else
	    # "Servidor NFS indisponivel"
        NFS_PING=0
    fi
fi

# 'Output JSON:'
echo '{"NFS_MOUNT": "'$NFS_MOUNT'", "NFS_WRITE": "'$NFS_WRITE'", "NFS_PING": "'$NFS_PING'"}' | python -m json.tool
exit 0