#!/bin/bash

while read line
do

parameters=($(echo "$line" | tr '=' '\n'))

echo "${parameters[1]}" | anew targets/$2/parameters_values.txt

done < "$1"