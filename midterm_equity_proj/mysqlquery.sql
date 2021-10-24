CREATE TABLE IF NOT EXISTS equitymarket_demo;
USE equitymarket_demo;

CREATE TABLE customer(
	clid INT PRIMARY KEY,
    cust VARCHAR(3),
    symbol VARCHAR(5),
    side VARCHAR(4),
    oQty INT,
    fillQty INT,
    fillPx DOUBLE,
    execid INT
    );
    
RENAME TABLE customer TO fills;

-- SHOW GLOBAL VARIABLES LIKE 'local_infile';
-- SET GLOBAL local_infile=1;  -- or one
-- SET GLOBAL AllowLoadLocalInfile=true;

LOAD DATA LOCAL INFILE '/Users/topgyal/desktop/sql_dbms_projects/midterm_equity_proj/file' 
INTO TABLE fills fields terminated by ',';

DESC fills;
SELECT * FROM fills;
SELECT count(clid) from fills;

-- customer order if filled and avg price at which filled
SELECT clid,oQty,sum(fillQty) AS `Amount_filled`, sum(fillQty * fillPx)/oQty AS `AvgPrice` FROM fills GROUP BY clid HAVING SUM(fillQty)>=oQty;

-- all orders which not been filled SUM(partial_fill_qty) < OrderQty
SELECT clid,oQty,sum(fillQty) AS `Amount_filled`, sum(fillQty * fillPx)/oQty AS `AvgPrice` FROM fills GROUP BY clid HAVING SUM(fillQty)<oQty;

