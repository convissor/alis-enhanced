-- https://patch.com/new-york/pleasantville/sleepy-hollow-police-cyclist-fatality-on-route-9
UPDATE crash SET
	severity = 'FATAL',
	num_of_injuries = 0,
	num_serious_injuries = 0,
	num_of_fatalities = 1
WHERE case_num = 34461199;
