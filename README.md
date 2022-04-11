ALIS Enhanced
=============

Overview
--------
Creates an SQLite database of motor vehicle crash data obtained from the
Accident Location Information System (ALIS) run by New York State's
Department of Transportation.

Obtaining the Data
------------------
File a Freedom of Information Law (FOIL) request with NYSDOT to get
a dump of ALIS data.

They will send you one or more Excel files.  Manually export each file
into .csv format.  Place those .csv files in the `csv` directory of this
repository.

Creating the Database
---------------------
Run `./create-schema.sh`

Cleaning the Data
-----------------
In crash reports, police officers put any street name they feel like.
For example, the same street may be entered as "US Hwy 9", "[Route] 9",
"N Broadway", or "Broadway".

You can normalize the street names in `schema-standardize-streets.sh`.

Using the Database
------------------
There are some files named `function-*` which can be used to extract
frequently requested data.

Or you can run your own SQL queries on the command line.
To get into the database: `sqlite3 alis-enhanced.sqlite3`

See the `schema-crash.sql` file for the structure of the `crash` table.
