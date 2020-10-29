select customerid, companyname, country, city 
into usacustomers
from customers
where Country=N'USA'
order by city


select * from [dbo].[usacustomers]

/*
---insert

insert values
insert result
*/


/*
insert [into] <table name>

[(<column list>)]

values(<value list>)
,(<value list>)
,(<value list>)
,...





*/


insert into usacustomers 
(customerid, CompanyName,Country,City)
values('Hcomp','Hoshmandan','Iran','Tehran'),
('Hcom1', 'Hoshmandan1','Iran','Esfahan')


select * from usacustomers 


set identity_insert products on
insert into Products
( productid,ProductName,UnitPrice)
values(123,'aaaa',50)



insert into Products
( ProductName,UnitPrice)
values('bbbbbb',50)
if @@ERROR>0
begin
DBCC checkident('products', Reseed,1)
DBCC checkident('products',Reseed)
End


---insert result
/*
insert [into] <table name>
[(<columnlist>)]
select <columnlist>
from
where
group by
having
order by

*/

/*
مثال: دستوری بنویسید که مشتریانی فرانسوی را داخل یک جدول ببرد
و سپس مشتریان کانادایی را به آن اضافه کنید
*/


select * into newcustomer
from customers
where country='France'---11


insert into newcustomer
select * from customers
where country='Canada'---3

----using design
INSERT INTO newcustomer
                         (CustomerID, CompanyName, Country, City)
VALUES        (N'HoshC', N'hoshmandan', N'Iran', N'tehran')

select * from newcustomer


---update
/*
update <table name>
set <column1>=<exp1>
, <column2>=<exp2>
[where <boolean expr>]

*/

---مثال: دستوری بنویسید که موجودی کالا و موجودی در راه رکوردهای غیر فعال را صفر کند

update  products
set
UnitsInStock=0,
       UnitsOnOrder=0
where Discontinued=1


select * from Products
where Discontinued=1

---مثال: دستوری بنویسید که قیمت کالاها را 7 دلار ارزانتر کند

update products
set UnitPrice=UnitPrice-7


---مثال: در صورتی که کالا از 7 دلار گرانتر بود قیمت آن را منهای 7 دلار کند

update Products
set UnitPrice= 
 case when UnitPrice>=7
 then UnitPrice-7 
 else UnitPrice
 end

---مثال: کالای گروه کالای 1 ، 10 درصد گران شود و گروه کالای 2 ، 20 درصد گران شود

update Products
set UnitPrice=(case
               when CategoryID=1 then UnitPrice*1.1
			   when CategoryID=2 then UnitPrice* 1.2
			   else UnitPrice
			   end)

/*
مثال: دستوری بنویسید که ستون جدیدی  از جنس پولی به جدول کارمندان
اضافه کندو سپس دستوری بنویسید که یک درصد از فروش خالص هر کارمند
را در سال 1997 به عنوان پاداش در این ستون ذخیره کند
*/

alter table employees
add bonus money not null default(0)
go

update employees 
set bonus= 0.01 *(select 
                 sum(od.Quantity*od.UnitPrice- 
				 (od.Quantity*od.UnitPrice*od.Discount)) 
                 from [Order Details] od
                 inner join Orders o on o.OrderID=od.OrderID
				 where employees.EmployeeID=o.EmployeeID
				 and YEAR(o.OrderDate)='1997')
				 
select * from employees


/*
مثال: به جدول کارمندان ستونی اضافه کنید از جنس 
int
 و سپس دستوری بنویسید که تعداد سفارشات هر کارمند را در این ستون وارد کند

*/

alter table employees
add ordercount int not null default 0
go

update Employees
set ordercount= (select count(orderid) from Orders o
                 where o.employeeid=employees.employeeid)

---تمرین : پاداش فقط به کارمندانی تعلق بگیرد که در سال 1997
--- بیش از 40 فاکتور فروش داشتند
