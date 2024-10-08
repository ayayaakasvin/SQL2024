--1
CREATE TABLE lab4;

--2
CREATE TABLE Warehouse (
	code INTEGER,
	location VARCHAR(255),
	capacity INTEGER
);

CREATE TABLE Boxes (
	code CHAR(4),
	contents VARCHAR(255),
	value REAL,
	warehouse INTEGER
);

--3
INSERT INTO Warehouses (code, location, capacity) VALUES
	(1, 'Chicago', 3),
	(2, 'Chicago', 4),
	(3, 'New York', 7),
	(4, 'Los Angeles', 2),
	(5, 'San Francisco', 8);

INSERT INTO Boxes(code, contents, value, warehouse)
	VALUES 
	('0MN7', 'Rocks', 180, 3),
	('4H8P', 'Rocks', 250, 1),
	('4RT3', 'Scissors', 190, 4),
	('7G3H', 'Rocks', 200, 1),
	('8JN6', 'Papers', 75, 1),
	('8Y6U', 'Papers', 50, 3),
	('9J6F', 'Papers', 175, 2),
	('LL08', 'Rocks', 140, 4),
	('P0H6', 'Scissors', 125, 1),
	('P2T6', 'Scissors', 150, 2),
	('TU55', 'Papers', 90, 5);

--4
SELECT * FROM warehouse;

--5
SELECT * FROM boxes WHERE "value" > 150;

--6
SELECT DISTINCT ON (contents) * FROM boxes;

--7
SELECT warehouse, COUNT(*) FROM boxes GROUP BY warehouse;

--8
SELECT warehouse, COUNT(*) FROM boxes GROUP BY warehouse HAVING COUNT(*) > 2;

--9
INSERT INTO warehouses("location", capacity) VALUES ('New York', 3);

--10
INSERT INTO boxes(code, contents, "value", warehouse) VALUES ('H5RT', 'Papers', 200, 2);

--11
UPDATE boxes 
SET "value" = "value" - ("value" * 0.15) 
WHERE "value" = (
SELECT "value" FROM boxes
ORDER BY "value" DESC
OFFSET 2 LIMIT 1);

--12
DELETE FROM boxes WHERE "value" < 150;

--13
DELETE FROM boxes WHERE warehouse = (SELECT code FROM warehouses WHERE "location" = 'New York' LIMIT 1)
RETURNING *;