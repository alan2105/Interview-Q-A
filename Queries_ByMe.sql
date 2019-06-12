USE classicmodels;

-- SELECT QUERY FOR ALL COLUMS--

SELECT *
FROM
classicmodels.customers;

-- SELECT query with sepcific column--
SELECT
orders.orderDate,orders.orderNumber,orders.status
FROM classicmodels.orders;

-- SELECT query with WHERE conditions --

SELECT
* FROM
classicmodels.employees
where jobTitle = 'Sales Rep';

SELECT *
from classicmodels.customers
where addressLine2  IS NOT NULL;

SELECT 
*
FROM 
classicmodels.offices
WHERE country ='UK' OR territory= 'EMEA';

SELECT 
*
FROM 
classicmodels.offices
WHERE country ='UK' AND territory= 'EMEA';

SELECT 
*
FROM 
classicmodels.offices
WHERE country <> 'USA';

SELECT 
*
FROM 
classicmodels.payments
WHERE amount > '10000';

SELECT 
*
FROM 
classicmodels.payments
WHERE amount < '10000';

SELECT 
    lastname, 
    firstname, 
    officeCode
FROM
    classicmodels.employees
WHERE 
    officecode <= 4;

-- SELECT Query with DISTNCT keyword --

SELECT DISTINCT 
city
FROM 
classicmodels.customers;

SELECT DISTINCT 
city, state
FROM 
classicmodels.customers;

-- SELECT Query With ORDER BY --

SELECT
* FROM
classicmodels.employees
where jobTitle = 'Sales Rep'
order by firstName;

SELECT
* FROM
classicmodels.employees
where jobTitle = 'Sales Rep'
order by firstName desc;

SELECT
* FROM
classicmodels.employees
order by firstName asc,
lastname desc;

-- Order by custom  field -- 

SELECT 
    *
FROM
    classicmodels.orders
ORDER BY FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');

-- WHERE Caluse with IN --

SELECT
* 
FROM
classicmodels.orders
WHERE status IN('Cancelled', 'Disputed', 'On Hold');

SELECT
* 
FROM
classicmodels.orders
WHERE status NOT IN('Shipped');


SELECT    
 orderNumber, 
 customerNumber, 
 status, 
 shippedDate
FROM    
 classicmodels.orders
WHERE orderNumber IN
(
 SELECT 
 orderNumber
 FROM 
classicmodels.orderDetails
 GROUP BY 
 orderNumber
 HAVING SUM(quantityOrdered * priceEach) > 60000
);

-- WHERE Caluse with BETWEEN --

SELECT
*
FROM classicmodels.orders
WHERE orderDate BETWEEN '2003-01-01' AND '2003-12-31';


SELECT
*
FROM classicmodels.products
WHERE productLine= 'Motorcycles' AND MSRP BETWEEN 00.00 AND 100.00;

SELECT
*
FROM classicmodels.products
WHERE productLine= 'Motorcycles' AND MSRP NOT BETWEEN 00.00 AND 100.00;

SELECT
*
FROM classicmodels.products
WHERE MSRP BETWEEN 00.00 AND 100.00;

SELECT
*
FROM classicmodels.products
WHERE MSRP NOT BETWEEN 00.00 AND 100.00;

-- SELECT with calculation and order by --

SELECT * FROM classicmodels.orderdetails;

SELECT *, quantityOrdered*priceEach AS Total FROM
classicmodels.orderdetails
order by
Total desc;

SELECT
*, count(orders.orderNumber) AS 'Number of Orders'
FROM
classicmodels.orders
group by orders.customerNumber
order by count(orders.orderNumber) DESC;

-- WHERE caluse with LIKE --

SELECT
*
FROM
classicmodels.employees
WHERE firstName LIKE 'B%';


SELECT
*
FROM
classicmodels.employees
WHERE firstName LIKE '%a';


select 
employees.reportsTo, 
count(*) AS 'NUM of EMPLOYESS' 
from classicmodels.employees 
group by employees.reportsTo;

-- SELECT Query with LIMIT --

SELECT
*
FROM classicmodels.products
ORDER BY products.quantityInStock DESC
LIMIT 10;
-- Find the highest value --
SELECT
*
FROM classicmodels.products
ORDER BY products.quantityInStock DESC
LIMIT 1,1;

-- Find the 2nd highest value --
SELECT
*
FROM classicmodels.products
ORDER BY products.quantityInStock DESC
LIMIT 2,1;

-- IS NULL / IS NOT NULL --

SELECT
* 
FROM
classicmodels.orders
WHERE shippedDate IS NULL;

SELECT
* 
FROM
classicmodels.orders
WHERE comments IS NOT NULL;


SELECT orders.status, Count(*) AS 'Total'
FROM 
classicmodels.orders
group by orders.status;


-- INNER JOIN --

select * from classicmodels.productlines;

select * from classicmodels.products;

SELECT
p.productCode,
p.productName,
p.productLine,
p.productDescription,
pl.textDescription AS productLineDescription
FROM
classicmodels.products p
INNER JOIN
classicmodels.productlines pl
ON
p.productLine = pl.productLine
ORDER BY
p.productName;


SELECT
productCode,
productName,
productLine,
productDescription,
textDescription AS productLineDescription
FROM
products 
INNER JOIN
productlines
USING (productline)
ORDER BY
productName;

-- INNER JOIN with GROUP BY --

SELECT * 
FROM orders;

SELECT * 
FROM orderdetails;

SELECT 
orderNumber,
status,
SUM(quantityOrdered * priceEach) AS 'Total Price',
customerNumber,
COUNT(*) AS 'No.of Order Each Customer'
FROM
orders
INNER JOIN
orderdetails
USING (orderNumber)
GROUP BY
orderNumber,
customerNumber;

-- INNER JOIN With using other operators --

SELECT *
FROM
products;

SELECT *
FROM
orderdetails;

SELECT
od.productCode,
productName,
productLine,
buyPrice,
msrp,
priceEach
FROM
products p
INNER JOIN
orderdetails od
ON
p.productCode = od.productCode
AND p.MSRP > od.priceEach
WHERE p.productCode LIKE 'S10_%';


-- LEFT JOIN --

SELECT * 
FROM
customers;

SELECT * 
FROM orders;

SELECT
customers.customerNumber,
CONCAT(customers.contactFirstName,customers.contactLastName) AS 'customerName',
customers.phone,
orders.orderNumber,
orders.shippedDate,
orders.status,
orders.comments
FROM
customers
LEFT JOIN
orders
ON
customers.customerNumber = orders.customerNumber
WHERE orders.customerNumber = '103';

SELECT
customers.customerNumber,
CONCAT(customers.contactFirstName,customers.contactLastName) AS 'customerName',
customers.phone,
orders.orderNumber,
orders.shippedDate,
orders.status,
orders.comments,
(Select COUNT(orders.customerNumber) FROM orders) AS 'No.of Orders'
FROM
customers
LEFT JOIN
orders
ON
customers.customerNumber = orders.customerNumber;




