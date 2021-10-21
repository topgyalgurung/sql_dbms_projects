
-- 2018_zcta_superset

CROSS JOIN UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                  '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],',']]]],'),']],')) AS `geography`

---------------------------------------------------------------

SELECT distinct
 home_msa,
  cd.*,
  geography
FROM censusData cd 
INNER JOIN `rf-research.acs.zcta_to_tract` zt ON cd.tract = zt.GEOID
INNER JOIN `rf-research.acs.zip_to_cbsa` cbsa ON zt.zcta5 = cbsa.zip
INNER JOIN MSA m ON m.home_msa_id = cbsa.cbsa
INNER JOIN `rf-research.census_geo.2018_tract` c ON cd.tract = CAST(c.GEOID AS INT64)
CROSS JOIN UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                  '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],',']]]],'),']],')) AS `geography`
---------------------------------------------------------------

-- REGEXP_EXTRACT()
-- Third argument in SUBSTR() cannot be negative

SELECT 
   `geography`
    FROM `rf-research.census_geo.2018_zcta` c
     CROSS JOIN UNNEST(SPLIT(REPLACE(REPLACE(
          SUBSTR(REPLACE(REPLACE(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),']]]','))'),']],',']]]],'),
          1,STRPOS(REPLACE(REPLACE(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),']]]','))'),']],',']]]],'),']],')-1),
          '[[[','[['),'))',']]]]'),']],')) AS `geography`
                   WHERE GEOID10='15317'
/* 
--     CROSS JOIN UNNEST(SPLIT(REPLACE(REPLACE(
--           SUBSTR(REPLACE(REPLACE(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),']]]','))'),']],',']]]],'),
--           2,STRPOS(REPLACE(REPLACE(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),']]]','))'),']],',']],'),']],')-2),
--           '[[[','[['),'))',']]]]'),']],')) AS `geography`

*/

-- SELECT SUBSTR(name, 1, STRPOS(name, '(') - 1) AS clean_name 
-- works for multipolygon to remove holes and polygon with holes
SELECT 
      SPLIT(REPLACE(REPLACE(REPLACE(
          SUBSTR(REPLACE(REPLACE(
                JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),
                      ']]],','))),'),']],',']]]],'),
          2,STRPOS(REPLACE(REPLACE(
               JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),
                      ']]],','))),'),']],',']]]],'),
               ']],')),
                       '[[[','[['),']]]',']'),')))',']]]]'),']],')
          FROM  `rf-research.census_geo.2018_zcta` c
                   where GEOID10='15234'

--- SO FAR SHOULD WORK FOR BOTH

-- topgyal fix polygon with holes
--July 26
-- topgyal fix polygon with holes


WITH polygon AS (
  SELECT 
   SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates'),
                2, 
                LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                  '$.coordinates'))
                  - 2) AS geography                
            from `rf-research.census_geo.2018_zcta` c
            where GEOID10='19102'  --15234
--            WHERE GEOID10='15234'
)
SELECT 
--     CASE WHEN (p.geography like ']],') 
CASE WHEN REGEXP_CONTAINS(p.geography,']],')
    THEN
     SPLIT(REPLACE(REPLACE(REPLACE(
          SUBSTR(REPLACE(REPLACE(
                JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),
                      ']]],','))),'),']],',']]]],'),
          2,STRPOS(REPLACE(REPLACE(
               JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),
                      ']]],','))),'),']],',']]]],'),
               ']],')),
                       '[[[','[['),']]]',']'),')))',']]]]'),']],' )
    ELSE               
       SPLIT(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                  '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],',']]]],'),']],')
    END
                
 FROM  `rf-research.census_geo.2018_zcta` c , polygon p
 WHERE GEOID10='19102'
--   WHERE GEOID10='15234'
  
  