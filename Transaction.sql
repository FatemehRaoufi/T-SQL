----transaction


/*
begin tran
.
.
.
commit tran, rollback tran
*/


---

begin tran
select @@trancount
update Products
set UnitPrice=0

delete from [Order Details]
update customers 
set CompanyName='a'

rollback tran


select * from [Order Details]