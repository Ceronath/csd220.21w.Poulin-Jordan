use `classicmodels`;

select orderNumber, orderDate     -- Question 1
from orders
order by orderDate
limit 3;

select productName					-- Question 2
from products
order by quantityInStock desc
limit 1 offset 1;

select orderNumber, requiredDate		-- Question 3
from orders
where `status` = 'In Process'
order by orderDate desc;

select distinct `status`, count(*)			-- Question 4
from orders
group by `status`
order by count(*) desc;

select productLine, group_concat(productName order by productName asc separator ';') as `products`
from products						-- Question 5
group by productLine;

select year(paymentDate) as `Year`, round(avg(amount), 2) as `avg payments`, round(sum(amount), 2) as `total payments`
from payments							-- Question 6
group by year(paymentDate);

select productLine					-- Question 7
from products
where quantityInStock < 500
group by productLine
having count(productName)>1;

select count(distinct orderNumber) as `orders`, customerNumber			-- Question 8
from orders
where year(orderDate) = 2004 and `status` = 'Shipped'
group by customerNumber
having `orders`>=5
order by `orders` desc;

