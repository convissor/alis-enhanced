-- Create Good Table
CREATE TABLE crash(
  "case_num" INT,
  "year" SMALLINT(4),
  "month" TINYINT(2),
  "day" TINYINT(2),
  "hour" TINYINT(2),
  "minute" TINYINT(2),
  "county" VARCHAR(14),
  "municipality" VARCHAR,
  "muni_type" TINYINT,
  "comp_ref_marker" VARCHAR,
  "at_intersection" CHARACTER(1),
  "comp_utm_18_easting" REAL,
  "comp_utm_18_northing" REAL,
  "comp_longitude" REAL,
  "comp_latitude" REAL,
  "severity" VARCHAR(30),
  "num_of_injuries" TINYINT,
  "num_serious_injuries" TINYINT,
  "num_of_fatalities" TINYINT,
  "num_of_vehicles" TINYINT,
  "accd_type" VARCHAR(42),
  "collision_type" VARCHAR(30),
  "traffic_control" VARCHAR(35),
  "light_condition" VARCHAR(19),
  "weather" VARCHAR(24),
  "road_surf_cond" VARCHAR(14),
  "ped_loc" VARCHAR(33),
  "ped_action" VARCHAR(35),
  "veh_type_veh_1" VARCHAR(14),
  "veh_type_veh_2" VARCHAR(14),
  "dir_of_travel_veh_1" VARCHAR(14),
  "dir_of_travel_veh_2" VARCHAR(14),
  "apparent_factor_veh_1" VARCHAR(43),
  "apparent_factor_veh_2" VARCHAR(43),
  "driver_age_veh_1" TINYINT,
  "driver_age_veh_2" TINYINT,
  "pre_accd_actn_veh1" VARCHAR(26),
  "pre_accd_actn_veh2" VARCHAR(26),
  "day_of_week" CHARACTER(3),
  "on_street" VARCHAR,
  "closest_cross_street" VARCHAR,
  "parking_lot_ind" CHARACTER(1)
);

CREATE INDEX municipality_idx ON crash (municipality);
CREATE INDEX year_idx ON crash (year);

-- Copy Data to Good Table
INSERT INTO crash
SELECT
  case_num,
  SUBSTR(accd_date,7,4) AS year,
  SUBSTR(accd_date,1,2) AS month,
  SUBSTR(accd_date,4,2) AS day,
  CASE
    WHEN SUBSTR(accd_time,6,1) = 'a'
    THEN SUBSTR(accd_time,1,2)
    ELSE
      CASE
        WHEN SUBSTR(accd_time,1,2) = '12'
        THEN SUBSTR(accd_time,1,2)
        ELSE SUBSTR(accd_time,1,2) + 12
      END
  END AS hour,
  SUBSTR(accd_time,4,2) AS minute,
  county,
  comp_muni,
  muni_type,
  comp_ref_marker,
  at_intersection,
  comp_x,
  comp_y,
  comp_longitude,
  comp_latitude,
  severity,
  CASE
    WHEN num_of_injuries = ''
    THEN 0
    ELSE TRIM(num_of_injuries, '()')
  END AS num_of_injuries,
  CASE
    WHEN num_serious_injuries = ''
    THEN 0
    ELSE TRIM(num_serious_injuries, '()')
  END AS num_serious_injuries,
  CASE
    WHEN num_of_fatalities = ''
    THEN 0
    ELSE TRIM(num_of_fatalities, '()')
  END AS num_of_fatalities,
  num_of_vehicles,
  accd_type,
  collision_type,
  traffic_control,
  light_condition,
  weather,
  road_surf_cond,
  ped_loc,
  ped_action,
  veh_type_veh_1,
  veh_type_veh_2,
  dir_of_travel_veh_1,
  dir_of_travel_veh_2,
  apparent_factor_veh_1,
  apparent_factor_veh_2,
  driver_age_veh_1,
  driver_age_veh_2,
  pre_accd_actn_veh1,
  pre_accd_actn_veh2,
  day_of_week,
  LOWER(on_street),
  LOWER(closest_cross_street),
  parking_lot_ind
FROM raw
LEFT JOIN gps USING (case_num);

-- Drop Raw Tables
DROP TABLE raw;
DROP TABLE gps;
