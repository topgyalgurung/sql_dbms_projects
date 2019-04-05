


> set.seed(43)
> zip<-c('07733','11021','26505','60601','95070','55401','33603','07764','68154','45277','35243','85226','85308','85254','92821','94568','94010')
> supplier_zip<-sample(zip,length(21:33),replace=T)
> pid<-sample(201:277,1000,replace=T)
> supplier<-data.frame(sid=21:33,name=paste('S',21:33,sep=""),supplier_zip)
> parts_pid<-201:277
> pnames<-paste('P',201:277,sep="")
> ptypes<-sample(c('perishable','imperishable'),length(parts_pid),replace=T)
> parts_sid<-21:33
> parts<-data.frame(parts_pid,pnames,ptypes,sid=sample(parts_sid,length(parts_pid),replace=T))
> supplier_name<-paste('S0',21:33,sep="")
> supplier_zip<-sample(zip,length(21:33),replace=T)
> 
> sales_shopid<-sample(1:17,1000,replace=T)
> qty<-sample(1:7,1000,replace=TRUE)
> sales_dates<-sample(seq(as.Date('1999/01/01'), as.Date('2000/01/01'), by="day"), 1000,replace=T)
> sales<-data.frame(shopid=sales_shopid,pid=pid,sales_date=sales_dates,qty=qty)
> 
> 
> shop<-data.frame(shopid=sample(1:17,17),shop_zip=zip)
> # dim() Retrieve or set the dimension of an object
> # sqldf()package can be used to run sql queries on R data frames
> #head() Returns the first or last parts of a vector, matrix, table, data frame or function
> require(sqldf)
> sqldf("select * from sales")
> sqldf("select * from shop")
> sqldf("select * from supplier")
> sqldf("select * from parts")
> attributes(sales)
> sqldf("select shop_zip from shop p  ")

> sqldf("select *,SUM(S.QTY) as volume from shop P join sales S on P.shopid=S.shopid where (S.sales_date)=2016 group by S.shopid order by volume desc ")
