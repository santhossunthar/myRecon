#!/bin/bash

cat targets/$1/linkfinder_links.txt | anew targets/$1/links_all.txt
cat targets/$1/relative_URL_JS_links.txt | anew targets/$1/links_all.txt

cat targets/$1/links_all.txt | httpx -status-code -content-type -title | anew targets/$1/links_alive_temp.txt

cat targets/$1/links_alive_temp.txt | sed 's/\x1b\[[0-9;]*m//g' | anew targets/$1/links_alive.txt
rm targets/$1/links_alive_temp.txt