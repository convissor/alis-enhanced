<?php

set_include_path(get_include_path() . PATH_SEPARATOR . './math-geographicpoint');
require './math-geographicpoint/Math/GeographicPoint/UTM.php';

$file = fopen('./csv/gps.csv', 'w');
if (!$file) {
	echo "ERROR: could not open output file\n";
	exit(1);
}

$answer = array(
	'case_num',
	'comp_longitude',
	'comp_latitude',
);

if (!fputcsv($file, $answer)) {
	echo "ERROR: adding headers to output file failed.\n";
	exit(1);
}


$sql_select = "SELECT
	case_num, TRIM(comp_x) AS comp_x, TRIM(comp_y) AS comp_y
	FROM raw WHERE comp_x <> '' AND comp_y <> ''";

$db = new SQLite3('alis-enhanced.sqlite3');
$rows = $db->query($sql_select);

if (!$rows) {
	echo "ERROR: no results?!\n";
	exit(1);
}


while ($row = $rows->fetchArray()) {
	if (!is_numeric($row['comp_x']) || !is_numeric($row['comp_y'])) {
		echo 'WARNING: bad comp_x or comp_y for case_num ' . $row['case_num'] . "\n";
		continue;
	}

	$utm = new Math_GeographicPoint_UTM($row['comp_x'], $row['comp_y'], '18T');
	$ll = $utm->toLatitudeLongitude();

	$answer = array(
		$row['case_num'],
		$ll->GetLongitude(),
		$ll->GetLatitude(),
	);

	if (!fputcsv($file, $answer)) {
		echo "ERROR: adding row to output file failed.\n";
		exit(1);
	}
}
