#!/bin/bash

python3 tools/dirsearch/dirsearch.py -l $1 -t 25 --exclude-status 401,403 -o targets/$2/fuzzed_directories.txt

sudo mysql $3 -e "create table if not exists dirsearch(url VARCHAR(255) NOT NULL, status_code INT(4) NOT NULL, size VARCHAR(32) NOT NULL, redirection VARCHAR(255) DEFAULT '' NOT NULL)"

tail -n +3 targets/$2/fuzzed_directories.txt | tee targets/$2/fuzzed_directories_formatted.txt

while read line
do

statusCode=$(echo $line | awk '{print $1}')
size=$(echo $line | awk '{print $2}')
url=$(echo $line | awk '{print $3}')
redirection=$(echo $line | awk '{print $7}')

sudo mysql $3 -e "insert into dirsearch (url, status_code, size, redirection) values ('$url', '$statusCode', '$size', '$redirection')"

done < "targets/$2/fuzzed_directories_formatted.txt"

