#!/bin/bash

sudo mysql -uroot -e "CREATE DATABASE if not exists $3"
sudo mysql $3 -e "create table if not exists by4xx_http_method(URL VARCHAR(255) NOT NULL, GET INT(4) NOT NULL, POST INT(4) NOT NULL, HEAD INT(4) NOT NULL, OPTIONS INT(4) NOT NULL, PUT INT(4) NOT NULL, TRACE INT(4) NOT NULL, TRACK INT(4) NOT NULL, CONNECT INT(4) NOT NULL, PATCH INT(4) NOT NULL, UNIQUE(URL))"

tail -n +11 $1 | head -n 9 | tee targets/$2/by4xx_HTTP_Methods.txt

GET=$(sed '1q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
POST=$(sed '2q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
HEAD=$(sed '3q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
OPTIONS=$(sed '4q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
PUT=$(sed '5q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
TRACE=$(sed '6q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
TRACK=$(sed '7q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
CONNECT=$(sed '8q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')
PATCH=$(sed '9q;d' targets/$2/by4xx_HTTP_Methods.txt | awk '{print $3}')

sudo mysql $3 -e "insert ignore into by4xx_http_method (URL, GET, POST, HEAD, OPTIONS, PUT, TRACE, TRACK, CONNECT, PATCH) values ('$4', $GET, $POST, $HEAD, $OPTIONS, $PUT, $TRACE, $TRACK, $CONNECT, $PATCH)"
