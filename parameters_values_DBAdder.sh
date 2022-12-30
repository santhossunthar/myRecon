#!/bin/bash

sudo mysql $2 -e "create table if not exists parameter_values(value VARCHAR(255) NOT NULL)"

while read line
do

sudo mysql $2 -e "insert into parameter_values (value) values ('$line')"

done < "$1"