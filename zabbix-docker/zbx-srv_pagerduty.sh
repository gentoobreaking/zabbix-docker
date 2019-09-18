#!/bin/bash

docker exec -it zbx-srv /bin/bash -c "
mask 0022
apk add git
mkdir -p /opt
cd /opt
git clone https://github.com/PagerDuty/pdagent.git
git clone https://github.com/PagerDuty/pdagent-integrations.git

ln -s /opt/pdagent/pdagent /opt/pdagent-integrations/bin

mkdir -p /opt/pdagent/tmp
chmod 777 /opt/pdagent/tmp
ln -s /opt/pdagent/tmp /var/lib/pdagent

addgroup pdagent
adduser pdagent -HD -s /bin/false -G pdagent

cp -f /opt/pdagent/conf/pdagent.conf /etc/
chmod 644 /etc/pdagent.conf

apk add python2

su -s /bin/bash -c \"/opt/pdagent/bin/pdagentd.py\" pdagent
ps aux|grep pdagent|grep -v \"grep\"

# Add. startup into zbx-srv.
echo 'su -s /bin/bash -c \"/opt/pdagent/bin/pdagentd.py\" pdagent' >> /usr/bin/docker-entrypoint.sh

# COPY /usr/lib/zabbix/alertscripts/pd-zabbix
cp /opt/pdagent-integrations/bin/pd-zabbix /usr/lib/zabbix/alertscripts/pd-zabbix

# Test Sending
export PD_SERVICE_KEY=xxx
/usr/lib/zabbix/alertscripts/pd-zabbix \"${PD_SERVICE_KEY}\" 'test' 'david'

chown -R zabbix:zabbix /opt/pdagent* /etc/pdagent.conf /usr/lib/zabbix/alertscripts/pd-zabbix
chmod 755 /usr/lib/zabbix/alertscripts/pd-zabbix

update /etc/profile
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/pdagent/bin:/opt/pdagent-integration


PATH=$PATH:/opt/pdagent/bin:/opt/pdagent-integrations/bin
echo \"PATH:$PATH\"

# --- old style --- #
cd /usr/lib/zabbix/alertscripts/
wget https://raw.github.com/PagerDuty/pagerduty-zabbix-py/master/pagerduty.py
chmod 755 /usr/lib/zabbix/alertscripts/pagerduty.py
chown zabbix:zabbix /usr/lib/zabbix/alertscripts/pagerduty.py

echo '* * * * * /usr/lib/zabbix/alertscripts/pagerduty.py' >> /etc/crontabs/root

"
# --- END --- #
