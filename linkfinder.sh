#!/bin/bash

while read url
do
python3 tools/LinkFinder/linkfinder.py -i $url -d -o cli | anew targets/$2/linkfinder_output.txt
done < "$1"

cat targets/$2/linkfinder_output.txt | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|svg)" | tee targets/$2/linkfinder_output_excluded.txt
rm targets/$2/linkfinder_output.txt

grep 'js' targets/$2/linkfinder_output_excluded.txt | tee targets/$2/JS_links.txt

grep -v 'js' targets/$2/linkfinder_output_excluded.txt | tee targets/$2/links_without_JS_links.txt

