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



