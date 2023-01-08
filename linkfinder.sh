#!/bin/bash

while read url
do
setOfLinks=$(python3 tools/LinkFinder/linkfinder.py -i $url -d -o cli)

echo "$setOfLinks" | grep '^http' | anew targets/$2/linkfinder_URLs.txt
echo "$setOfLinks" | grep -v '^http' | sed "s|^|$url\/|1" | anew targets/$2/linkfinder_URLs.txt
done < "$1"

cat targets/$2/linkfinder_URLs.txt | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|svg)" | tee targets/$2/linkfinder_URLs_excluded.txt
rm targets/$2/linkfinder_URLs.txt

grep -F '.js' targets/$2/linkfinder_URLs_excluded.txt | tee targets/$2/linkfinder_JS_links_temp.txt
cat targets/$2/linkfinder_JS_links_temp.txt | grep "Running against:" | awk '{print $3}' | tee targets/$2/linkfinder_JS_links.txt
cat targets/$2/linkfinder_JS_links_temp.txt | grep -v "Running against:" | anew targets/$2/linkfinder_JS_links.txt
rm targets/$2/linkfinder_JS_links_temp.txt

grep -Fv '.js' targets/$2/linkfinder_URLs_excluded.txt | tee targets/$2/linkfinder_links.txt

sudo mysql $3 -e "create table if not exists linkfinder_js_links(link VARCHAR(255) NOT NULL, UNIQUE(link))"

while read line
do
sudo mysql $3 -e "insert ignore into linkfinder_js_links (link) values ('$line')"
done < "targets/$2/linkfinder_JS_links.txt"

sudo mysql $3 -e "create table if not exists linkfinder_links(link VARCHAR(255) NOT NULL, UNIQUE(link))"

while read line
do
sudo mysql $3 -e "insert ignore into linkfinder_links (link) values ('$line')"
done < "targets/$2/linkfinder_links.txt"
