#!/bin/bash

waybackurls $1 | anew targets/$1/URLs.txt

gau $1 | anew targets/$1/URLs.txt

cat targets/$1/URLs.txt | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | tee targets/$1/URLs_excluded.txt
rm targets/$1/URLs.txt

./URLs_filter.sh targets/$1/URLs_excluded.txt $1 $2

cat targets/$1/directories.txt | anew targets/$1/wordlist.txt
cat targets/$1/parameters.txt | anew targets/$1/wordlist.txt
cat targets/$1/parameters_values.txt | anew targets/$1/wordlist.txt

rm targets/$1/directories.txt targets/$1/parameters.txt targets/$1/parameters_values.txt