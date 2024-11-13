CREATE DATABASE lab7;

CREATE TABLE countries(
	country_id SERIAL,
	country_name VARCHAR(50)
);

INSERT INTO countries(country_name) 
VALUES ('Morocco'), ('USA'), ('Kazakhstan'), ('Argentina');

CREATE TABLE departments(
	department_id SERIAL PRIMARY KEY,
	department_name VARCHAR(50),
	budget INTEGER
);

INSERT INTO departments(department_name, budget)
VALUES ('Finance', 4000),
('Human Resources', 2000),
('Sales', 6000);

CREATE TABLE employees(
	employee_id SERIAL,
	employee_name VARCHAR(50),
	employee_surname VARCHAR(50),
	employee_salary INTEGER,
	department_id INTEGER REFERENCES departments
);

INSERT INTO employees(employee_name, employee_surname, employee_salary, department_id)
VALUES ('Kirk', 'Jonathan', 500, 1),
('Bosh', 'Sammy', 1000, 3),
('Green', 'Jaythan', 2000, 2);

-- 1 
CREATE INDEX countries_name_idx 
ON countries (country_name);

SELECT * from countries;

SELECT * FROM countries WHERE country_name = 'Kazakhstan';

-- 2 
CREATE INDEX employees_name_and_surname_idx 
ON employees (employee_name, employee_surname)


SELECT * from employees;

SELECT * FROM employees
WHERE employee_name = 'Kirk' 
AND
employee_surname = 'Jonathan';

-- 3
CREATE UNIQUE INDEX employees_salary_between_idx
ON employees (employee_salary) 
WHERE employee_salary BETWEEN 500 AND 1000;

SELECT * from employees;

SELECT * FROM employees
WHERE employee_salary 
BETWEEN 500 AND 1000;

-- 4
CREATE INDEX employees_name_substring_idx
ON employees (substring(employee_name from 1 for 4));

SELECT * from employees;

SELECT * FROM employees WHERE substring(employee_name from 1 for 4) = 'Gree';

-- 5
CREATE INDEX employees_department_salary_idx 
ON employees (employee_salary, department_id);

SELECT *
FROM employees
JOIN departments ON employees.department_id = departments.department_id
WHERE employees.employee_salary > 1000;;