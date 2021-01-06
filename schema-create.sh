#! /bin/bash -e

if [[ -f 'alis-enhanced.sqlite3' ]] ; then
	echo ""
	echo "WARNING: database file exists."
	echo "This process will overwrite that file."
	echo ""
	echo "Proceed? [N|y]"
	read -e
	if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]] ; then
		echo "No problem.  Good bye."
		exit 1
	fi
fi

rm alis-enhanced.sqlite3
rm -f csv/raw.csv
rm -f csv/tmp.csv
rm -f csv/gps.csv


# Import the CSV files

IFS_ORIG=$IFS
IFS=$(echo -en "\n\b")
for file in $(ls csv/*.csv) ; do
	cat "$file" >> csv/tmp.csv
done
IFS=$IFS_ORIG

cp csv/headers.txt csv/raw.csv
cat csv/tmp.csv >> csv/raw.csv
rm csv/tmp.csv

echo ".mode csv
.import csv/raw.csv raw" | sqlite3 alis-enhanced.sqlite3

rm csv/raw.csv

echo "Imported main csv file"


# The rest of the job.

php schema-utm-to-gps.php
echo "Converted UTM to GPS"

# Have to do separately because UPDATE FROM is recent feature.
sqlite3 alis-enhanced.sqlite3 < schema-import-gps.sql
rm csv/gps.csv
echo "Imported GPS csv file"

sqlite3 alis-enhanced.sqlite3 < schema-crash.sql
echo "Converted data into crash table"

sqlite3 alis-enhanced.sqlite3 < corrections.sql
echo "Corrected data"

./standardize-streets.sh
echo "Standardized street names"

echo "DONE"
