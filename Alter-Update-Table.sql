alter table employees
add bonus money not null default(0)
go

update employees 
set bonus= isnull((select  count(orderid) 
                 from  Orders o
				 where employees.EmployeeID=o.EmployeeID
				 and YEAR(o.OrderDate)='1997'
				 having count (orderid)>40
				 ),0)
