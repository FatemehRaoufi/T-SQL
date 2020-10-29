

---مثال: دیتا بیس بسازید و سه جدول داشته باشد
use master
go
create database archive
go
use northwind
go

select * into archive.dbo.customers
from customers
where 1=2

select * into archive.dbo.orders
from orders
where 1=2

select * into archive.dbo.orderdetails
from [Order Details]
where 1=2


insert into archive.dbo.customers
select * from northwind.dbo.customers c
where c.CustomerID not in (select customerid from northwind.dbo.Orders)

delete from northwind.dbo.customers 
where not exists (select * from northwind.dbo.Orders
where Orders.CustomerID=Customers.CustomerID )


select * from northwind.dbo.customers 


alter table [order details]
drop constraint fk_order_details_orders

truncate table orders
truncate table [order details]


select * from orders


---output(delete update insert)

insert into products
(productname, categoryid)
output inserted.*
values ('xxxxx',1),
('yyyy',2)


delete from products
output deleted.*
where productid>77


update Products
set UnitPrice=UnitPrice*1.1
output deleted.ProductID, deleted.productname,
       deleted.UnitPrice,
	   inserted.productid, inserted.ProductName,
	   inserted.UnitPrice
where ProductID<5


create table pricechangehistory
(productid int, productname nvarchar(50),
oldprice money, newprice money, changetime datetime)

update Products
set UnitPrice=UnitPrice*1.1
output deleted.ProductID, deleted.productname,
       deleted.UnitPrice as oldprice,
	   inserted.UnitPrice as newprice, getdate()
	   into pricechangehistory
where ProductID>70

select * from pricechangehistory
