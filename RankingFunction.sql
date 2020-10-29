----ranking function
/*
row_number() over ([partition by <expression list>]
order by <expression list>)

rank()
dense_rank()
ntile(<n>)

*/

---مثال: مشتریان را لیست کنید و شماره ترتیب بگذارید
use northwind
go
select ROW_NUMBER() over (order by customerid) as radif
, * from customers


select ROW_NUMBER() over (order by customerid desc) as radif
, * from customers


select ROW_NUMBER() over (partition by country
order by customerid asc) as radif
, * from customers

---مثال: در مقابل نام هر کالا رتبه کالا را از نظر قیمت نشان دهید
select productid, productname, CategoryID, UnitPrice,
rank()over(order by unitprice desc) as rankkala
 from Products


---مثال بالا روی گروه کالاها
select productid, productname, CategoryID, UnitPrice,
rank()over(partition by categoryid order by unitprice desc) as rankkala
 from Products


 select productid, productname, CategoryID, UnitPrice,
dense_rank()over(order by unitprice desc) as rankkala
 from Products

 ---مثال: در مقابل نام هر کامند تعداد سفارشات را ثبت کنبد و رتبه ایشان را نیز از نظر تعداد سفارش مشخص کنید


 select e.EmployeeID,e.LastName,count(o.OrderID)as ordercount,
 rank() over(order by count(o.orderid) desc) as orderrank
 
  from Employees e
inner join Orders o
on e.EmployeeID=o.EmployeeID
group by e.EmployeeID,e.LastName


---مثال: گرانترین کالای هر گروه کالا را لیست کنید

select * from 
   ( select productid, productname, categoryid, unitprice,
   rank()over(partition by categoryid order by unitprice desc)as pricerank
   from products
    )as t
where pricerank=1;




with t
as 
(select productid, productname, categoryid, unitprice,
   rank()over(partition by categoryid order by unitprice desc)as pricerank
   from products)
select * from t
where pricerank=1




---ntile<n>

select *, ntile(3) over(order by unitprice desc) as nt
from products

----grouping sets

select employeeid, customerid, count(orderid) as ordercount from orders
group by grouping sets((employeeid,customerid),
(employeeid),(customerid),())

---Index

select * from orders
where employeeid=1
and shipcountry=N'USA'




create index ix_employeeid on dbo.orders(employeeid)
create index ix_shipcountry on dbo.orders(shipcountry)
drop index ix_employeeid on dbo.orders
drop index ix_shipcountry on dbo.orders

create index ix_shipcountry_employeeid on dbo.orders 
(employeeid,shipcountry)






