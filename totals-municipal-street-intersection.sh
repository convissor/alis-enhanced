#! /bin/bash -e

function usage() {
	echo "Extract intersection totals of ped/bike involved crashes"
	echo ""
	echo "Usage: $0 <municipality (Title Case)> <street (lower case)>"
}

if [[ $1 == "-h" || $1 == "--help" || $1 == "help" ]] ; then
	usage
	exit
fi

if [[ -z "$2" ]] ; then
	echo "Error: need to provide two arguments"
	echo ""
	usage
	exit 1
fi

arg=${1//"'"/"''"}
municipality="municipality = '$arg'"

arg=${2//"'"/"''"}
street_on="AND on_street = '$arg'"
street_closest="AND closest_cross_street = '$arg'"


sql="
.mode csv

SELECT
	cross_street,
	SUM(crash) AS crash,
	SUM(minor_injury) AS minor_injury,
	SUM(serious_injury) AS serious_injury,
	SUM(fatality) AS fatality
FROM (
	SELECT
		closest_cross_street AS cross_street,
		COUNT(*) AS crash,
		SUM(num_of_injuries) - SUM(num_serious_injuries) AS minor_injury,
		SUM(num_serious_injuries) AS serious_injury,
		SUM(num_of_fatalities) AS fatality
	FROM crash
	WHERE
		$municipality
		$street_on
		AND at_intersection = 'Y'
	GROUP BY cross_street
UNION
	SELECT
		on_street AS cross_street,
		COUNT(*) AS crash,
		SUM(num_of_injuries) - SUM(num_serious_injuries) AS minor_injury,
		SUM(num_serious_injuries) AS serious_injury,
		SUM(num_of_fatalities) AS fatality
	FROM crash
	WHERE
		$municipality
		$street_closest
		AND at_intersection = 'Y'
	GROUP BY cross_street
)
"

sql="$sql
GROUP BY cross_street
ORDER BY crash DESC, cross_street;"


#echo "$sql_on"

echo "$sql" | sqlite3 alis-enhanced.sqlite3
