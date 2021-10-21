
-- Previous code   --
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
    )
SELECT distinct
 home_msa,
  cd.*,
  REPLACE(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
              '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates')) - 2),']]],[[[','],['),'[[[','[['),']]]',']]'),']],[[','],[') AS `geography`
FROM censusData cd 
INNER JOIN `rf-research.acs.zcta_to_tract` zt ON cd.tract = zt.GEOID
INNER JOIN `rf-research.acs.zip_to_cbsa` cbsa ON zt.zcta5 = cbsa.zip
INNER JOIN MSA m ON m.home_msa_id = cbsa.cbsa
INNER JOIN `rf-research.census_geo.2018_tract` c ON cd.tract = CAST(c.GEOID AS INT64)

--- ---- -----

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
    LPAD(CAST(demo.zip as STRING), 5,'0') as zip,
    ROUND(100 * SEXANDAGETotalpopulationMale/NULLIF(SEXANDAGETotalpopulation,0),2) AS PctMale,
    ROUND(100 * SEXANDAGETotalpopulationFemale/NULLIF(SEXANDAGETotalpopulation,0),2) AS PctFemale,
    ROUND(100 * (EDUCATIONALATTAINMENTPopulation25yearsandoverAssociatesdegree + EDUCATIONALATTAINMENTPopulation25yearsandoverBachelorsdegree + EDUCATIONALATTAINMENTPopulation25yearsandoverGraduateorprofessionaldegree) /NULLIF(EDUCATIONALATTAINMENTPopulation25yearsandover,0),2) AS PctCollegeGrad,
    ROUND(100 * (1-HOUSINGOCCUPANCYTotalhousingunitsOccupied/NULLIF(HOUSINGOCCUPANCYTotalhousingunits,0)),2) AS Vacancy,
    ROUND(100 * HUBuilt2000to2009/NULLIF(YEARSTRUCTUREBUILTTotalhousingunits,0),2) AS PctNewSince2000,
    ROOMSTotalhousingunitsMedianrooms AS HousingMedianRooms
  FROM
    `rf-research.acs.acs5yr_demograph_zip` demo
  INNER JOIN
    `rf-research.acs.acs5yr_housing_zip` housing
  ON
    demo.zip = housing.zip
    AND demo.year = housing.year
       --AND demo.year = 2017 
    )
SELECT distinct
 home_msa,
  cd.*,
  REPLACE(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
              '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates')) - 2),']]],[[[','],['),'[[[','[['),']]]',']]'),']],[[','],[') AS `geography`
FROM censusData cd 
INNER JOIN `rf-research.acs.zip_to_cbsa` cbsa ON CAST(cd.zip as INT64) = cbsa.zip
INNER JOIN MSA m ON m.home_msa_id = cbsa.cbsa
INNER JOIN `rf-research.census_geo.2018_zcta` c ON CAST(cd.zip as INT64)  = CAST(c.GEOID10 as INT64)

--UNNEST takes array and return single row for each element
--CROSS JOIN - cartesian product