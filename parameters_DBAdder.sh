#!/bin/bash

sudo mysql $2 -e "create table if not exists parameter(name VARCHAR(255) NOT NULL)"

while read line
do
sudo mysql $2 -e "insert into parameter (name) values ('$line')"

done < "$1"