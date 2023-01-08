#!/bin/bash

sudo mysql -uroot -e "CREATE DATABASE if not exists $2"
sudo mysql $2 -e "create table if not exists subdomain_alive(subdomain VARCHAR(255) NOT NULL, status_code INT(4) NOT NULL, content_type VARCHAR(255) DEFAULT '' NOT NULL, title VARCHAR(255) DEFAULT '' NOT NULL, UNIQUE(subdomain))"

while read line
do 
subDomain=$(echo $line | awk '{print $1}')
statusCode=$(echo $line | awk '{print $2}' | sed 's|[][]||g')
contentType=$(echo $line | awk '{print $3}' | sed 's|[][]||g')
title=$(echo $line | awk '{print $4}' | sed 's|[][]||g')

sudo mysql $2 -e "insert ignore into subdomain_alive (subdomain, status_code, content_type, title) values ('$subDomain', '$statusCode', '$contentType', '$title')"

done < "$1"