---outer join
---left outer join
----right outer join
---full outer join

select e.EmployeeID, e.LastName, isnull(count(orderid),0) as ordercount
 from employees e left join orders o
 on e.EmployeeID=o.EmployeeID
 group by e.EmployeeID, e.LastName

select * from employees e full join orders o on e.EmployeeID=o.EmployeeID



--- سوالی که برای مدیر عامل حل کردیم 
 select m.EmployeeID, m.LastName as manager, count(e.EmployeeID)as employeecount
  from Employees m left join employees e
 on m.EmployeeID=e.ReportsTo
 group by m.EmployeeID, m.LastName


 ----مثال: در مقابل نام هر کارمند فروش ریالی 
 select e.employeeid, e.lastname, sum(od.UnitPrice*od.Quantity) as sale
  from Employees e left join Orders o on e.EmployeeID=o.EmployeeID
 left join [Order Details] od on o.OrderID=od.OrderID
 group by e.employeeid, e.lastname

 /*sub query
 
 1) scaler value (one column and one row)
 
 2) column of values (one column and many rows)
 */

 ---مثال: در مقابل نام هر کارمند تعداد سفارشات شرکت را نشان دهید

 select employeeid, lastname ,
  (select count(orderid) from  orders
 )
 from employees

 ---
  select employeeid, lastname ,
  (select count(orderid) from  orders
  where EmployeeID=employees.EmployeeID
 )
 from employees


 --- مثال: در مقابل نام هر کارمند تعداد سفارشاتش و درصد آن از کل سفارشات شرکت را بنویسید

 select e.EmployeeID, e.LastName, count(o.OrderID) as ordercount
 , convert(decimal (4,1),100.0*count(orderid)/(select count(orderid) from  orders)) as darsad
 from Employees e
 left join Orders o on e.EmployeeID=o.EmployeeID
 group by e.EmployeeID, e.LastName

 ---مثال: در مقابل نام هر گروه کالا، شماره، نام و قیمت گرانترین کالای آن گروه را نمایش دهید
 select CategoryID, CategoryName, 
 (select top 1 convert(nvarchar(5),productid)+' '+ productname+ ' '+
 convert(nvarchar(10), unitprice) from products
 where CategoryID=Categories.CategoryID 
 order by UnitPrice desc)
   from Categories



    select CategoryID, CategoryName, 
 (select top 1 productid from products
 where CategoryID=Categories.CategoryID 
 order by UnitPrice desc) as productid,
  (select top 1 productname from products
 where CategoryID=Categories.CategoryID 
 order by UnitPrice desc) as productname,
  (select top 1 unitprice from products
 where CategoryID=Categories.CategoryID 
 order by UnitPrice desc) as price
   from Categories

  /*cross tab query*/
  ---مثال: در مقابل نام هر کارمند تعداد سفارشات او در سه سال 1996 و 1997 و 1998 و جمع این سه سال در یک ستون بیاید

  select e.EmployeeID, e.LastName,
  (select count(orderid) from orders
  where EmployeeID=e.EmployeeID and year(OrderDate)=1996) as '1996'
  ,
    (select count(orderid) from orders
  where EmployeeID=e.EmployeeID and year(OrderDate)=1997) as '1997'
  ,
  (select count(orderid) from orders
  where EmployeeID=e.EmployeeID and year(OrderDate)=1998) as '1998'
  ,
   (select count(orderid) from orders
  where EmployeeID=e.EmployeeID and year(OrderDate) in (1996,1997,1998)) as 'total'
   from employees e



   --   مثال: در مقابل نام هر گروه کالا تعداد کالاهای فعال، جمع موجودی کالای فعال
   ----  تعداد کالاهای غیر فعال و جمع موجودی کالاهای غیر فعال
   ---- تعداد کل کالاها و جمع موجودی کل

   Select c.CategoryID, CategoryName,
   (select count(productid) from Products
   where CategoryID=c.CategoryID and Discontinued=0) as countfaal
   ,

   (select sum(unitsinstock) from products
   where CategoryID=c.CategoryID and Discontinued=0) as faalinventory
   ,
   (select count(productid) from Products
   where CategoryID=c.CategoryID and Discontinued=1) as countnofaal
   ,

   (select sum(unitsinstock) from products
   where CategoryID=c.CategoryID and Discontinued=1) as nofaalinventory
   ,
    (select count(productid) from Products
   where CategoryID=c.CategoryID ) as Totalcount
   ,

   (select sum(unitsinstock) from products
   where CategoryID=c.CategoryID ) as Totalinventory

   from Categories c
   
  ---مثال: گرانترین کالای شرکت کدام است

  Select * from products
  where UnitPrice=(select max(unitprice) from products)


  --- کدام کالای شرکت گرانتر از متوسط بهای شرکت هست

  Select * from products
  where UnitPrice> (select avg(unitprice) from products)


  ---کالاهایی را لیست کنید که از متوسط بهای کالاهای هم نوع خود گرانتر هستند

  select * from products p
  where UnitPrice> (select avg(UnitPrice) from products
  where CategoryID=p.CategoryID)


 