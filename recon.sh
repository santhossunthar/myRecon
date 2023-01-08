#!/bin/bash

if [ -z $1 ]; then
	echo "Usage: Domain Name"
	echo "Usage: DB Name"
	exit
fi

mkdir -p targets/$1

./subdomains.sh $1 $2

./urls.sh $1 $2

./fuzzing_directories.sh targets/$1/subdomains_alive_data.txt $1 $2

./linkfinder.sh targets/$1/subdomains_alive_data.txt $1 $2

./relative_URL_extractor.sh targets/$1/linkfinder_JS_links.txt $1 $2

./secretfinder.sh targets/$1/subdomains_alive_data.txt $1 $2

./url_requests.sh $1 $2

./bypass.sh $1 $2










