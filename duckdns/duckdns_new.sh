#!/bin/bash

TOKEN="5882867e-afb1-4242-82cd-ed3b3baa0eea"
DOMAINS="utylee,utylee-ha"
LOGFILE="$HOME/temp/duckdns/duck.log"

echo "$(date): updating $DOMAINS" >> "$LOGFILE"
curl -s "https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=" >> "$LOGFILE"
echo "" >> "$LOGFILE"
