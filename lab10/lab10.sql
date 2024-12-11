CREATE DATABASE lab10;

CREATE TABLE Books(
     book_id INTEGER PRIMARY KEY,
     title VARCHAR,
     author VARCHAR,
     price DECIMAL,
     quantity INTEGER
);


CREATE TABLE Orders(
    order_id INTEGER PRIMARY KEY,
    book_id INTEGER REFERENCES Books,
    customer_id INTEGER,
    order_date DATE,
    quantity INTEGER
);


CREATE TABLE Customers(
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR,
    email VARCHAR
);


INSERT INTO Books VALUES
	   (1, ' Database 101', 'A. Smith', 40.00, 10),
       (2, 'Learn SQL', 'B.Johnson', 35.00, 15),
       (3, 'Advanced DB', 'C.Lee', 50.00, 5);

INSERT INTO Customers VALUES
	   (101, 'John Doe', 'johndoe@example.com'),
       (102, 'Jane Doe', 'janedoe@example.com');

--1
BEGIN;

INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);


UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

SELECT * FROM Orders WHERE order_id = 1;

SELECT * FROM Books WHERE book_id = 1;

--2
BEGIN;
DO $$
BEGIN
    IF(SELECT quantity FROM Books WHERE book_id = 3) >= 10 THEN
		INSERT INTO Orders(order_id, book_id, customer_id, order_date, quantity)
        VALUES (2, 3, 102, CURRENT_DATE, 10);
    ELSE
		RAISE EXCEPTION 'Out of Stock'; 

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;

    END IF;
END
$$;

ROLLBACK;

SELECT * FROM Books WHERE book_id = 3;


--3
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Books
SET price = 24.50
WHERE book_id = 3;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price FROM Books WHERE book_id = 3;

COMMIT;

SELECT price FROM Books WHERE book_id = 1;

--4
BEGIN;
UPDATE Customers
SET email = 'daani@yahoo.fr'
WHERE customer_id = 101;
COMMIT;


SELECT email FROM Customers WHERE customer_id = 101;