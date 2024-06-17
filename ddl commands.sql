CREATE DATABASE department;
use department;


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    role VARCHAR(50),
    salary DECIMAL(10, 2)
);

ALTER TABLE employees
ADD COLUMN hire_date DATE;

DROP TABLE employees;

CREATE INDEX idx_name ON employees (name);



CREATE VIEW high_earners AS
SELECT name, salary
FROM employees
WHERE salary > 50000;

DROP VIEW high_earners;