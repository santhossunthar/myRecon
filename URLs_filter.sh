#!/bin/bash

grep -Fv -e '&' -e '?' targets/$2/URLs_excluded.txt | anew targets/$2/URLs_without_parameters.txt
grep -e '&' -e '?' targets/$2/URLs_excluded.txt | anew targets/$2/URLs_with_parameters.txt

./URLs_directories.sh targets/$2/URLs_without_parameters.txt $2
rm targets/$2/URLs_without_parameters.txt

./URLs_parameters.sh targets/$2/URLs_with_parameters.txt $2
rm targets/$2/URLs_with_parameters.txt

./parameters_filter.sh targets/$2/parameters_temp.txt $2
rm targets/$2/parameters_temp.txt

./parameters.sh targets/$2/parameters_with_values.txt $2
./parameters_values.sh targets/$2/parameters_with_values.txt $2
rm targets/$2/parameters_with_values.txt