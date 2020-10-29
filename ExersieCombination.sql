----تمرین 1
select distinct cc.customerid from Customers cc
inner join orders oo
on cc.CustomerID=oo.CustomerID
where  cc.customerid not in (select distinct c.customerid  from Customers c 
inner join orders o on c.CustomerID=o.CustomerID
where o.OrderID   in (select orderid from [Order Details] 
group by orderid
having COUNT(OrderID)=1))
---یا
select * from customers where customerid not in 
(select o.customerid from orders
o inner join [Order Details] od on o.OrderID=od.OrderID
group by o.customerid,o.orderid
having count(od.ProductID)=1)
and customerid in (select customerid from orders)



---تمرین 2
select e.lastname ,e.employeeid, c.customerid, COUNT(o.OrderID)as ordercount from employees e 

inner join orders o on e.EmployeeID=o.employeeid
inner join customers c on c.customerid=o.CustomerID
where c.CustomerID in (select top 1 with ties CustomerID
from orders 
group by customerid
order by COUNT(OrderID) asc)
group by e.lastname, e.EmployeeID,c.customerid


---تمرین 3


select  e.lastname,e.employeeid   from employees e 

inner join orders o on e.EmployeeID=o.employeeid
where o.ShipCountry in (select top 3 with ties ShipCountry
from orders 
group by shipcountry
order by COUNT(OrderID) asc)
group by e.LastName, e.EmployeeID