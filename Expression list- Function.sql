select ProductName  'نام کالا',CategoryID  'آیدی گروه کالا',
UnitPrice  'قیمت هر کالا' from products


select 'نام کالا'= left(productname,10) from products

select left(productname,10) as 'نام کالا' from products


-----تابعی برای محاسبه مالیات
create function fn_calvat (@unitprice money)
returns money
as
begin
return (@unitprice*0.09)
end


----بازخوانی تابع
select ProductID,ProductName,UnitPrice, dbo.fn_calvat(unitprice) as vat
from products
