#!/bin/bash

if [ -z $1 ]; then
	echo "Usage: Domain Name"
	echo "Usage: DB Name"
	exit
fi

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

sudo mysql $2 -e "select subdomain from alive" | tee targets/$1/subdomains_alive_data_temp.txt 

tail -n +2 targets/$1/subdomains_alive_data_temp.txt | tee targets/$1/subdomains_alive_data.txt

rm targets/$1/subdomains_alive_data_temp.txt

while read line
do
tools/byp4xx/bypass.sh $line | tee >(sed $'s/\033[[][^A-Za-z]*m//g' > targets/$1/by4xx_output_temp.txt)
./by4xx_HTTP_Methods_DBAdder.sh targets/$1/by4xx_output_temp.txt $1 $2 $line
done < "targets/$1/subdomains_alive_data.txt"

rm targets/$1/by4xx_output_temp.txt

wayback $1 | anew targets/$1/URLs.txt

gau $1 | anew targets/$1/URLs.txt

cat targets/$1/URLs.txt | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | tee targets/$1/URLs_excluded.txt

rm targets/$1/URLs.txt







