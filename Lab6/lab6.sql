-- 3
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
JOIN departments USING(department_id);

-- 4
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id 
WHERE departments.department_id in (80, 40);

-- 5
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name, locations.city, locations.state_province
FROM employees 
INNER JOIN departments USING(department_id)
INNER JOIN locations USING (location_id);

-- 6
SELECT departments.* 
FROM departments 
LEFT JOIN employees USING(department_id);

-- 7
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
LEFT JOIN departments USING(department_id);