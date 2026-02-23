#!/bin/bash
echo "$(date): updating duckdns.org..." >> ~/temp/duckdns/duck.log
curl -s "https://www.duckdns.org/update?domains=utylee&token=5882867e-afb1-4242-82cd-ed3b3baa0eea&ip=" >> ~/temp/duckdns/duck.log
echo "" >> ~/temp/duckdns/duck.log
