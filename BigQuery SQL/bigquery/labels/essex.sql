BLS 
-- Seattle-Bellevue-Everett, WA Metropolitan Division,
-- San Francisco-Redwood City-South San Francisco, CA Metropolitan Division,
-- Oakland-Hayward-Berkeley, CA Metropolitan Division,
-- San Jose-Sunnyvale-Santa Clara, CA,
-- Oxnard-Thousand Oaks-Ventura, CA,
-- Los Angeles-Long Beach-Glendale, CA Metropolitan Division,
-- Anaheim-Santa Ana-Irvine, CA Metropolitan Division,
-- San Diego-Carlsbad, CA

-- Resources
-- MySQL: LIMIT by a percentage of the amount of records?
https://stackoverflow.com/questions/5615172/mysql-limit-by-a-percentage-of-the-amount-of-records


Select TOP X (or bottom) percent for numeric values in MySQL

SELECT * 
  FROM `essex-248619.income_demographics.home_tract`
 WHERE 
 AnnIncome >=
 (
   SELECT AnnIncome 
   FROM `essex-248619.income_demographics.home_tract` h1
   WHERE (
     SELECT COUNT(*) FROM `essex-248619.income_demographics.home_tract` h2
    WHERE h2.AnnIncome >=h1.AnnIncome)
    <= 
      (
        SELECT 0.1 * COUNT(*) FROM `essex-248619.income_demographics.home_tract`
      )
  )

-- LEFT OUTER JOIN cannot be used without a condition that is an equality of fields from both sides of the join.

-------------
SELECT *
FROM `essex-248619.income_demographics.home_tract`
 WHERE AnnIncome >=(
   SELECT AnnIncome 
   FROM `essex-248619.income_demographics.home_tract`
   ORDER BY AnnIncome DESC LIMIT 1 
--    OFFSET (SELECT 0.1 * count(*) from   -- doesnt work
--    `essex-248619.income_demographics.home_tract` )
--  ) 

-----

SELECT
  ARRAY_AGG(STRUCT(queryTime,home_msa, zip, year,tract,AnnIncome, IncomePercentile, tract_geography) ORDER BY AnnIncome DESC LIMIT 10) AS top_ten
FROM `essex-248619.income_demographics.home_tract`
  WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    )
-- gives top 10 annIncome

SELECT 
  * 
  FROM(
    SELECT 
      *,
     @counter= @counter + 1.0  counter
      FROM (
        SELECT @counter=0.0 initvar
         FROM 
        `essex-248619.income_demographics.home_tract` h 
        ORDER BY AnnIncome DESC
      ) X
      WHERE @counter <=(10/100 *@counter)
  )

  --Undeclared query parameters

  