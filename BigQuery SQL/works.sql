-- Look at this section of the view. There is a field WKT that get's parsed into "geography". Currently it parses everything into a Comma Delimited List that contains brackets. 
--I want you to re-parse this into separate rows based on the WKT field. Everything that has a triple bracket ([[[,]]]) should get parsed into its own row with the other data fields duplicated. E.g. if a row contains [[[, or ]]] then it should become two separate rows with only [[, ]] and the rest of the data duplicated.

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

---                 --                     ---                       ---

-- Take a look at this example. It has "  MULTIPOLYGON" in the field WKT

select WKT from `rf-research.census_geo.2018_zcta`
where ZCTA5CE10 = '41562'

--We need to parse the WKT field such that it is in the format [ [lat, long], [lat, long], [lat, long] ]

select 
      SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates')) - 2)
from `rf-research.census_geo.2018_zcta` c
where ZCTA5CE10 = '41562'

--The issue is that in multi-polygon arrays the field actually refers to two lists. So it looks like:
--[ [lat, long], [lat, long], [lat, long] ], [ [ lat, long], [lat, long] ]. We need to identify these breaks and parse them into their own separate line.


--These can be identified by "]]],[[[" in the parsed substring. Your program should be able to identify these cases, and then separate them into two different rows (as opposed to one row). The two resulting rows should have identical data for everything except this geography substring.

              --SOLUTION:  ------------

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
  geography
FROM censusData cd 
INNER JOIN `rf-research.acs.zcta_to_tract` zt ON cd.tract = zt.GEOID
INNER JOIN `rf-research.acs.zip_to_cbsa` cbsa ON zt.zcta5 = cbsa.zip
INNER JOIN MSA m ON m.home_msa_id = cbsa.cbsa
INNER JOIN `rf-research.census_geo.2018_tract` c ON cd.tract = CAST(c.GEOID AS INT64)
CROSS JOIN UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                  '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],',']]]],'),']],')) AS `geography`

