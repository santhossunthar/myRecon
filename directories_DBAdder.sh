#!/bin/bash

sudo mysql -uroot -e "CREATE DATABASE if not exists $2"
sudo mysql $2 -e "create table if not exists directory(directory VARCHAR(255) NOT NULL, UNIQUE(directory))"

while read line
do
sudo mysql $2 -e "insert ignore into directory (directory) values ('$line')"

done < "$1"