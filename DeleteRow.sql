---delete
/*
delete [from] <table name>
where <boolean expr>

*/

---مثال: مشتریان آمریکایی را حذف کند
select * from customers
where country=N'USA'


delete from customers
where country=N'USA'
