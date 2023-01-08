#!/bin/bash

sudo mysql $2 -e "select subdomain from subdomain_alive where status_code>400 and status_code<500" | tee targets/$1/subdomains_bypass_temp.txt 
tail -n +2 targets/$1/subdomains_bypass_temp.txt | anew targets/$1/bypass.txt
rm targets/$1/subdomains_bypass_temp.txt

sudo mysql $2 -e "select url from url_alive where status_code>400 and status_code<500" | tee targets/$1/urls_bypass_temp.txt 
tail -n +2 targets/$1/urls_bypass_temp.txt | anew targets/$1/bypass.txt
rm targets/$1/urls_bypass_temp.txt

while read line
do
tools/byp4xx/bypass.sh $line | tee >(sed $'s/\033[[][^A-Za-z]*m//g' > targets/$1/by4xx_output_temp.txt)
./by4xx_HTTP_Methods_DBAdder.sh targets/$1/by4xx_output_temp.txt $1 $2 $line

done < "targets/$1/bypass.txt"

rm targets/$1/by4xx_output_temp.txt