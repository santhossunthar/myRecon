#!/bin/bash

while read line
do

parameterParts=($(echo "$line" | tr '=' '\n'))

echo "${parameterParts[0]}" | anew targets/$2/parameters.txt

done < "$1"