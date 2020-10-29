-----case when

/*
case
when <boolean exp1> then <result1>
when <boolean exp2> then <result2>
.
.
.
[else <resultelse>]
end*/

---  مثال: کمتر از 10 دلار ارزان، بین 10 تا 50 متوسط و بیشتر از 50 گران

select ProductID, ProductName, UnitPrice, 
case
when UnitPrice<10 then 'ارزان'
when unitprice between 10 and 50 then 'متوسط'
else 'گران'
end as pricerange

  from Products

----مثال:قیمت کالا کمتر از 20 دلار مالیات 0.09 ، در غیر این صورت مالیات 0.12

select  productid, productname, unitprice, 
case
when unitprice<20 then unitprice*.09
else unitprice*.12
end as vat
from products


select  productid, productname, unitprice, 
unitprice*case
when unitprice<20 then .09
else .12
end as vat
from products

----------

