#! /bin/bash -e

function usage() {
	echo "Extract yearly totals of ped/bike involved crashes"
	echo ""
	echo "Usage: $0 [municipality (Title Case)] [street (lower case)]"
}

if [[ $1 == "-h" || $1 == "--help" || $1 == "help" ]] ; then
	usage
	exit
fi

sql="
.mode csv

SELECT
	year,
	COUNT(*) AS crash_ped_bike,
	SUM(num_of_injuries) - SUM(num_serious_injuries) AS minor_injury_ped_bike,
	SUM(num_serious_injuries) AS serious_injury_ped_bike,
	SUM(num_of_fatalities) AS fatality_ped_bike
FROM crash
WHERE veh_type_veh_2 IN ('PEDESTRIAN', 'BICYCLE')"

if [[ -n "$1" ]] ; then
	arg=${1//"'"/"''"}
	sql="$sql AND municipality = '$arg'"
fi

if [[ -n "$2" ]] ; then
	arg=${2//"'"/"''"}
	sql="$sql AND on_street = '$arg'"
fi

sql="$sql
GROUP BY year
ORDER BY year;"


#echo "$sql_on"

echo "$sql" | sqlite3 alis-enhanced.sqlite3
