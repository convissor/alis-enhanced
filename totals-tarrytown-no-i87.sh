#! /bin/bash -e

function usage() {
	echo "Extract yearly totals of all crashes for Tarrytown (w/o I-87)"
	echo ""
}

if [[ $1 == "-h" || $1 == "--help" || $1 == "help" ]] ; then
	usage
	exit
fi

sql="
.mode csv

SELECT
	year,
	COUNT(*) AS crash,
	SUM(num_of_injuries) AS injury,
	SUM(num_of_injuries) - SUM(num_serious_injuries) AS minor_injury,
	SUM(num_serious_injuries) AS serious_injury,
	SUM(num_of_fatalities) AS fatality
FROM crash
WHERE municipality = 'Tarrytown'
AND on_street <> 'i 87'
GROUP BY year
ORDER BY year;"


#echo "$sql_on"

echo "$sql" | sqlite3 alis-enhanced.sqlite3
