#!/bin/bash

while read url
do
setOfLinks=$(curl -s $url | ruby tools/relative-url-extractor/extract.rb --url)

echo "$setOfLinks" | grep '^http' | anew targets/$2/relative_URLs.txt
echo "$setOfLinks" | grep -v '^http' | sed "s|^/|$url\/|1" | anew targets/$2/relative_URLs.txt
done < "$1"

cat targets/$2/relative_URLs.txt | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|svg)" | tee targets/$2/relative_URLs_excluded.txt
rm targets/$2/relative_URLs.txt

grep -F '.js' targets/$2/relative_URLs_excluded.txt | anew targets/$2/relative_URL_JS_links.txt

sudo mysql $3 -e "create table if not exists relative_js_links(link VARCHAR(255) NOT NULL)"

while read line
do
sudo mysql $3 -e "insert into relative_js_links (link) values ('$line')"
done < "targets/$2/relative_URL_JS_links.txt"
