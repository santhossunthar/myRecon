#!/bin/bash

cat targets/$1/linkfinder_links.txt | anew targets/$1/links_all.txt
cat targets/$1/relative_URL_JS_links.txt | anew targets/$1/links_all.txt

cat targets/$1/links_all.txt | httpx -status-code -content-type -title | anew targets/$1/links_alive_temp.txt

cat targets/$1/links_alive_temp.txt | sed 's/\x1b\[[0-9;]*m//g' | anew targets/$1/links_alive.txt
rm targets/$1/links_alive_temp.txt

sudo mysql $2 -e "create table if not exists alive_links(link VARCHAR(255) DEFAULT '' NOT NULL, status_code VARCHAR(255) DEFAULT '' NOT NULL, content_type VARCHAR(255) DEFAULT '' NOT NULL, title VARCHAR(255) DEFAULT '' NOT NULL)"

while read line
do 
link=$(echo $line | awk '{print $1}')
statusCode=$(echo $line | awk '{print $2}' | sed 's|[][]||g')
contentType=$(echo $line | awk '{print $3}' | sed 's|[][]||g')
title=$(echo $line | awk '{print $4}' | sed 's|[][]||g')

sudo mysql $2 -e "insert into alive_links (link, status_code, content_type, title) values ('$link', '$statusCode', '$contentType', '$title')"
done < "targets/$1/links_alive.txt"