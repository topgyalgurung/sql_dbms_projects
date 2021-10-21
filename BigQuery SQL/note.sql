
                                      ---    BigQuery GIS    ----

-- transform data
ST_MakeValid
SAFE
WHERE ST_DWithin(geo, ST_GeogPoint(longitude,latitude),100)
select regexp_replace(wkt,'],',']') 

SELECT ST_GeogPoint(longitude,latitude) AS WKT

-- ST_AsGeoJson convert geojson to strings

--The issue is that in multi-polygon arrays the field actually refers to two lists. So it looks like:
--[ [lat, long], [lat, long], [lat, long] ], [ [ lat, long], [lat, long] ]. We need to identify these breaks and parse them into their own separate line.

--[[[lat,long],[lat,long],[lat,long]]],[[[lat,long],[lat,long]]]

--   | [lat,long],[lat,long],[lat,long]  |
--   | [lat,long],[lat,long],[lat,long]  |

-- These can be identified by "]]],[[[" in the parsed substring. Your program should be able to identify these cases, 
--and then separate them into two different rows (as opposed to one row). The two resulting rows should have identical data for everything except this geography substring.

STRING_SPLIT ( string , separator )
STRING_SPLIT(string, '],')   //string=REPLACE(..) 

--
JSON_EXTRACT(json_string_expr, json_path_string_literal), which returns JSON values as STRINGs, '$ .coordinates'-  path
WKT (well known text), ST_ASGEOJSON() - to export data in GeoJSON format
SUBSTRING ( expression ,start , length )\
/*      expression= JSON_EXTRACT(ST_ASGEOJSON(c.WKT),'$.coordinates'),
        start= 2, 
        length =LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
         '$.coordinates')) - 2)
  */
                  
 CROSS JOIN UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(REPLACE(SUBSTR(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
           '$.coordinates'), 2, LENGTH(JSON_EXTRACT(ST_ASGEOJSON(c.WKT),
                 '$.coordinates')) - 2),'[[[','[['),']]]',']]'),']],[[','],['),'],[',']]],[['),'],')) AS `geography`

/*   rf-research:zillow.mf_pred_bymsa_2018 */
