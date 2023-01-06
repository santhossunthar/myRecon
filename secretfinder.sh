#!/bin/bash
rm targets/$2/secrets.txt
while read url
do
setOfSecrets=$(python3 tools/secretfinder/SecretFinder.py -i $url -o cli)

echo "$setOfSecrets" | egrep -iv '^\[|SSLError' | sed 's|^ |possible_Creds -> |1' | sed "s|^|$url > |1" | anew targets/$2/secrets.txt
done < "$1"

