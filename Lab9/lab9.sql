-- 1
CREATE OR REPLACE FUNCTION increase_value(val INTEGER)
RETURNS INTEGER
AS $$
BEGIN
    RETURN val + 10;
END; $$
LANGUAGE plpgsql;

-- 2
CREATE OR REPLACE FUNCTION compare_numbers(
    first INTEGER,
    second INTEGER, 
    OUT result TEXT
) AS $$
BEGIN
    IF first > second THEN
        result := 'Greater';
    ELSIF first < second THEN
        result := 'Lesser';
    ELSE
        result := 'Equal';
    END IF;
END; $$
LANGUAGE plpgsql;

-- 3
CREATE OR REPLACE FUNCTION number_series(
    n INTEGER,
    OUT series INTEGER[]
) AS $$
BEGIN
    series := ARRAY[]::INTEGER[];

    FOR cnt IN 1..n LOOP
        series := array_append(series, cnt);
    END LOOP;
END; $$
LANGUAGE plpgsql;

-- 4
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    department TEXT,
    position TEXT,
    salary NUMERIC
);

CREATE OR REPLACE FUNCTION find_employee(
    emp_name TEXT
) 
RETURNS TABLE (
    id INTEGER,
    name TEXT,
    department TEXT,
    "position" TEXT,
    salary NUMERIC
) 
AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, department, position, salary
    FROM employees
    WHERE name = emp_name;
END; $$
LANGUAGE plpgsql;

-- 5
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC NOT NULL,
);

CREATE OR REPLACE FUNCTION list_products(
    category_name VARCHAR
) 
RETURNS TABLE (
    product_id INTEGER,
    product_name VARCHAR,
    category VARCHAR,
    price NUMERIC,
) 
AS $$
BEGIN
    RETURN QUERY
    SELECT product_id, product_name, category, price, stock_quantity
    FROM products
    WHERE category = category_name;
END; $$
LANGUAGE plpgsql;


-- 6
CREATE OR REPLACE FUNCTION calculate_bonus(
    employee_id INTEGER
)
RETURNS NUMERIC AS $$
DECLARE
    bonus INTEGER;
BEGIN
    SELECT salary * 0.2 INTO bonus FROM employees WHERE emp_id = employee_id;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION update_salary(employee_id INTEGER)
RETURNS VOID AS $$
DECLARE
    bonus INTEGER;
BEGIN
    bonus := calculate_bonus(employee_id);
    UPDATE employees SET salary = salary + bonus WHERE emp_id = employee_id;
END;
$$

-- 7
CREATE OR REPLACE FUNCTION complex_calculation(
    input_number INTEGER,
    input_text VARCHAR
) 
RETURNS TEXT 
AS $$
DECLARE
    numeric_result INTEGER;
    string_result VARCHAR;
    final_result TEXT;
BEGIN
    -- Main block labeled "main_block"
    <<main_block>>
    BEGIN
        -- First subblock: Perform a numeric computation
        <<numeric_block>>
        BEGIN
            -- Example: Square the input number and add 10
            numeric_result := (input_number * input_number) + 10;
        END numeric_block;

        -- Second subblock: Perform a string manipulation
        <<string_block>>
        BEGIN
            -- Example: Reverse the input string
            string_result := reverse(input_text);
        END string_block;

        -- Combine results from subblocks
        final_result := 'Number Result: ' || numeric_result || ', String Result: ' || string_result;

        -- Return the combined result
        RETURN final_result;
    END main_block;
END;
$$
LANGUAGE plpgsql;
