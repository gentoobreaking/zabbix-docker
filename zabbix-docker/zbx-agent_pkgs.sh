#!/bin/bash

docker exec -t zbx-agent /bin/bash -c "echo 'http://dl-cdn.alpinelinux.org/alpine/latest-stable/main' > /etc/apk/repositories"
docker exec -t zbx-agent /bin/bash -c "echo 'http://dl-cdn.alpinelinux.org/alpine/latest-stable/community' >> /etc/apk/repositories"

docker exec -t zbx-agent /bin/bash -c "apk update;apk --no-cache add vim bash bc curl perl-utils python3 py-simplejson docker py-pip;pip install docker-py"
#docker exec -t zbx-agent /bin/bash -c "echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories;apk --no-cache add shadow sudo && usermod -a -G docker zabbix"
docker exec -t zbx-agent /bin/bash -c "apk --no-cache add shadow sudo && usermod -a -G docker zabbix"
docker exec -t zbx-agent /bin/bash -c "echo 'zabbix ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"

