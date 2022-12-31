#!/bin/bash

python3 tools/dirsearch/dirsearch.py -l $1 -t 20 --exclude-status 401,403 -o targets/$2/fuzzed_directories.txt





