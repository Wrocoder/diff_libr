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


--1.Calculate the total quantity and total amount for each order.
--Dataset: Orders(order_id, order_date)
--         Order_items(order_id, product_id, quantity, amount)

select order_id, sum(amount) as total_amount, sum(quantity) as total_quantity
    from Orders o
    JOIN Order_items oi
        on o.order_id = oi.order_id
    group by o.order_id


--2.Find the average age and the number of employees for each job title
--Dataset: Employees(employee_id, employee_name, age, job_title)

select avg(age), count(employee_id)
    from Employees
    group by job_title


--3.Get the total number of products in each category
--Dataset: Products(product_id, product_name, category_id)
--         Categories(category_id, category_name)

SELECT c.category_name,
       COUNT(p.product_id) AS total_products
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;

--4. Calculate the average rating and the namber of reviews for each product.
--Dataset: Products(product_id, product_name, category_id)
--         Reviews(product_id, rating)

select p.product_name, avg(r.rating), count(r.product_id)
    FROM Products p
    left join Reviews r
    on r.product_id = p.product_id
    group by p.product_name;


--5.Find the customers with the highest and lowest total order amounts
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_amount)


WITH CTE AS (
    SELECT c.customer_id, c.customer_name, SUM(o.order_amount) AS amnt
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT CTE.customer_id, CTE.customer_name, MAX(CTE.amnt) AS highest_order_amount
FROM CTE
UNION ALL
SELECT CTE.customer_id, CTE.customer_name, MIN(CTE.amnt) AS lowest_order_amount
FROM CTE;


--6. Get the maximum and minimum ages for each department.
--Dataset: Employees(employee_id, employee_name, age, department)

select department, max(age), min(age) from Employees
group by department

--7. Calculate the total sales amount and the number of orders for each month.
--Dataset: Orders(order_id, order_date, order_amount)

select month(order_date) as mnth, sum(order_amount), count(order_id)
from Orders
group by month(order_date)
order by month(order_date);

--8.Find the average price and the number of products for each supplier_id
--Dataset: Products(product_id, product_name, price, supplier_id)
--         Supplier(supplier_id, supplier_name)


select s.supplier_id, s.supplier_name, avg(p.price), count(p.product_id)
    from Suppliers s
    left join Products p
        on s.supplier_id = p.supplier_id
    group by s.supplier_id, s.supplier_name

--9.Get the maximum and minimum prices for each product category
--Dataset: Products(product_id, product_name, category_id, price)
--         Categories(category_id, category_name)

select c.category_id, c.category_name, max(p.price), min(p.price)
from Categories c
left join Products p
    on p.category_id = c.category_id
group by c.category_id, c.category_name


--10. Calculate the average rating and the number of reviews for each product category
--Dataset: Products(product_id, product_name, category_id)
--         Reviews(product_id, rating)


select p.category_id, avg(r.rating), count(r.rating)
from Products p
left join Reviews r
    on p.product_id = r.product_id
group by p.category_id;

WITH CategoryAvgRating AS (
    SELECT
        p.category_id,
        AVG(r.rating) AS avg_rating,
        COUNT(r.product_id) AS review_count
    FROM
        Products p
    LEFT JOIN
        Reviews r ON p.product_id = r.product_id
    GROUP BY
        p.category_id
)
SELECT
    c.category_id,
    c.category_name,
    COALESCE(car.avg_rating, 0) AS avg_rating,
    COALESCE(car.review_count, 0) AS review_count
FROM
    Categories c
LEFT JOIN
    CategoryAvgRating car ON c.category_id = car.category_id;


--1. Retrieve the top 3 customers based on their total amounts, and calculate the percentage of each customer's order
--amount and calculate the percentage of each customer's order amount compared to the total
--Dataset: Customers(customer_id, customer_name)
--         Orders(order_id, customer_id, order_amount)

with CTE as
(
select c.customer_id,
        c.customer_name,
        sum(o.order_amount) as customer_sum
from Customers c
join Orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
)
select customer_name, customer_sum, customer_sum / (sum(customer_sum) over () / 100) as prctg
from CTE
order by customer_sum DESC
limit 3;


--2. Calculate the average rating for each product and assign a rank based on the rating using a window function
--Dataset: Products(product_id, product_name)
--         Rating(product_id, rating)

with CTE as
(
select p.product_id, p.product_name, avg(r.rating) over (partition by p.product_id) as avg_rate
from Products p
LEFT JOIN Rating r
on p.product_id = r.product_id
)
select distinct product_id, product_name, avg_rate,
        rank() over (partition by avg_rate) as rt
        from CTE
        order by rt;
