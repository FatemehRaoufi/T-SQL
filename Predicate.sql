/*

1) default (All)
2) Distinct
3) Top
*/


select  ProductID, ProductName from products
where unitprice>50


select distinct CategoryID from products

select * from Categories

select distinct CategoryID, productid from products


---- در سال 1996 شرکت چند روز کاری داشته
select distinct orderdate from orders
where year(OrderDate)=1996


---- کدام گروه کالاها، کالای غیر فعال دارند
select distinct categoryid 
from products
where Discontinued=1


----
select top 5  unitprice,  productname from products
order by unitprice  Asc



select top 5  unitprice,  productname from products
order by unitprice  Desc


select top 12  unitprice,  productname from products
order by unitprice  Asc


select top 12 with ties unitprice,  productname,  UnitsInStock from products
order by unitprice  Asc

select top 12  unitprice,  productname, UnitsInStock from products
order by unitprice  Asc, UnitsInStock desc


select top 10 percent productname from products order by unitprice desc


