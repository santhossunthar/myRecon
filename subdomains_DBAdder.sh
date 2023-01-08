#!/bin/bash

sudo mysql -uroot -e "CREATE DATABASE if not exists $2"
sudo mysql $2 -e "create table if not exists subdomain(subdomain VARCHAR(255) NOT NULL, UNIQUE(subdomain))"

while read line
do
sudo mysql $2 -e "insert ignore into subdomain (subdomain) values ('$line')"

done < "$1"
