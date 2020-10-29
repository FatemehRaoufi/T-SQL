select * from products---77
select * from Categories---8

select * from Categories,products---616

select * from Categories, Products 
where categories.CategoryID=products.CategoryID

----,ــــــــــــــــ> inner join    where ــــــــ> on

select c.CategoryName, p.ProductName, p.UnitPrice from Categories c 
  inner join Products p
on c.CategoryID=p.CategoryID


/*

select ----- from master inner join detail on master.pk=detail.fk
where
group by
having
order by
*/

---مثال: در مقابل نام هر گروه کالا، تعداد کالای فعال و جمع موجودی آن را بنویسید

Select c.categoryname, count(productid) as productcount,sum(UnitsInStock) as inventorysum   
from  categories c inner join products p
on c.CategoryID=p.CategoryID
where p.Discontinued=0
group by c.CategoryName


---مثال: در مقابل نام هر کارمند تعداد سفارشات او را در سال 1997

select e.EmployeeID, e.FirstName+' '+e.LastName, count(o.OrderID) ordercount
 from Employees e inner join Orders o
on e.EmployeeID=o.EmployeeID
where year(o.OrderDate)=1997
group by e.EmployeeID, e.FirstName+' '+e.LastName


---مثال: در مقابل نام هر کالا فروش دلاری و فروش تعدادی را نمایش دهید
select p.ProductName, sum(od.UnitPrice*od.Quantity) sale, sum(od.Quantity) tedad
from Products p inner join    [Order Details] od
on p.ProductID=od.ProductID
group by p.ProductName

---مثال: در مقابل نام هر شرکت حمل و نقل، به تفکیک سال حمل تعداد سفارشات حمل شده و جمع هزینه حمل

select s.CompanyName, year(o.ShippedDate) as yearsh, count(o.orderid) as ordercount,
 sum(o.Freight) as freightsum
 from orders o inner join Shippers s
on s.ShipperID=o.ShipVia
group by s.CompanyName, year(o.ShippedDate)


select * from orders
where ShippedDate is null

/*self join*/
select * from Employees

---manager    employeeid   master

----employees  reportsto   detail


select e.EmployeeID, e.LastName as employee, m.LastName as manager
 from Employees m inner join Employees e 
 on m.EmployeeID= e.ReportsTo


 ---مثال: در مقابل نام هر مدیر تعداد پرسنل زیر دستش را نمایش دهید

 select m.EmployeeID, m.LastName as manager, count(e.EmployeeID)as employeecount
  from Employees m inner join employees e
 on m.EmployeeID=e.ReportsTo
 group by m.EmployeeID, m.LastName



 ----مثال: در مقابل نام هر کارمند تعداد سفارشات او را ثبت کنم
 select e.LastName, count(o.orderid) as ordercount
  from Employees e inner join Orders o on e.EmployeeID=o.EmployeeID
  group by e.LastName

  ----using designer

SELECT        e.EmployeeID, e.LastName, e.FirstName, COUNT(o.OrderID) AS ordercount, e.Country
FROM            Employees AS e INNER JOIN
                         Orders AS o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.Country
HAVING        (e.Country = N'USA') AND (COUNT(o.OrderID) > 50) OR
                         (e.Country = N'UK')
ORDER BY ordercount

---join 3 tables

--- زنجیری

---مثال  categories t1 - orders t2 [order details] t3

/*
select .... from t1 inner join t2 on t1.pk1=t2.fk2
inner join t3 on t2.pk2=t3.fk3

*/



/*
select---- from t2 inner join t3 on t2.pk2=t3.fk3
inner join t1 on t1.pk1=t2.fk2

*/


/*
select .... from t1 inner join t2 inner join t3 
on t2.pk2=t3.fk3
on t1.pk1=t2.fk2 


*/


/*
select .... from t1,t2,t3
where t1.pk=t2.fk2 and t2.pk2=t3.fk3
*/



----مثال : categories products order details

select od.* from Categories c inner join products p on c.CategoryID=p.CategoryID
inner join [Order Details] od  on p.ProductID=od.ProductID



---مثال: در مقابل نام هر گروه کالا، تعداد کالاهای آن گروه، جمع موجودی انبار و میزان فروش دلاری آن گروه
select c.categoryid,c.CategoryName, count(distinct p.ProductID) as productcount,
 (select sum(UnitsInStock) from Products where CategoryID=c.CategoryID) as inventory,
  sum(od.Quantity*od.UnitPrice) as sale


from Categories c inner join products p on c.CategoryID=p.CategoryID
inner join [Order Details] od  on p.ProductID=od.ProductID

group by c.CategoryName, c.CategoryID


----مثال: در مقابل نام هر کارمند، تعداد سفارشات و جمع هزینه حمل و کل فروش را بنویسید

select  e.EmployeeID, e.LastName, count( distinct o.orderid) as ordercount,
(select sum(freight) from orders where EmployeeID=e.EmployeeID) as freightsum,
sum(Quantity*UnitPrice) as sale

from Employees e inner join Orders o on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on o.OrderID=od.OrderID
group by  e.EmployeeID, e.LastName



---تمرین:
--- در مقابل نام هر کارمند به تفکیک سال ، کل فروش و تعداد سفارشات او را نمایش دهید


---تمرین: میزان فروش کالاهای آمریکایی را نشان دهید


----حالت دوم join
--- 2 master --- 1 detail
----suppliers , categories , products

/*

select * from details d inner join master1 m1 on d.fk1=m1.pk
inner join  master2 m2 on d.fk2=m2.pk
*/

select * from products p 
inner join suppliers s on p.SupplierID=s.SupplierID
inner join Categories c on p.CategoryID=c.CategoryID


---مثال: میزان موجودی کالاهای آمریکایی را به تفکیک نام هر گروه کالا

select c.CategoryName, sum(p.UnitsInStock) from products p 
inner join suppliers s on p.SupplierID=s.SupplierID
inner join Categories c on p.CategoryID=c.CategoryID
where s.Country=N'USA'
group by c.CategoryName


---مثال: گزارشی تهیه کنید از تعداد سفارشات هر کارمند در سال 1997 به تفکیک کشور مشتری

select e.LastName, c.Country, count(OrderID) as ordercount from Orders o 
inner join Employees e on o.EmployeeID=e.EmployeeID
inner join customers c on o.CustomerID=c.CustomerID
where year(o.OrderDate)=1997
group by  e.LastName, c.Country
order by e.LastName


---مثال: کدام کارمندان در سال 1997 به چه کشورهایی فروش نداشتند
select e.LastName, c.Country, isnull(count(OrderID),0) as ordercount from Orders o 
inner join Employees e on o.EmployeeID=e.EmployeeID
inner join customers c on o.CustomerID=c.CustomerID
where year(o.OrderDate)=1997
group by all e.LastName, c.Country
having isnull(count(OrderID),0)=0
 
 ---تمرین: در مقابل نام هر کالا میزان فروش بر حسب دلار ، در ماه سپتامبر 1997 را نشان دهید
 --- کالاهایی را لیست کنید که در آن ماه فروش نداشتند 

 
 ---حالت سوم join
 ----1 master 2detail
 /*
 کارمند      فرزندان       مدارک
 1             4              1
 2             3              2
 3             2              3

 select * from employees e 
 inner join children ch
 on e.employeeid=ch.employeeid
 inner join madarek m on e.employeeid=m.employeeid
 where ch.childrenname='نادر'
 and m.madrakname='دکتری'
 */
 ---مثال: در مقابل نام هر منطقه ، جمع فروش کارمندان آن ناحیه را نشان دهید

 select * from region
 select * from Territories
 select * from EmployeeTerritories
 select * from Employees
 select * from orders
 select * from [Order Details]

 select tt.regionname, sum(tedad*price)
 from
  (select r.RegionDescription as regionname, e.EmployeeID, o.OrderID, od.UnitPrice as price,
  od.Quantity as tedad  from region r
 inner join Territories t on r.RegionID=t.RegionID
 inner join EmployeeTerritories et on t.TerritoryID=et.TerritoryID
 inner join Employees e on e.EmployeeID=et.EmployeeID
 inner join Orders o on e.EmployeeID=o.EmployeeID
 inner join [Order Details] od on o.OrderID=od.OrderID
 group by r.RegionDescription, e.EmployeeID, o.OrderID, od.UnitPrice,od.Quantity
 ) as tt
 group by tt.regionname







