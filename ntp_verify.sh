#!/bin/bash

NTP_CONF="/etc/ntp.conf"

DIFF=$(diff ${NTP_CONF}.bak ${NTP_CONF} | wc -l)
 if [ $DIFF -ne "0" ]; then
  echo "NOTICE: ${NTP_CONF} was changed. Calculated diff:"
  diff -u ${NTP_CONF}.bak ${NTP_CONF}
  cp ${NTP_CONF}.bak ${NTP_CONF}
  systemctl restart ntp
 fi

NTP_PROC=$(ps ax | grep [n]tpd | wc -l)
 if [ ${NTP_PROC} -eq "0" ]; then
  echo "NOTICE: ntp is not running"
  systemctl restart ntp
 fi

