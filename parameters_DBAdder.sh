#!/bin/bash

sudo mysql -uroot -e "CREATE DATABASE if not exists $2"
sudo mysql $2 -e "create table if not exists parameter(parameter VARCHAR(255) NOT NULL, UNIQUE(parameter))"

while read line
do
sudo mysql $2 -e "insert ignore into parameter (parameter) values ('$line')"

done < "$1"