#! /bin/bash -e

function usage() {
	echo "Standardize street names in your crash database"
	echo ""
	echo "Usage: $0 <municipality> <proper street name> <other street name> [<other street name>]..."
}

if [[ $1 == "-h" || $1 == "--help" || $1 == "help" ]] ; then
	usage
	exit
fi

if [[ -z "$3" ]] ; then
	echo ""
	echo "ERROR: missing arguments"
	usage
	exit 1
fi


i=0

for arg in "$@" ; do
	arg=${arg//"'"/"''"}

	if [[ $i -eq 0 ]] ; then
		sql_on="WHERE municipality = '$arg' AND on_street IN ("
		sql_closest="WHERE municipality = '$arg' AND closest_cross_street IN ("
	elif [[ $i -eq 1 ]] ; then
		sql_on="UPDATE crash SET on_street = '$arg' $sql_on"
		sql_closest="UPDATE crash SET closest_cross_street = '$arg' $sql_closest"
	elif [[ $i -eq 2 ]] ; then
		sql_on="$sql_on '$arg'"
		sql_closest="$sql_closest '$arg'"
	else
		sql_on="$sql_on, '$arg'"
		sql_closest="$sql_closest, '$arg'"
	fi
	i=$i+1
done

sql_on="$sql_on);"
sql_closest="$sql_closest);"

#echo "$sql_on"

echo "$sql_on" | sqlite3 alis-enhanced.sqlite3
echo "$sql_closest" | sqlite3 alis-enhanced.sqlite3
