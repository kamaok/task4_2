#!/bin/bash

apt-get update > /dev/null && apt-get install ntp -y > /dev/null

NTP_CONF="/etc/ntp.conf"
CURRENT_PWD="$( cd "$(dirname "$0")" ; pwd -P )"

sed -i '/^pool /d' ${NTP_CONF}
echo "pool ua.pool.ntp.org" >> ${NTP_CONF}
systemctl restart ntp
echo "* * * * * /bin/bash "${CURRENT_PWD}/ntp_verify.sh"" >> /var/spool/cron/crontabs/root
systemctl restart cron

cp ${NTP_CONF} ${NTP_CONF}.bak

