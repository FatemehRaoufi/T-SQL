/* view*/


create view v_activecustomers as
select * from customers
where customerid in (select CustomerID from orders 
where DATEDIFF(day, orderdate, getdate())<180)


/* derived table */
select * from (
select customerid, companyname, country, city from customers
where country= N'USA') as vsc


---مثال: دستوری بنویسید که پنجمین رکورد ارزان شرکت را نمایش دهد

select  top 1 * from(select top 5 * from products order by UnitPrice asc) as fifth
order by unitprice desc


/*CTE common table expression */




/*
with <cte name>
as
(select .... from .....)
<sql statement which uses the CTE>
*/

with usa
as
(select * from customers where Country=N'USA')
select * from usa order by city asc
;


with fifth
as
(select top 5 * from Products order by UnitPrice asc)

select top 1 * from fifth order by unitprice desc



with topfifth 
as
(select top 5 * from Products order by UnitPrice desc)
select top 1 * from topfifth order by UnitPrice asc



---table valued function TVF

---مثال: نام کشور را دریافت و لیست مشتریان آن کشور را برگرداند

create function
fn_customerlist (@country nvarchar(40))
returns table
as
return (select * from customers where country=@country)
go


select * from fn_customerlist(N'USA')


---

create function fn_noimnkala(@n int)
returns table
as
return (select top 1 * from
(select top (@n) * from products order by unitprice asc)as noimn
order by unitprice desc)


select * from fn_noimnkala(20)


----synonym

use northwind
go
create synonym p for dbo.products
go

select * from p
;

create schema sales
go
alter schema sales
transfer dbo.customers

select * from dbo.customers

create synonym dbo.customers
for sales.customers




----where
/* is (not)
(not) between
(not)  in
(not)  like

Not (p^Q)  ~p U ~Q
Not (p U Q) ~p ^ ~Q
*/

----مثال: کالاهایی که قیمت بزرگتر از 10
select * from products
where unitprice>10

----قیمت بین 10 تا 20 دلار

select * from products
where UnitPrice>10 and unitprice <20


---قیمت بین 10 تا 20 نباشد
select * from products where unitprice<=10 or unitprice>=20

select * from products where not (unitprice>10 and unitprice<20)

select * from products where not (unitprice>10) or not (unitprice<20)

--- categoryid=2 and unitprice<30
select * from products where categoryid=2 and unitprice<30
select * from products where not (categoryid=2 or unitprice<30)
select * from products where not categoryid=2 and not UnitPrice<30


---- categoryid 1 or 2  و  unitprice>30
select * from products where (categoryid=1 or categoryid=2) and UnitPrice>30



----is
select * from customers where region is null

select * from customers where region is not null


---between
select * from Products where unitprice between 10 and 20

----IN 

select * from products where categoryid=1 or categoryid=2 or categoryid=3
or categoryid=4

select * from products where categoryid in (1,2,3,4)


select * from customers where country in (N'USA', N'UK', 'Germany','France' )



---like 
select * from products where left(productname,1)=N's'

select * from products where productname like 'S%'

select * from products where productname like N'%es'

select * from products where productname like N'%es%'
select * from products where productname like N'20[%]%'


---- group by 

/*
count (expression)
sum()
avg()
min()
max()
var()
varp()
stdev()



*/


select count(customerid) from customers

select count(productid) from products

select count(*) from products


---مثال: تعداد سفارشاتی که کارمند شماره 1 در سال 1996 ثبت کرده است
select count(*) from orders where EmployeeID=1 and year(orderdate)='1996'


---مثال: کل فروش شرکت چند کارتن و چند دلار است
select sum(UnitPrice*Quantity), sum(Quantity) from [Order Details]


----قیمت ارزان ترین و گرانترین کالای شرکت  چند
select min(unitprice), max(unitprice) from products


select DATEDIFF(year, max(birthdate), getdate()), DATEDIFF(year, min(birthdate), getdate())
from employees


---مثال: متوسط موجودی کالاهای فعال شرکت چند کارتن است
select * from products 

select avg( unitsinstock) from products where Discontinued=0---43

select sum(unitsinstock), count(unitsinstock) from products where Discontinued=0
----43.74

select avg(1.0*unitsinstock) from products where Discontinued=0


