CREATE DATABASE lab8;


CREATE TABLE salesman(
    salesman_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commision decimal(5, 2)
);


INSERT INTO salesman(salesman_id, name, city, commision) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'MC Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);



CREATE TABLE customers(
    customer_id INTEGER PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INTEGER,
    salesman_id INTEGER
);


INSERT INTO customers(customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davids', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);


CREATE TABLE orders(
    ord_no INTEGER PRIMARY KEY,
    purch_amt decimal(10, 2),
    ord_date date,
    customer_id INTEGER,
    salesman_id INTEGER
);

INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);



CREATE ROLE junior_dev LOGIN;


CREATE VIEW ny_salesman AS
SELECT * FROM salesman
WHERE city = 'New York';


CREATE VIEW orders_show AS
SELECT s.name AS salesman_name, c.cust_name AS customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id =  s.salesman_id;


DROP VIEW orders_show;


GRANT all privileges ON orders_show TO junior_dev;



CREATE VIEW highest_grade AS
SELECT * FROM customers
WHERE grade = (SELECT max(grade) FROM customers);
GRANT SELECT ON highest_grade TO junior_dev;




CREATE VIEW num_salesman AS
SELECT city, count(*) AS number_salesman
FROM salesman
GROUP BY city;



CREATE VIEW multiple_salesman AS
SELECT s.name AS salesman_name, count(c.customer_id) AS customer_count
FROM salesman s
JOIN orders o ON s.salesman_id = o.salesman_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY s.name
HAVING count(c.customer_id) > 1;



CREATE ROLE intern;
GRANT junior_dev TO intern;