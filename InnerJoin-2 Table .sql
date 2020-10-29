select p.ProductName, sum(od.UnitPrice*od.Quantity) as sale
from 
Suppliers s inner join products p on s.SupplierID=p.SupplierID
inner join [Order Details] od on p.ProductID=od.ProductID
where s.Country=N'USA'
group by p.ProductName