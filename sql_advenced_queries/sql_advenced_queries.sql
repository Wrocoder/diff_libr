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