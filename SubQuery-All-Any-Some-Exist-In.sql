----sub query 2  ---only after where
---all ---any--- some
----exists
---in

---مثال: گروه کالاهایی را لیست کنید که همه کالاهایشان گرانتر از 8 دلار باشند
use northwind 
go
---using join
select c.CategoryID, c.CategoryName, min(p.UnitPrice) as minprice 
from categories c 
inner join Products p on c.CategoryID=p.CategoryID
group by c.CategoryID, c.CategoryName
having min(p.UnitPrice)>8

--- using sub query 1

select c.CategoryID, c.CategoryName from Categories c
where (select min(unitprice) from products where CategoryID=c.CategoryID)>8


----using sub query type 2
select c.CategoryID, c.CategoryName from Categories c
where 8 < all (select unitprice from products  where CategoryID=c.CategoryID)

/* not correcet
select c.CategoryID, c.CategoryName from Categories c
where all(select unitprice from products  where CategoryID=c.CategoryID)>8
*/

---مثال: کارمندانی را لیست کنید که هرگز تخفیف نداده اند

select e.EmployeeID, e.LastName from Employees e
where 0= all(select od.discount from [Order Details] od inner join Orders o
         on od.OrderID=o.Orderid
		 where o.EmployeeID=e.EmployeeID)


---مثال: کارمندانی را لیست کنسد که هرگز به دانمارک فروش نداشتند
Select e.EmployeeID, e.LastName from Employees e
where 'Denmark' != all (select Country from customers c inner join Orders o
                   on o.CustomerID=c.CustomerID
				   where o.EmployeeID=e.EmployeeID)

---any
---مثال: کارمندانی را لیست کنید که حداقل یکبار به دانمارک فروش داشتند
Select e.EmployeeID, e.LastName from Employees e 
where 'Denmark' = any (select Country from customers c inner join Orders o
                   on o.CustomerID=c.CustomerID
				   where o.EmployeeID=e.EmployeeID)


---مثال: گروه کالاهایی را لیست کنید که حداقل یک کالا گران تر از 80 دلار داشته باشند

select c.CategoryID, c.CategoryName from Categories c
where 80< any (select unitprice from Products where CategoryID=c.CategoryID)



---Exists

/*where exists (select * from ...
where)*/

---مثال: کارمندانی را لیست کنید که به دانمارک فروش داشتند

select e.EmployeeID, e.LastName from Employees e
where exists (select * from Orders o inner join customers c
              on c.customerid= o.customerid
			  where c.country='Denmark'
			  and e.EmployeeID=o.EmployeeID)

---مثال: مشریانی را لیست کنید که هرگز از ما خرید نکرده اند

Select * from customers c
where not exists (select * from Orders where CustomerID=c.CustomerID)

----مثال: گروه کالاهایی را لیست کنید که حداقل یک کالا گرانتر از 80 دلار دارند

Select * from Categories c
where exists (select * from Products
where UnitPrice>80 and CategoryID=c.CategoryID )

---in

/*
where categoryid in (select categoryid....)
*/

---مثال: کارمندانی را لیست کنید که به دانمارک فروش داشتند

Select * from Employees e
where EmployeeID in (select o.employeeid from Orders o inner join customers c
                     on o.CustomerID=c.CustomerID
                     where c.Country='Denmark')


---مثال: گروه کالاهایی را لیست کنید که حداقل یک کالا گرانتر از 80 دلار دارند
select * from Categories c
where CategoryID in (select CategoryID from products
where UnitPrice>80)

---مثال: مشتریانی که هرگز از ما خریداری نکرده اند

Select * from customers c
where c.CustomerID  not in (select distinct customerid from Orders )

---مثال: در کدام تاریخ ها ، کالای شماره 11 پر فروش ترین کالای شرکت از نظر تعداد فروش بوده است

Select o.OrderDate, max(od.Quantity) from orders o 
inner join [Order Details] od on o.OrderID=od.OrderID
where 11=(select ProductID from Products
p where p.ProductID=od.ProductID)

group by o.OrderDate

---تمرین1 : کدام مشتریان هرگز سفارش تک سطری نداشتند
---تمرین2 : کدام کارمندان به بدترین مشتری شرکت فروش داشتند
---تمرین3: کدام کارمندان به 3 تا از بدترین کشورهای مشتری ما خرید داشتند


---مثال: کدام مشتریان شرکت دو روز متوالی از ما خرید داشتند
Select distinct  customerid from Orders o1
where CustomerID in (select customerid from Orders o2
                     where datediff(day,o1.OrderDate, o2.OrderDate)=1)


select * from customers c
where exists ( select * from Orders o1 cross join Orders o2
              where o1.customerid=o2.customerid 
			  and datediff(day,o1.OrderDate, o2.OrderDate)=1
              and o1.customerid=c.customerid)





