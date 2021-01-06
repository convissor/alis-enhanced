#! /bin/bash -e

function usage() {
	echo "Extract yearly totals of ped/bike involved crashes in CSV format"
	echo ""
	echo "Usage: $0 [municipality]"
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
	SUM(num_of_injuries) - SUM(num_serious_injuries) AS minor_injury,
	SUM(num_serious_injuries) AS serious_injury,
	SUM(num_of_fatalities) AS fatality
FROM crash
WHERE veh_type_veh_2 IN ('PEDESTRIAN', 'BICYCLE')"

if [[ -n "$1" ]] ; then
	arg=${1//"'"/"''"}
	sql="$sql AND municipality = '$arg'"
fi

sql="$sql
GROUP BY year
ORDER BY year;"


#echo "$sql_on"

echo "$sql" | sqlite3 alis-enhanced.sqlite3
