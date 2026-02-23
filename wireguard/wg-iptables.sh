#!/bin/bash

sleep 10
echo "$(date): [START] running iptables config" >> /var/log/wg-iptables.log

/usr/sbin/iptables -P FORWARD ACCEPT
echo "$(date): [INFO] set FORWARD ACCEPT" >> /var/log/wg-iptables.log

/usr/sbin/iptables -t nat -C POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE 2>/dev/null
if [ $? -ne 0 ]; then
    /usr/sbin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE
    echo "$(date): [INFO] MASQUERADE added" >> /var/log/wg-iptables.log
else
    echo "$(date): [INFO] MASQUERADE already exists" >> /var/log/wg-iptables.log
fi
