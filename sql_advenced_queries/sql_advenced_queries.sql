##################################################ADVANCED_QUERYING#####################################################

--1. Write a query to find the top 5 customers with the highest total order amount
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date, order_amount)

SELECT c.customer_id, SUM(o.order_amount) as total_amount
    FROM Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    GROUP BY c.customer_id
    order by SUM(o.order_amount) desc limit 5;


--2. Retrieve the names of customers who have placed orders in the past 30 days
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date, order_amount)

SELECT c.customer_name
    FROM Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    where o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);


--3. Find the products that have been ordered at least three times.
--Dataset: Products(product_id, product_name)
--         Order_items(order_id, product_id, quantity)


SELECT p.product_id, p.product_name
    FROM Products p
    JOIN Orders o
        on p.product_id = o.product_id
    GROUP BY p.product_id
    HAVING count(o.order_id) >= 3;


--4. Retrieve the order details for orders placed by customers FROM a specific city.
--Dataset: Customers(customer_id, customer_name, city)
--         Orders(order_id, customer_id, order_date)
--         Order_details(order_id, product_id, quantity)

SELECT od.order_id, od.product_id, od.quantity
    FROM Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    JOIN Order_details od
        on od.order_id = o.order_id
    where c.city = 'specific_city';


--5. Write a query to find the customers who have placed orders for products with a price greater than 100$.
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date)
--         Products(product_id, product_name, price)
--         Order_details(order_id, product_id, quantity)

SELECT c.customer_id, c.customer_name
    FROM Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    JOIN Order_details od
        on od.order_id = o.order_id
    JOIN Products p
        on p.product_id = od.product_id
    where p.price > 100;


--6.Get the average order amount for each customer.
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date, order_amount)

SELECT c.customer_id, avg(o.order_amount) avg_amnt
    FROM Customers c
    left join Orders o
        on c.customer_id = o.customer_id
    GROUP BY c.customer_id


--7.Find the products that have never been ordered.
--Dataset: Products(product_id, product_name)
--         Order_items(order_id, product_id, quantity)

SELECT product_id, product_name
    FROM Products
    where product_id not in (SELECT product_id FROM Order_items);


SELECT p.product_id, p.product_name
    FROM Products p
    left join Order_items oi
        on p.product_id = oi.product_id
    where oi.product_id is NULL;


--8. Retrieve the names of customers who have placed orders on Weekends (Saturday or Sunday).
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date)
--The WEEKDAY() function returns the weekday number for a given date.
--Note: 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday.


SELECT distinct c.customer_name
    FROM Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    where WEEKDAY(o.order_date) in (6,7);


--9.Get the total order amount for each month.
--Dataset:  Orders(order_id, order_date, order_amount)

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(order_amount) AS total_order_amount
    FROM Orders
    GROUP BY MONTH(order_date);

--10.Write a query to find the customers who have placed orders for more than two different products.
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date)
--         Order_items(order_id, product_id, quantity)

SELECT c.customer_id, c.customer_name
    FROM Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    JOIN Order_items od
        on od.order_id = o.order_id
    GROUP BY c.customer_id, c.customer_name
    HAVING count(distinct oi.product_id) > 2;

##################################################JOINS#################################################################
--1. Retrieve the order details along with the customer name and product name for each order.
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date)
--         Order_items(order_id, product_id, quantity)
--         Products(product_id, product_name)

SELECT oi.order_id, oi.quantity, c.customer_name, p.product_name
    FROM Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    JOIN Order_items oi
        on oi.order_id = o.order_id
    JOIN Products p
        on p.product_id = oi.product_id
        
--2.Find the products and their corresponding suppliers names.
--Dataset: Products(product_id, product_name, supplier_id)
--         Supplier(supplier_id, supplier_name)

SELECT p.product_id, p.product_name, s.supplier_name
    FROM Products p
    JOIN Supplier s
        on p.supplier_id = s.supplier_id


--3. Get a list of customers who have neve placed an order
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id)

SELECT c.customer_id, c.customer_name
    FROM Customers c
    LEFT JOIN Orders o
        on c.customer_id = o.customer_id
    where o.customer_id is NULL


--4. Retrieve the names of customers along with the total quantity of products they ordered.
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id)
--         Order_items(order_id, product_id, quantity)

select c.customer_name, sum(oi.quantity) as total_quantity
    from Customers c
    join Orders o
        on c.customer_id = o.customer_id
    join Order_items oi
        on o.order_id = oi.order_id
    group by c.customer_name

--5.Find the products that have been ordered by customers from a specific country
--Dataset: Products(product_id, product_name)
--         Orders(order_id, customer_id)
--         Customers(customer_id, country) ?????????????????????????????

SELECT DISTINCT p.product_name
    FROM Products p
    JOIN Order_items oi ON p.product_id = oi.product_id
    JOIN Orders o ON oi.order_id = o.order_id
    JOIN Customers c ON o.customer_id = c.customer_id
    WHERE c.country = 'SpecificCountry';


--6. Get the total order amount for each customer, including those who have not placed any orders.
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_amount)

SELECT c.customer_id, c.customer_name, sum(o.order_amount) as total_order_amount
    FROM Customers c
    LEFT JOIN Orders o
        on c.customer_id = o.customer_id
    group by c.customer_id, c.customer_name;


--7.Retrieve the orders details for orders placed by customers with a specific occupation.
--Dataset: Customers(customer_id, customer_name, occupation)
--         Orders(order_id, customer_id, order_date)
--         Order_items(order_id, product_id, quantity)

select oi.order_id, oi.product_id, oi.quantity, o.order_date
    from Customers c
    join Orders o
        on c.customer_id = o.customer_id
    join Order_items oi
        on o.order_id = oi.order_id
    group by c.customer_name
    where c.occupation = 'specificOccupation';


--8.Find the customers who have placed orders for products with a price higher the average price of all products;
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_date)
--         Order_items(order_id, product_id, quantity)
--         Products(product_id, product_name, price)

select distinct c.customer_id, c.customer_name
    from Customers c
    JOIN Orders o
        on c.customer_id = o.customer_id
    JOIN Order_Items oi
        on oi.order_id = o.order_id
    JOIN Products p
        on p.product_id = oi.product_id
    where p.price >= (select avg(price) from Products)

--9.Retrieve the names of customers along with the total number of orders they have placed.
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_amount)
SELECT c.customer_name, count(o.order_id) as total_number
    FROM Customers c
    LEFT JOIN Orders o
        on c.customer_id = o.customer_id
    group by c.customer_name;

--10.Get a list of products and the total quantity ordered for each product
--Dataset: Products(product_id, product_name)
--         Order_items(order_id, product_id, quantity)

select p.product_id, p.product_name, sum(oi.quantity) as total_quantity
    FROM Products p
    LEFT join Order_items oi
        on p.product_id = oi.product_id
    group by product_id, product_name;


#######################################ADVANCED_FILTERING_AND_SORTING###################################################

--1. Retrieve all customers with names starting with 'A' and ending with 'n'
--Dataset: Customers(customer_id, customer_name)

select customer_id, customer_name
FROM Customers
where substring(customer_name, 1, 1) = 'A' and substring(customer_name, -1, 1) = 'n'
-- customer_name LIKE 'A%n'

--2. Find the products with names containing at least one digit.
--Dataset: Products(product_id, product_name)
SELECT *
    FROM Products
    WHERE product_name LIKE '%[0-9]%';

SELECT *
    FROM Products
    WHERE product_name REGEXP '[0-9]';

--3.Get the list of employees sorted by their salary in ascending order. Null values should appear at the end.
--Dataset: Employees(employee_id, employee_name, salary)

select employee_id, employee_name, salary
    from Employees
    order by salary asc


--4.Retrieve the customers whose names contain exactly five characters.
--Dataset: Customers(customer_id, customer_name)

select customer_id, customer_name
    from Customers
    where length(customer_name) = 5;

--5.Find the products with names starting with 'S' and ending with 'e';
--Dataset: Products(product_id, product_name)

select product_id, product_name
    from Products
    where product_name LIKE 'S%e';

--6.Get the list of employees sorted by their last name and then by ther first name;
--Dataset: Employees(employee_id, first_name, last_name, salary)

select employee_id, employee_name, salary
    from Employees
    order by last_name, first_name;


--7. Retrieve the orders placed on a specific date and sort them by the customer name in alphabetical order.
--Dataset: Orders(order_id, customer_name, order_date)

select order_id, customer_name
    from Orders
    where order_date = 'specific_date'
    order by customer_name;


--8.Retrieve the products names contain exactly three characters.
--Dataset: Products(product_id, product_name)

select product_id, product_name
    from Customers
    where length(product_name) = 3;


--9. Get the list of employees sorted by their salary in descending order. Null values should appear at the beginning.
--Dataset: Employees(employee_id, employee_name, salary)

select employee_id, employee_name
    from Employees
    order by
        case when salary is NULL then 0 else 1 asc END, salary desc;


--10.Retrieve the customers whose name contain a space character.
--Dataset: Customers(customer_id, customer_name)

SELECT customer_id, customer_name
    FROM Customers
    WHERE customer_name LIKE '% %';