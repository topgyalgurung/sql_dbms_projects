SELECT
TIMESTAMP_TRUNC(CAST(udate AS TIMESTAMP), MONTH) AS `monthly`,
CAST(date AS TIMESTAMP) AS `date`,
CORR(ot_rev, mf_rent_level) OVER (PARTITION BY shiptozip) AS `ziplevel_revenue_vs_rent_corr`,
PARSE_TIMESTAMP('%F', CONCAT(SUBSTR(CAST(yyyymm AS String),0,4),'-',SUBSTR(CAST(yyyymm AS String),5,2),'-','01')) AS queryTime,
STDDEV(cluster) AS stddev,
CONCAT(CAST(target_lon as STRING), ",", CAST(target_lat as STRING)) AS target_input,
ARRAY_TO_STRING(ARRAY_AGG(CAST(yelp_place_type_count AS STRING)), ",") AS yelp_place_type_count,,
ROUND(100 * employer_cnt/(SUM(employer_cnt) OVER (PARTITION BY home_zip, queryTime)),2) PctIndustryEmployer
SUBSTR(CAST(yyyymm AS STRING),0,4) AS adp_year,
 SHA256(geog) AS `geog_id`,