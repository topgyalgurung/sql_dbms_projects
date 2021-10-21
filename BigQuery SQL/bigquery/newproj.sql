
-- top 10 percent of rf-etl:ESSEX.income home_tract
-- top 10 % of worktract
--
 -- top(10) percent 
 -- RAND() vs ROW_NUMBER() vs DENSE_RANK()
 -- 0.1 * Count (*) as row_num,


-- https://dankleiman.com/2017/11/07/more-efficient-solutions-to-the-top-n-per-group-problem/

 MySQL: LIMIT by a percentage of the amount of records?

-- https://stackoverflow.com/questions/5615172/mysql-limit-by-a-percentage-of-the-amount-of-records

How do I select TOP 5 PERCENT from each group?

-- https://stackoverflow.com/questions/7579916/how-do-i-select-top-5-percent-from-each-group


Select TOP X (or bottom) percent for numeric values in MySQL

-- https://stackoverflow.com/questions/4741239/select-top-x-or-bottom-percent-for-numeric-values-in-mysql

------------------------------------------------

/*  USING NTILE()     */
https://stackoverflow.com/questions/7579916/how-do-i-select-top-5-percent-from-each-group

WITH
sliceddata as(
    SELECT 
    *,
    NTILE(10) OVER(PARTITION BY tract ORDER BY AnnIncome DESC ) AS top_ten_percent
  FROM `essex-248619.income_demographics.home_tract`
  WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    )  
    ORDER BY AnnIncome DESC
)
SELECT 
* FROM
sliceddata s
where top_ten_percent<=1    

-- outputs 3867 rows
-----------------------------------
Top N Percent per Group
https://weblogs.sqlteam.com/jeffs/2008/02/21/top-n-percent-per-group/

-- cant cut off the tract --
WITH
slicedData as(
    SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY tract order by AnnIncome DESC) AS top_ten_percent, -- RANK()
    COUNT(*) over (PARTITION BY zip) as row_count
  FROM `essex-248619.income_demographics.home_tract`
  WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    )  
ORDER BY AnnIncome DESC
)
SELECT 
* FROM
slicedData s
where  top_ten_percent <=(row_count * .10)


--  3686 rows /37783 = 9.76 %
-----------------------------------------

SELECT 
  *
FROM 
(
  SELECT 
    *,
    COUNT(*) OVER (PARTITION BY zip) countTotal,
    ROW_NUMBER() OVER (PARTITION BY zip ORDER BY AnnIncome DESC) top_ten
    FROM `essex-248619.income_demographics.home_tract`
    WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    )  
ORDER BY AnnIncome DESC
) 
WHERE top_ten <=(0.1*countTotal)

-- 3686 rows


SELECT
* 
-- SUM(1) AS COUNT
FROM `essex-248619.income_demographics.home_tract`
    WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    ) 
    AND MOD(CAST(RAND()*10 AS INT64),10)=0

-- OUTPUTS 3824 rows 

SELECT
*
FROM (
SELECT 
*
FROM `essex-248619.income_demographics.home_tract`
    WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    ) 
    ORDER BY AnnIncome DESC
    )
WHERE MOD(CAST(RAND()*10 AS INT64),10)=0

--  3781 rows 
select 
*,
from (
  select 
  *,
  COUNT(*) OVER (PARTITION BY zip,AnnIncome) category_name_count
  COUNT(*) OVER (PARTITION BY AnnIncome) category_count
)
WHERE category_count* 10.0/100>category_count *category_name_count*1.0/100
ORDER BY AnnIncome DESC