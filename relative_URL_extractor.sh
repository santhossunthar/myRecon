#!/bin/bash

while read url
do
curl -s $url | ruby tools/relative-url-extractor/extract.rb --url | anew targets/$2/relative_URLs.txt
done < "$1"

