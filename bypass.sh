#!/bin/bash

while read line
do
tools/byp4xx/bypass.sh $line | tee >(sed $'s/\033[[][^A-Za-z]*m//g' > targets/$1/by4xx_output_temp.txt)
./by4xx_HTTP_Methods_DBAdder.sh targets/$1/by4xx_output_temp.txt $1 $2 $line

done < "targets/$1/subdomains_alive_data.txt"

rm targets/$1/by4xx_output_temp.txt