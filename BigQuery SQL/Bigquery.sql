--demo_housing_by_zip

  sequences AS 
  ( SELECT
      SPLIT(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                  '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],',']]]],'),']],') AS geo        
    FROM `rf-research.census_geo.2018_zcta` c
  )
  SELECT --distinct
   home_msa,
    cd.*,
   `geography`
  FROM sequences seq,  -- (, ==CROSS JOIN)
  UNNEST(seq.geo) as `geography` --flatten array with cross join and unnest


  ----------------------------------------------------------------------------------------------------
  ----------------------------------------------------------------------------------------------------
WITH sequences AS 
(
SELECT 
  c.GEOID10 AS AreaIden,
  c.ZCTA5CE10 AS AreaCode, --ZIP code area identifier
  SPLIT(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
               '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
              '$.coordinates')) - 2),'[[[','[['),']],') AS geo              
  FROM `rf-research.census_geo.2018_zcta` c
   WHERE ZCTA5CE10 = '41562' 
)
SELECT
  AreaIden,AreaCode,geography
FROM  sequences seq
CROSS JOIN UNNEST(seq.geo) as geography

#CROSS JOIN 
#UNNEST convert array into rows -flattening
-- return one row for each array element
------------------------------------------------------------------------------------------------------------
/*
 REPLACE(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
              '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates')) - 2),']]],[[[','],['),'[[[','[['),']]]',']]'),']],[[','],[') AS `geography
*/
-------------------------------------------------------------------------------------------------
/* updated code, that works */

-- demo_housing_by_tract

sequences AS 
(
SELECT 
   SPLIT(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
              '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],',']]]],'),']],') AS geo        
FROM `rf-research.census_geo.2018_zcta` c 
)
SELECT --distinct
 home_msa,
  cd.*,
  geography
FROM censusData cd,sequences seq 
--flatten array with cross join and unnest
CROSS JOIN UNNEST(seq.geo) as geography  --cross join or ,

--UNNEST takes array and return single row for each element
--CROSS JOIN - cartesian product
