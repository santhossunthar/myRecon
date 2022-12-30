#!/bin/bash

while read line
do

parameters=($(echo "$line" | tr '&' '\n'))

for ((i=1; i<${#parameters[@]}; i++))
do
	echo "${parameters[i]}" | anew targets/$2/parameters_with_values.txt
done

done < "$1"