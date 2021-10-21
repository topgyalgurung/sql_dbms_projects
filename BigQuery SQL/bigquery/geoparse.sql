 CROSS JOIN UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                  '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],',']]]],'),']],')) AS `geography`

--UNNEST takes array and return single row for each element
--CROSS JOIN - cartesian product

WITH
  MSA AS (
  SELECT
    home_msa,
    home_msa_id
  FROM
    `rf-research.acs.2018_msa_summary_stats` --where home_msa like ("%SEATTLE%") --31080
    ),
  censusData AS (
  SELECT
    demo.year,
    demo.tract,
    ROUND(100 * SEXANDAGETotalpopulationMale/NULLIF(SEXANDAGETotalpopulation,0),2) AS PctMale,
    ROUND(100 * SEXANDAGETotalpopulationFemale/NULLIF(SEXANDAGETotalpopulation,0),2) AS PctFemale,
    ROUND(100 * (EDUCATIONALATTAINMENTPopulation25yearsandoverAssociatesdegree + EDUCATIONALATTAINMENTPopulation25yearsandoverBachelorsdegree + EDUCATIONALATTAINMENTPopulation25yearsandoverGraduateorprofessionaldegree) /NULLIF(EDUCATIONALATTAINMENTPopulation25yearsandover,0),2) AS PctCollegeGrad,
    ROUND(100 * (1-HOUSINGOCCUPANCYTotalhousingunitsOccupied/NULLIF(HOUSINGOCCUPANCYTotalhousingunits,0)),2) AS Vacancy,
    ROUND(100 * HUBuilt2000to2009/NULLIF(YEARSTRUCTUREBUILTTotalhousingunits,0),2) AS PctNewSince2000,
    ROOMSTotalhousingunitsMedianrooms AS HousingMedianRooms
  FROM
    `rf-research.acs.acs5yr_demograph_tract` demo
  INNER JOIN
    `rf-research.acs.acs5yr_housing_tract` housing
  ON
    demo.tract = housing.tract
    AND demo.year = housing.year
       --AND demo.year = 2017 
    ),
sequences AS 
(
SELECT
-- [[[,],[,]..[,]],[[,],[,]...,[,]]]
--replace ']],' with ']]]],' and split when ']],' matched
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
INNER JOIN `rf-research.acs.zcta_to_tract` zt ON cd.tract = zt.GEOID
INNER JOIN `rf-research.acs.zip_to_cbsa` cbsa ON zt.zcta5 = cbsa.zip
INNER JOIN MSA m ON m.home_msa_id = cbsa.cbsa
INNER JOIN `rf-research.census_geo.2018_tract` c ON cd.tract = CAST(c.GEOID AS INT64)

--UNNEST takes array and return single row for each element
--CROSS JOIN - cartesian product

/*  ************
   field WKT that get's parsed into "geography". Currently it parses everything into a Comma Delimited List that contains brackets.
   replace multiple patterns in a given string
*/
--
-- JSON_EXTRACT(json_string_expr, json_path_string_literal), which returns JSON values as STRINGs, '$ .coordinates'-  path
-- WKT (well known text), ST_ASGEOJSON() - to export data in GeoJSON format
-- SUBSTRING ( expression ,start , length )
--
      -- REPLACE(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
   --             '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
   --         '$.coordinates')) - 2),']]],[[[','],['),'[[[','[['),']]]',']]'),']],[[','],[') AS `geography`,

/* -- TABLE: census_geo.2018_tract --
       WKT(  geometry data in WKT format) 
     | POLYGON((-86.. 34... ,))

 -- TABLE: 2018_msa_summary_stats --

      |  home_msa |             geography       
      |  SEATLE.. | [[-121...,36...],[-121..,36..],[-121...,36...],[-121...,36...]..|
*/ -- NullIf(SUBSTR(''))
    -- CROSS APPLY STRING_SPLIT()
    -- UPDATE ..SET
    -- CAST ()