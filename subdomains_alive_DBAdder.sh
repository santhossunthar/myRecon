#!/bin/bash

sudo mysql $2 -e "create table if not exists alive(subdomain VARCHAR(255) DEFAULT '' NOT NULL, status_code VARCHAR(255) DEFAULT '' NOT NULL, content_type VARCHAR(255) DEFAULT '' NOT NULL, title VARCHAR(255) DEFAULT '' NOT NULL)"

while read line
do 

subDomain=$(echo $line | awk '{print $1}')
statusCode=$(echo $line | awk '{print $2}')
contentType=$(echo $line | awk '{print $3}')
title=$(echo $line | awk '{print $4}')

sudo mysql $2 -e "insert into alive (subdomain, status_code, content_type, title) values ('$subDomain', '$statusCode', '$contentType', '$title')"

done < "$1"