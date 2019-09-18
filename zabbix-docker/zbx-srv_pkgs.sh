#!/bin/bash

docker exec -t zbx-agent /bin/bash -c "apk update"
docker exec -t zbx-agent /bin/bash -c "echo http://dl-cdn.alpinelinux.org/alpine/latest-stable/main >> /etc/apk/repositories"
docker exec -t zbx-agent /bin/bash -c "echo http://dl-cdn.alpinelinux.org/alpine/latest-stable/community >> /etc/apk/repositories"
docker exec -t zbx-agent /bin/bash -c "apk update ; apk add -u apk-tools"
docker exec -t zbx-agent /bin/bash -c "apk --no-cache add python3 py-simplejson docker py-pip;pip install docker-py"
docker exec -t zbx-agent /bin/bash -c "apk --no-cache add shadow sudo curl && usermod -a -G docker zabbix"
docker exec -t zbx-agent /bin/bash -c "echo 'zabbix ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"

docker exec -it zbx-srv /bin/bash -c "apk update;apk --no-cache add curl"

