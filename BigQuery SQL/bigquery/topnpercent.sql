
SELECT 
*
FROM `essex-248619.income_demographics.home_tract`
WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    ) 
ORDER BY AnnIncome DESC
)

-------------------------------------------------

WITH
  home_tract AS (
  SELECT
    *
  FROM
    `essex-248619.income_demographics.home_tract` )
SELECT
  DISTINCT home_tract,
  --industry,
  h.*
FROM
  `essex-248619.income_demographics.home_tract_naics2` hn
INNER JOIN
  home_tract h
ON
  h.tract=hn.home_tract
WHERE
  IncomePercentile >=90
ORDER BY
  IncomePercentile DESC

  -------------------------------------------------------------------

WITH work_tract_data AS 
(
SELECT
*
FROM 
 `essex-248619.income_demographics.work_tract` 
)
 SELECT 
 distinct work_tract, 
 -- industry
   w.* 
  FROM 
  `essex-248619.income_demographics.work_tract_naics2` wn
  INNER JOIN 
  workt_tract_data w
  ON w.tract=wn.work_tract
  WHERE IncomePercentile >=90
  ORDER BY IncomePercentile DESC 

  ----------------------------------------------------------------------
WITH home_tract_naics2 AS 
(
SELECT
*
FROM 
  `essex-248619.income_demographics.home_tract_naics2` 
)
 SELECT 
  distinct tract, 
   hn.* 
  FROM 
  `essex-248619.income_demographics.home_tract` h
  INNER JOIN 
  home_tract_naics2 hn
  ON hn.home_tract=h.tract
  WHERE IncomePercentile >=90

  --------------------
  WITH work_tract_naics2 AS 
(
SELECT
*
FROM 
  `essex-248619.income_demographics.work_tract_naics2` 
)
 SELECT 
  distinct tract, 
  wn.* 
  FROM 
  `essex-248619.income_demographics.home_tract` w
  INNER JOIN 
  work_tract_naics2 wn
  ON wn.work_tract=w.tract
  WHERE IncomePercentile >=90

  --------
  WITH work_tract_naics2 AS 
(
SELECT
*
FROM 
  `essex-248619.income_demographics.work_tract_naics2` 
)
 SELECT 
  distinct tract, 
  IncomePercentile, AnnIncome,
  wn.* 
  FROM 
  `essex-248619.income_demographics.home_tract` w
  INNER JOIN 
  work_tract_naics2 wn
  ON wn.work_tract=w.tract
  WHERE IncomePercentile >=90
 

 -------  --------------------  --------------------  --------------------
   --------------------  --------------------  --------------------
 -- new -- home tract naics2
 WITH
  home_tract_data AS (
  SELECT
    *
  FROM
    `essex-248619.income_demographics.home_tract` )
SELECT
  DISTINCT     
  h.*,          -- tract included
  industry
FROM
  `essex-248619.income_demographics.home_tract_naics2` hn
INNER JOIN
  home_tract_data h
ON
  h.tract=hn.home_tract
WHERE
  IncomePercentile >=90
  --AND h.queryTime='2018-12-01'
ORDER BY
  IncomePercentile DESC
-------  --------------------  --------------------  --------------------
   --------------------  --------------------  --------------------
-- work tract naics 2 
    WITH
  work_tract_data AS (
  SELECT
    *
  FROM
    `essex-248619.income_demographics.work_tract` )
SELECT
  DISTINCT     
  w.*,          -- tract included
  industry
FROM
 `essex-248619.income_demographics.work_tract_naics2` wn
INNER JOIN
  work_tract_data w
ON
  w.tract=wn.work_tract
WHERE
  IncomePercentile >=90
  --AND h.queryTime='2018-12-01'
ORDER BY
  IncomePercentile DESC

---------------------

WITH
  home_tract_data AS (
  SELECT
    *
  FROM
    `essex-248619.income_demographics.home_tract_naics2` )
SELECT
  DISTINCT
  hn.*         -- tract included
  --industry
FROM
  `essex-248619.income_demographics.home_tract` h
INNER JOIN
  home_tract_data hn
ON
  h.tract=hn.home_tract
WHERE
  IncomePercentile >=90
  --AND h.queryTime='2018-12-01'
