count(distinct <exp>)
sum(distinct <exp>)


select count (country) from customers
select count (distinct country) from customers


----تعداد مشتربان فعال در سال 1997

select count(distinct customerid) from orders where year(orderdate)=1997


---در سال 1997 هر مشتری به طور متوسط چند بار خرید کرده است

select 1.0* count(distinct orderid)/count(distinct customerid) from Orders
where year(orderdate)=1997


---در مقابل نام هر کشور تعداد مشتریان آن را بنویسید

Select country, count(customerid) from customers
group by country
order by count(customerid) desc


select distinct customerid from orders

select customerid from orders
group by customerid

---در سال 1997 هر مشتری چند بار از شرکت خرید کرده است
Select customerid, count(distinct orderid) from orders
where year(OrderDate)=1997
group by customerid


---سه تا از پر فروش ترین کالاهای شرکت بر اساس دلار فروش

Select top 3 productid, sum(unitprice* quantity)-sum(UnitPrice*Quantity*Discount) as sale from [Order Details]
group by productid
order by sale desc


---مقابل هر شماره فاکتور ارزش هر فاکتور را نمایش دهم
select top 5 orderid,sum(unitprice* quantity) from [Order Details]
group by orderid
order by sum(unitprice* quantity) desc


---قیمت گرانترین و ارزان ترین کالای هر گروه کالا 
select categoryid, min(unitprice), max(unitprice) from products
group by categoryid


select country, city from customers 
group by country , city


select distinct country, city from customers 


select count(distinct customerid), count(distinct orderid) from orders


select ProductID, OrderID, sum(UnitPrice*Quantity) from [Order Details]
group by ProductID, OrderID




/*Having*/
---مثال: در سال 1997 کدام کارمندان بیشتر از 40 فاکتور فروش داشتند

select employeeid, count(OrderID) from orders
where year(OrderDate)=1997
group by employeeid
having count(OrderID)>40

---مثال: کدام گروه کالا ها جمع موجودی کالای فعالشان بیش تر از 300 کارتن است

select CategoryID, sum(UnitsInStock) from products
where Discontinued=0
group by CategoryID
having sum(UnitsInStock)>300


----مثال: کدام فاکتورهای شرکت بیش از 10000 دلار ارزش دارند
Select OrderID, sum(UnitPrice* Quantity) as sale from [Order Details]
where OrderID>10600
group by OrderID
having sum(UnitPrice* Quantity)>10000
order by sale desc


Select OrderID, sum(UnitPrice* Quantity) as sale from [Order Details]
group by OrderID
having sum(UnitPrice* Quantity)>10000 and OrderID>10600
order by sale desc


---مثال: کدام کارمندها و در کدام سالها بیش از 40 فاکتور فروش داشتند

Select EmployeeID,year(OrderDate), count(orderid) from orders
group by EmployeeID,year(OrderDate)
having count(OrderID)>40



/*order by*/
select country, city, customerid, companyname from customers
order by country asc, city desc, customerid desc


select * from products
order by left(productname,1)

select CategoryID, count(ProductID) from Products
group by CategoryID
order by CategoryID


select EmployeeID, count(orderid), count(distinct CustomerID)as customercount from orders
group by EmployeeID
order by 3

