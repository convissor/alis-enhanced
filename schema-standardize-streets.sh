#! /bin/bash -e

./function-standardize-street-by-name.sh "Sleepy Hollow" "us 9" "us hwy 9" "[route] 9" "n broadway" "broadway"
./function-standardize-street-by-name.sh "Sleepy Hollow" "ny 448" "state hwy 448" "[route] 448" "bedford rd"

./function-standardize-street-by-name.sh "Irvington" "us 9" "us hwy 9" "[route] 9" "n broadway" "s broadway" "broadway"

./function-standardize-street-by-name.sh "Dobbs Ferry" "us 9" "us hwy 9" "[route] 9" "n broadway" "s broadway" "broadway"

./function-standardize-street-by-name.sh "Hastings-on-Hudson" "us 9" "us hwy 9" "[route] 9" "n broadway" "s broadway" "broadway"
./function-standardize-street-by-name.sh "Hastings-on-Hudson" "ny 9a" "state hwy 9a" "[route] 9a" "saw mill river rd"

./function-standardize-street-by-name.sh "Tarrytown" "us 9" "us hwy 9" "[route] 9" "n broadway" "s broadway" "broadway"
./function-standardize-street-by-name.sh "Tarrytown" "ny 119" "state hwy 119" "[route] 119" "119" "white plains rd"
./function-standardize-street-by-name.sh "Tarrytown" "i 87" "[route] 87" "i 287" "[route] 287" "new york state trwy"
./function-standardize-street-by-name.sh "Tarrytown" "elizabeth st" "w elizabeth st" "e elizabeth st"
./function-standardize-street-by-name.sh "Tarrytown" "franklin st" "w franklin st" "e franklin st"
./function-standardize-street-by-name.sh "Tarrytown" "washington st" "n washington st" "s washington st"
./function-standardize-street-by-name.sh "Tarrytown" "sunnyside ln" "west sunnyside la" "east sunnyside la" "e sunnyside ln"
./function-standardize-street-by-name.sh "Tarrytown" "main st / neperan rd" "main st" "neperan rd" "main-neperan sts"

./function-standardize-street-by-name.sh "Greenburgh" "ny 119" "state hwy 119" "[route] 119" "119" "white plains rd" "tarrytown rd"
./function-standardize-street-by-name.sh "Greenburgh" "i 87" "[route] 87" "new york state trwy"
./function-standardize-street-by-name.sh "Greenburgh" "ny 9a" "state hwy 9a" "[route] 9a" "saw mill river rd"

./function-standardize-street-by-name.sh "Ardsley" "ny 9a" "state hwy 9a" "[route] 9a" "saw mill river rd"

./function-standardize-street-by-name.sh "Elmsford" "ny 119" "state hwy 119" "[route] 119" "119" "e main st" "w main st" "main st" "w tarrytown rd" "tarrytown rd" "white plains rd"
./function-standardize-street-by-name.sh "Elmsford" "ny 9a" "state hwy 9a" "[route] 9a" "n central ave" "s central ave" "central ave"
./function-standardize-street-by-name.sh "Elmsford" "i 287" "[route] 287"

./function-standardize-street-by-name.sh "Mount Pleasant" "us 9" "us hwy 9" "[route] 9" "albany post rd"

# overlap w/ 100
#./function-standardize-street-by-name.sh "Mount Pleasant" "ny 9a" "state hwy 9a" "[route] 9a" "saw mill river rd"
./function-standardize-street-by-name.sh "Briarcliff Manor" "us 9" "us hwy 9" "[route] 9" "albany post rd" "s highland ave"

# overlap w/ 100
#./function-standardize-street-by-name.sh "Briarclif Manor" "ny 9a" "state hwy 9a" "[route] 9a" "saw mill river rd" "briarcliff peekskill pkwy"

./function-standardize-street-by-name.sh "Ossining" "us 9" "us hwy 9" "[route] 9" "albany post rd" "s highland ave" "n highland ave"

./function-standardize-street-by-name.sh "Peekskill" "us 9" "us hwy 9" "[route] 9" "briarcliff peekskill pkwy"
./function-standardize-street-by-name.sh "Peekskill" "ny 9a" "state hwy 9a" "[route] 9a" "albany post rd" "albany post rd e" "albany post rd  e" "albany post rd s"
./function-standardize-street-by-name.sh "Peekskill" "us 6" "us hwy 6" "[route] 6" "main st"
./function-standardize-street-by-name.sh "Peekskill" "bear mountain state pkwy" "[route] 987h" "state pkwy 987h"
./function-standardize-street-by-name.sh "Peekskill" "us 202" "us hwy 202" "[route] 202" "state hwy 35" "[route] 35"
./function-standardize-street-by-name.sh "Peekskill" "crompond rd" "crompoond rd" "crompound rd"
./function-standardize-street-by-longitude.sh "Peekskill" "us 202" "> -73.915441" "crompond rd"

./function-standardize-street-by-name.sh "Buchanan" "ny 9a" "state hwy 9a" "[route] 9a" "albany post rd" "new york and albany post rd"
