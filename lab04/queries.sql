use `classicmodels`;

select orders.customerNumber, customerName , round(sum(detail.quantityOrdered*detail.priceEach),2) as 'OrderSum'
from customers
join orders											-- question 1
on customers.customerNumber = orders.customerNumber
join orderDetails detail
on orders.orderNumber = detail.orderNumber
group by orders.customerNumber,customerName
order by sum(detail.quantityOrdered*detail.priceEach) desc;

select orders.customerNumber, customerName , round(avg(detail.quantityOrdered*detail.priceEach),2) as 'OrderAvg'
from customers
inner join orders											-- question 2
on customers.customerNumber = orders.customerNumber
inner join orderDetails detail
on orders.orderNumber = detail.orderNumber
group by orders.customerNumber,customerName
order by sum(detail.quantityOrdered*detail.priceEach) desc;

select productName, buyPrice				-- question 3
from products
order by buyPrice desc limit 1;

select distinct orders.customerNumber, customers.customerName as 'expensive-taste'
from orderdetails						-- question 4
join products 
on products.productCode = orderdetails.productCode
join orders 
on orders.orderNumber = orderdetails.orderNumber
join customers 
on customers.customerNumber = orders.customerNumber
where buyPrice in (select max(buyPrice)
from products);
    
select innertable.customerNumber, innertable.expensivetaste, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as orderSum
from (select distinct orders.customerNumber, customers.customerName as 'expensivetaste'
from orderdetails								-- question 5
join products 
on products.productCode = orderdetails.productCode
join orders 
on orders.orderNumber = orderdetails.orderNumber
join customers 
on customers.customerNumber = orders.customerNumber
where buyPrice in (select max(buyPrice)
from products) ) as innertable
join orders on orders.customerNumber = innertable.customerNumber
join orderdetails on orderdetails.orderNumber = orders.orderNumber
group by innertable.customerNumber;

select innertable.customerNumber, innertable.expensivetaste, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as orderSum
from (select distinct orders.customerNumber, customers.customerName as 'expensivetaste'
from orderdetails								-- question 6
join products 
on products.productCode = orderdetails.productCode
join orders 
on orders.orderNumber = orderdetails.orderNumber
join customers 
on customers.customerNumber = orders.customerNumber
where buyPrice in (select max(buyPrice)
from products) ) as innertable
join orders on orders.customerNumber = innertable.customerNumber
join orderdetails on orderdetails.orderNumber = orders.orderNumber
group by innertable.customerNumber
having orderSum > (select round(avg(innertable.orderSum), 2) as avgTotal
from (select distinct orders.customerNumber, customerName, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as orderSum
	from customers
    join orders on orders.customerNumber = customers.customerNumber
    join orderdetails on orders.orderNumber = orderdetails.orderNumber
    group by orders.customerNumber
    order by orderSum desc) as innertable)
order by orderSum desc;

create or replace view expTasteCust as 
select distinct orders.customerNumber, customers.customerName as expensivetaste
from orderdetails					-- question 7 
join products on products.productCode = orderdetails.productCode
join orders on orders.orderNumber = orderdetails.orderNumber
join customers on customers.customerNumber = orders.customerNumber
where buyPrice in (select max(buyPrice) from products);
select expTasteCust.customerNumber, expTasteCust.expensivetaste, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as orderSum
from expTasteCust
join orders on orders.customerNumber = expTasteCust.customerNumber
join orderdetails on orderdetails.orderNumber = orders.orderNumber
group by expTasteCust.customerNumber
order by orderSum desc;

create or replace view purTotal as
select distinct orders.customerNumber, customerName, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as orderSum
from customers
join orders on orders.orderNumber = customers.customerNumber
join orderdetails on orders.orderNumber = orderdetails.orderNumber
group by customers.customerNumber
order by orderSum desc;					-- Question 8 
select purTotal.customerNumber, purTotal.customerName, orderSum
from purTotal
where orderSum > (select round(avg(innertable.orderSum), 2) as avgTotal
from (select distinct orders.customerNumber, customerName, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as orderSum
from customers
join orders on orders.customerNumber = customers.customerNumber
join orderdetails on orders.orderNumber = orderdetails.orderNumber
group by orders.customerNumber
order by orderSum desc) as innertable);    
-- Not sure about this one... Spent alot of time on it and it just doesn't click