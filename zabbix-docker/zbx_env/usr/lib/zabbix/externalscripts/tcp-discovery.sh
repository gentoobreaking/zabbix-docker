#!/bin/bash
usage(){ echo "Usage: ./$(basename $0) hostname. For example: ./$(basename $0) server1.example.com 22,80,1024-1030";}
if [ -z $1 ]; then echo "No host specified";usage; exit 1; fi
#if [ -z $2 ]; then echo "No ports specified";usage; exit 1; fi
export scan_port='22,80,443,1433,2000-5001,5432,6446,8080,8081'

IFS=$'\n'
#LIST=$(nmap -T5 -Pn -sS --open ${1} -p${2}|grep open)
##LIST=$(nmap -T5 -Pn -sS --open ${1} -p${scan_port}|grep open)
LIST=$(nmap_david -T5 -Pn -sS --open ${1} -p${scan_port} 2>/dev/null|grep open)
echo -n '{"data":['
for s in $LIST; do
        PORT=$(echo $s | cut -d/ -f1)
        PROTO=$(echo $s | cut -d/ -f2 | awk '{sub(/[[:space:]].*/,""); print}')
        SERVICE=$(echo $s | awk '{print $3}')
        echo -n '{"{#PORT}":"'${PORT}'","{#PROTO}":"'${PROTO}'","{#SERVICE}":"'${SERVICE}'"},'
done |sed -e 's:\},$:\}:'
echo -n ']}'
unset IFS
