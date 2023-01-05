#!/bin/bash

while read url
do
setOfLinks=$(python3 tools/LinkFinder/linkfinder.py -i $url -d -o cli)

echo "$setOfLinks" | grep '^http' | anew targets/$2/relative_URLs_temp.txt
echo "$setOfLinks" | grep -v '^http' | sed "s|^|$url\/|1" | anew targets/$2/relative_URLs_temp.txt
done < "$1"

cat relative_URLs.txt | grep -v 'Running against:' | tee targets/$2/relative_URLs.txt

cat targets/$2/linkfinder_output.txt | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|svg)" | tee targets/$2/linkfinder_output_excluded.txt
rm targets/$2/linkfinder_output.txt

grep 'js' targets/$2/linkfinder_output_excluded.txt | tee targets/$2/JS_links_temp.txt
cat targets/$2/JS_links_temp.txt | grep "Running against:" | awk '{print $3}' | tee targets/$2/JS_links.txt
cat targets/$2/JS_links_temp.txt | grep -v "Running against:" | anew targets/$2/JS_links.txt

grep 'http' cat targets/$2/JS_links.txt

while read link
do

done < "targets/$2/JS_links.txt"

grep -v 'js' targets/$2/linkfinder_output_excluded.txt | tee targets/$2/links_without_JS_links.txt

sudo mysql $3 -e "create table if not exists js_links(link VARCHAR(255) NOT NULL)"

while read line
do
sudo mysql $3 -e "insert into js_links (link) values ('$line')"
done < "targets/$2/JS_links.txt"

sudo mysql $3 -e "create table if not exists links(link VARCHAR(255) NOT NULL)"

while read line
do
sudo mysql $3 -e "insert into links (link) values ('$line')"
done < "targets/$2/links_without_JS_links.txt"
