# zabbix-docker usage


# 1. Zabbix Srv
```console
# mv zabbix-docker /opt/
# cd /opt/zabbix-docker/
# docker-compose -f docker-compose.yaml up -d
```

# 2. Zabbix Agent
# change zabbix-agent direct to zbx-srv.
# change ZBX_SERVER_HOST=zbx-prod.david.internal. at /opt/zabbix-agent/.env file.
# it must use FQDN.
```console
# sed -i 's|zbx-prod.david.internal.|<new zbx-srv>|g' /opt/zabbix-agent/.env
# mv zabbix-agent /opt/
# cd /opt/zabbix-agent/
# docker-compose up -d
# ./tmp_script.sh
```

Finally, got to setup this host in web gui of zabbix srv.
Please remember setup with 'Template AX App Docker PASSIVE' , 'Template OS Linux'.

# Zabbix Web GUI - According Zabbix documentation: Admin/zabbix

