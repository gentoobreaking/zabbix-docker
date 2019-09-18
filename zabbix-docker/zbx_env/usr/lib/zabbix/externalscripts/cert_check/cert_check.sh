#!/bin/sh

export REMHOST="$1"
export REMPORT='443'

echo | openssl s_client -servername ${REMHOST} -connect ${REMHOST}:${REMPORT} 2>/dev/null | openssl x509 -noout -enddate | cut -d = -f 2

# --- END --- #
