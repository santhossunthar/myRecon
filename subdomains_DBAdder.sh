#!/bin/bash

sudo mysql -uroot -e "CREATE DATABASE if not exists $2"
sudo mysql $2 -e "create table if not exists subdomain(data VARCHAR(255) NOT NULL)"

while read line
do
sudo mysql $2 -e "insert into subdomain (data) values ('$line')"

done < "$1"
