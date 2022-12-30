#!/bin/bash

while read line
do

urlParts=($(echo "$line" | tr '?' '\n'))

for ((i=1; i<${#urlParts[@]}; i++))
do
	echo "${urlParts[i]}" | anew targets/$2/parameters_temp.txt	
done

done < "$1"