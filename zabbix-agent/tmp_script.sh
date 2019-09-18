#!/bin/bash

docker exec -t zbx-agent /bin/bash -c "apk update;apk --no-cache add python3 py-simplejson docker py-pip;pip install docker-py"
docker exec -t zbx-agent /bin/bash -c "echo http://dl-cdn.alpinelinux.org/alpine/edge/community/ > /etc/apk/repositories;"
docker exec -t zbx-agent /bin/bash -c "echo http://dl-cdn.alpinelinux.org/alpine/v3.6/main >> /etc/apk/repositories;"
docker exec -t zbx-agent /bin/bash -c "echo http://dl-cdn.alpinelinux.org/alpine/v3.6/community >> /etc/apk/repositories;"
docker exec -t zbx-agent /bin/bash -c "apk --no-cache update; apk add mysql-client"
docker exec -t zbx-agent /bin/bash -c "apk --no-cache add shadow sudo && usermod -a -G docker zabbix"
docker exec -t zbx-agent /bin/bash -c "echo 'zabbix ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"

### for zabbix-agent-extension-elasticsearch
docker exec -t zbx-agent /bin/bash -c "apk add git;git clone https://github.com/zarplata/zabbix-agent-extension-elasticsearch.git"
docker exec -t zbx-agent /bin/bash -c "cd zabbix-agent-extension-elasticsearch;sed -i 's|/etc/zabbix/zabbix_agentd.conf.d/|/etc/zabbix/zabbix_agentd.d/|g' Makefile"
docker exec -t zbx-agent /bin/bash -c "apk add make automake dep go libc-dev"
docker exec -t zbx-agent /bin/bash -c "cd zabbix-agent-extension-elasticsearch;make;make install"

# --- END --- #
