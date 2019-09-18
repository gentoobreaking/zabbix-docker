#!/bin/sh

cd /Users/davidchen/Data/git/zabbix/david_version_prod/zabbix-docker/zbx_env/
rsync -avz -e ssh ./* root@zbx-hk-paybnb.funpodium.net:/opt/zabbix-docker/zbx_env/
rsync -avz -e ssh ./* root@zbx-hk-paybnb-bo.funpodium.net:/opt/zabbix-docker/zbx_env/usr/lib/zabbix/
rsync -avz -e ssh ./* root@zbx-hk-fun88cms.funpodium.net:/opt/zabbix-docker/zbx_env/usr/lib/zabbix/
rsync -avz -e ssh ./* root@zbx-hk-cms.funpodium.net:/opt/zabbix-docker/zbx_env/usr/lib/zabbix/

