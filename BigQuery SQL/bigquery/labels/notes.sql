-- just gives row number 
SELECT ROW_NUMBER () OVER (partition by cast(AnnIncome as int64))
    FROM `essex-248619.income_demographics.home_tract`

-- top count 
SELECT
  APPROX_TOP_COUNT(IncomePercentile, 10)
  FROM
    `essex-248619.income_demographics.home_tract`
  WHERE
    home_msa IN( 'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA' )
--
--------
SET @amount=(SELECT COUNT(*) FROM `essex-248619.income_demographics.home_tract`)/10

#legacy sql
SELECT
TOP(IncomePercentile,20) AS top_ten,
COUNT(*) AS cnt
FROM [essex-248619.income_demographics.home_tract]
--   WHERE home_msa in(
--     'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
--     )
  ------------
  SELECT 
    top_ten_percent
    FROM(
        SELECT
            row_num() OVER (PARTITION BY AnnIncome ORDER BY AnnIncome DESC ) AS top_ten_percent
            FROM `essex-248619.income_demographics.home_tract`
  WHERE home_msa in(
    'SAN FRANCISCO-OAKLAND-HAYWARD, CA METROPOLITAN STATISTICAL AREA'
    ) 
)
