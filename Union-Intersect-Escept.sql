 ----
/*
Union
Intersect
except
*/


---مثال: از چه کشورهایی مشتری و تامین کننده داریم
use northwind 
go
select country from customers
union
select country from Suppliers

select country from customers
union all
select country from Suppliers


---مثال: از چه کشورهایی هم مشتری و هم تامین کننده داریم

select country from customers
intersect
select country from Suppliers


---مثال: کدام کشورها مشتری داریم ولی تامین کننده نداریم
select country from customers
except
select country from Suppliers

---مثال:کدام کشورها تامین کننده داریم ولی مشتری نداریم
select country from Suppliers
except
select country from customers

---مثال: کدام کالاها هم در ماه 9 و هم در ماه 10 سال 1997 فروش رفته اند 

select p.ProductID, p.ProductName
 from products p inner join [Order Details] od
on p.ProductID=od.ProductID
inner join Orders o on o.OrderID=od.OrderID
where year(o.OrderDate)=1997 and MONTH(o.OrderDate)=9
intersect
select p.ProductID, p.ProductName
 from products p inner join [Order Details] od
on p.ProductID=od.ProductID
inner join Orders o on o.OrderID=od.OrderID
where year(o.OrderDate)=1997 and MONTH(o.OrderDate)=10



select distinct p.ProductID, p.ProductName
 from products p inner join [Order Details] od
on p.ProductID=od.ProductID
inner join Orders o on o.OrderID=od.OrderID
where year(o.OrderDate)=1997 and MONTH(o.OrderDate)=9
and  p.productid  in (
select p.ProductID
 from products p inner join [Order Details] od
on p.ProductID=od.ProductID
inner join Orders o on o.OrderID=od.OrderID
where year(o.OrderDate)=1997 and MONTH(o.OrderDate)=10)


----into


select * 
into cat1 
from products
where CategoryID=1

select * from products
union all
select * from cat1--- 12+77=89

select * from products
union 
select * from cat1---77+2=79

select * from products
intersect 
select * from cat1---10

select * from products
except 
select * from cat1---67

select * from cat1
except 
select * from products--2

---مثال: در مقابل نام هر کشور تعداد کارمندها،تعداد مشتری و تعداد تامین کننده

--select country, employeecount, customercount, suppliercount

select country, sum(employeecount) employeecount, sum(customercount)customercount,sum(suppliercount)suppliercount
 from
(select country, count(EmployeeID)as employeecount, 0 as customercount, 0 as suppliercount

 from employees
  group by country
 union 
 select country, 0as employeecount, count(customerid) as customercount, 0 as suppliercount

 from customers
 group by country
 union 
 select country, 0as employeecount, 0 as customercount, count(SupplierID) as suppliercount

 from suppliers
  group by country
 ) tt
  group by country


  create view vw_allpeople as
  select convert(nchar(5), EmployeeID) as id, LastName, Country from employees
  union
  select CustomerID as id, CompanyName, Country from customers
  union 
  select convert(nchar(5),supplierid) as id, CompanyName, country from suppliers


  select * from vw_allpeople


----pivot

--- در مقابل نام هر کارمند، تعداد سفارشات او در سه سال 1996، 1997 و 1998 را نشان دهید

select * from 
             (select e.EmployeeID, e.LastName,year(o.OrderDate) oy, o.OrderID
			  from employees e 
			  inner join Orders o on e.EmployeeID=o.EmployeeID) as t
pivot(count(t.orderid) for oy in ([1996], [1997], [1998])) as pvt


/*
pivot(عبارتی که میخواهیم تجمیع شود for سر ستون تجمیع in (عبارت های سر ستون داخل کروشه))
*/



select *, [1996]+[1997]+[1998] as total from 
             (select e.EmployeeID, e.LastName,year(o.OrderDate) oy, o.OrderID
			  from employees e 
			  inner join Orders o on e.EmployeeID=o.EmployeeID) as t
pivot(count(t.orderid) for oy in ([1996], [1997], [1998])) as pvt


---مثال: در مقابل نام هر کارمند تعداد سفارشات به چهار کشور آمریکا،انگلیس، آلمان و فرانسه را بنویسید

select *, [USA]+[Uk]+[germany]+[France] as total from 
         (select e.EmployeeID, e.LastName, c.Country, o.OrderID
		 from 
		 Employees e inner join orders o on e.EmployeeID=o.EmployeeID
		 inner join customers c on c.CustomerID=o.CustomerID) as t
pivot(count(t.orderid) for country in ([USA], [UK], [Germany],[France])) as pvt



  create view vw_allpeople as
  select convert(nchar(5), EmployeeID) as id, LastName, Country, 'E' as origin from employees
  union
  select CustomerID as id, CompanyName, Country, 'C' as Origin from customers
  union 
  select convert(nchar(5),supplierid) as id, CompanyName, country, 'S' as origin from suppliers

  select * from vw_allpeople
---مثال مدیر با استفاده از pivot

select *, [S]+[E]+[C] as total from 
           (select country, origin, id from vw_allpeople) as t
pivot (count(id) for origin in ([S],[E],[C])) as pvt
