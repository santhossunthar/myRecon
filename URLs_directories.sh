#!/bin/bash

while read line
do

urlParts=($(echo "$line" | tr '/' '\n'))

for ((i=2; i<${#urlParts[@]}; i++))
do
	echo "${urlParts[i]}" | anew targets/$2/directories.txt		
done

done < "$1"