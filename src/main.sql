/* Consider a schema as follows:
Supplier (SID, NAME, SUPPLIER_ZIP)
Parts (PID, PNAME, PTYPE,SID) 
Sale (SHOPID, PID, SALES_DATE, QTY) 
Shop (SHOPID, SHOP_ZIP) 

Use VOLUME = SUM(QTY)

SUPPLIER with SID supplies this part. PTYPE can be Perishable or Imperishable.There can be more than one SHOPID per SHOP_ZIP and more than one Supplier per Supplier_ZIP. More than one supplier can supply a PARTS.
*/

/*
 import data using R console 
> 	write.csv(sales,"/Users/topgyaltsering/Desktop/finalData/sales.csv",row.names=FALSE)
  */

/*  use mysql in mariadb , created database 435final and import data into folder*/

load data local infile '/Users/Desktop/435final/finalData/supplier.csv' into table supplier fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 lines;

desc parts;

/*  1.	Which SHOP_ZIP sold the most volume in the year 2016? */
select shop_zip, sales_date, max(volume)
from (select *, sum(S.qty) as volume
    from shop P join sales S on P.shopid=S.shop_id
    where year(S.sales_date)=2016
    group by P.shop_zip
    order by volume desc)maxvol;

/* 2. Which SHOP_ZIP sold the most volume in Perishable in August 2018? */
select shop_zip, ptypes, sales_date, max(volume)
from (select *, sum(s.qty) as volume
    from shop Sh join sales S on Sh.shopid =s.shop_id join parts P on P.parts_pid=S.pid
    where P.ptypes="perishable" and year(S.sales_date)=1996 and month(S.sales_date)=08
    group by Sh.shop_zip
    order by volume desc)maxvol;

/* 3.	List all the SHOP_ZIPs that sell more Perishable than Imperishable on the first day of the month?*/
select shop_zip, ptypes, sales_date, volume
from (select * , sum(S.qty) as volume
    FROM shop Sh join sales S on Sh.shopid= S.shop_id JOIN parts P on P.parts_pid =S.pid
    where(day(S.sales_date)=01 and P.ptypes="perishable")
    group by shop_zip
    order by sales_date desc)per;

/* 4. List all Suppliers that supplied more Perishable than Imperishable. */
select perishable.*
from (select shop_id, sum(qty) pqty
    from sales as S join parts as P on S.pid =P.parts_pid and P.ptypes="perishable"
    group by shop_id) as Perishable join (select shop_id, sum(qty) pqty
    from sales as S join parts P on S.pid=P.parts_pid and ptypes="imperishable"
    group by shop_id) as imperishable on Perishable.pqty>imperishable.pqty and Perishable.shop_id=imperishable.shop_id;

/* 5. For each supplier_zip list the SHOP_ZIP that sold the minimum volume 
     perishable/imperishable combined */

select supplier_zip, shop_zip, ptypes, min(volume)
from(select *, sum(s.qty) as volume
    from shop Sh join sales S on Sh.shopid =s.shop_id join parts P on P.parts_pid=S.pid join supplier Su on Su.ssid=P.sid
    where ptypes="perishable" or ptypes="imperishable"
    group by sid)d;

/* 6. Find the Part(NAME) that sold the most in 2017 */
select pnames, sales_date, max(maxvol) as " volume(mostSale)"
from (select *, sum(S.qty) as maxvol
    from sales S join shop Sh on Sh.shopid=S.shop_id join parts P on P.parts_pid=S.pid
    where year(S.sales_date)=2017
    group by qty, pnames
    order by maxvol desc)A;


/* 7. Find the part(NAME) whose sales volume in 2016 was higher than the sales volume in 2017? */
select pnames, sales_date, max(maxvol) as " volume(mostSale)"
from (select *, sum(S.qty) as maxvol
    from sales S join shop Sh on Sh.shopid=S.shop_id join parts P on P.parts_pid=S.pid
    where year(S.sales_date)=2016 or year(S.sales_date)=2017
    group by qty,sales_date
    order by maxvol desc)A;

