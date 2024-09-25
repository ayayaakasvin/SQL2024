CREATE DATABASE lab2;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INTEGER,
    population INTEGER
);

INSERT INTO countries (country_name, region_id, population)
VALUES
    ('Australia', 1, 20000000);

INSERT INTO countries (country_id, country_name)
VALUES
    (2, 'USA');

INSERT INTO countries (country_name, region_id, population)
VALUES
    ('Kyrgyzstan', NULL, 6000000);

INSERT INTO countries (country_name, region_id, population)
VALUES
    ('Japan', 4, 125000000),
    ('Italy', 5,  58000000),
    ('Germany', 6, 83000000);

ALTER TABLE countries ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES
    (7, 6000000);

SELECT * FROM countries;