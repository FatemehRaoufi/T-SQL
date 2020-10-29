


----------------------

select p.ProductName, sum(od.UnitPrice*od.Quantity)as sale from products p
 inner join [Order Details] od on p.ProductID=od.ProductID
 inner join Orders o on o.OrderID=od.OrderID
 where year(o.OrderDate)=1997 and month(o.OrderDate)=9
 group by p.ProductName


 select p.ProductName, isnull(sum(od.UnitPrice*od.Quantity),0)as sale from products p
 inner join [Order Details] od on p.ProductID=od.ProductID
 inner join Orders o on o.OrderID=od.OrderID
 where year(o.OrderDate)=1997 and month(o.OrderDate)=9
 group by All p.ProductName
 having isnull(sum(od.UnitPrice*od.Quantity),0)=0

-------


select e.EmployeeID, e.LastName, year(o.OrderDate) as orderyear,
 count(distinct o.orderid) as ordercount,
sum(Quantity*unitprice)  as sale
from Employees e inner join Orders o on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on o.OrderID=od.OrderID
group by e.EmployeeID, e.LastName, year(o.OrderDate) 
order by employeeid
