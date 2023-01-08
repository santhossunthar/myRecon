#!/bin/bash

while read url
do
setOfSecrets=$(python3 tools/secretfinder/SecretFinder.py -i $url -o cli)

echo "$setOfSecrets" | egrep -iv '^\[|SSLError' | sed 's|^ |possible_Creds -> |1' | sed "s|^|$url > |1" | anew targets/$2/secrets.txt
done < "$1"

sudo mysql $3 -e "create table if not exists secrets(url VARCHAR(255) NOT NULL, secret VARCHAR(255) DEFAULT '' NOT NULL, value VARCHAR(255) DEFAULT '' NOT NULL)"

while read line
do
url=$(echo $line | awk -F\> '{print $1}' | sed 's|^[[:space:]]*||')
secret=$(echo $line | awk -F\> '{print $2}' | sed -e 's|-| |' -e 's|^[[:space:]]*||')
value=$(echo $line | awk -F\> '{print $3}' | sed -e 's|^[[:space:]]*||' -e "s|'|''|g")

sudo mysql $3 -e "insert into secrets (url, secret, value) values ('$url', '$secret', '$value')"

done < "targets/$2/secrets.txt" 

