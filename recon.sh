#!/bin/bash

if [ -z $1 ]; then
	echo "Usage: Domain Name"
	echo "Usage: DB Name"
	exit
fi

#if [[ -f "targets" ]]; then
#    mkdir targets
#fi

mkdir -p targets/$1

echo "[+] starting sublist3r..."

python3 tools/Sublist3r/sublist3r.py -d $1 -o targets/$1/subdomains_all.txt

echo "[+] running assetfinder..."

assetfinder --subs-only $1 | anew targets/$1/subdomains_all.txt

./subdomains_DBAdder.sh targets/$1/subdomains_all.txt $2

echo "[+] Checking for alive subdomains..."

cat targets/$1/subdomains_all.txt | httpx -status-code -content-type -title | anew targets/$1/subdomains_alive_temp.txt

cat targets/$1/subdomains_alive_temp.txt | sed 's/\x1b\[[0-9;]*m//g' | anew targets/$1/subdomains_alive.txt

rm targets/$1/subdomains_alive_temp.txt

./subdomains_alive_DBAdder.sh targets/$1/subdomains_alive.txt $2


