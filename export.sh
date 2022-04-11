#! /bin/bash -e

function usage() {
	echo "Extract all columns from the crash database"
	echo ""
	echo "Usage: $0 [municipality (Title Case)]"
}

if [[ $1 == "-h" || $1 == "--help" || $1 == "help" ]] ; then
	usage
	exit
fi

sql="
.mode csv

SELECT * FROM crash"

if [[ -n "$1" ]] ; then
	arg=${1//"'"/"''"}
	sql="$sql WHERE municipality = '$arg'"
fi

#echo "$sql_on"

echo "$sql" | sqlite3 alis-enhanced.sqlite3
