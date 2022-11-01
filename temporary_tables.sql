-- Use the read_only database
-- This avoids needing to re-type the db_name in front of every table_name
USE employees;

-- Specify the db where you have permissions and add the temp table name.
-- Replace "my_database_with_permissions"" with the database name where you have appropriate permissions. It should match your username.
DROP TABLE IF EXISTS noether_2028.employees_with_departments;

CREATE TEMPORARY TABLE noether_2028.employees_with_departments AS 
(SELECT first_name, last_name, dept_name 
FROM employees 
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no));

-- Change the current db.
USE noether_2028;

SELECT * FROM employees_with_departments;

/*Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns*/

ALTER TABLE employees_with_departments ADD Full_Name VARCHAR(30);

SELECT * 
FROM employees_with_departments;
/*
Update the table so that full name column contains the correct data*/

UPDATE employees_with_departments SET Full_Name = CONCAT(first_name, ' ', last_name);

SELECT * 
FROM employees_with_departments;

/*
Remove the first_name and last_name columns from the table.*/

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

SELECT *
FROM employees_with_departments;
/*
What is another way you could have ended up with this same table?*/

-- *****************************************************************************************************************
-- Use the read_only database
-- This avoids needing to re-type the db_name in front of every table_name
USE employees;

-- Specify the db where you have permissions and add the temp table name.
-- Replace "my_database_with_permissions"" with the database name where you have appropriate permissions. It should match your username.
DROP TABLE IF EXISTS noether_2028.employees_with_departments;

CREATE TEMPORARY TABLE noether_2028.employees_with_departments AS 
(SELECT CONCAT(first_name, " ", last_name) AS Full_name, dept_name 
FROM employees 
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no));

-- Change the current db.
USE noether_2028;

SELECT * FROM employees_with_departments;


/*

Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

*/
USE sakila;

DROP TABLE IF EXISTS noether_2028.makes_cents_to_me;

CREATE TEMPORARY TABLE noether_2028.makes_cents_to_me AS 
(SELECT payment_id, amount
FROM payment);

USE noether_2028;

SELECT payment_id, amount * 100
FROM makes_cents_to_me;

ALTER TABLE makes_cents_to_me ADD pennies INT(5) NOT NULL;


SELECT payment_id, amount * 100
FROM makes_cents_to_me;

UPDATE makes_cents_to_me SET pennies = amount * 100;

SELECT * 
FROM makes_cents_to_me;

ALTER TABLE makes_cents_to_me DROP COLUMN amount;

SELECT * 
FROM makes_cents_to_me;

# ALTERING data type in table without dropping columns

USE sakila;

DROP TABLE IF EXISTS noether_2028.makes_cents_to_me;

CREATE TEMPORARY TABLE noether_2028.makes_cents_to_me AS 
(SELECT payment_id, amount
FROM payment);

USE noether_2028;

SELECT payment_id, CAST(amount * 100 AS UNSIGNED) AS updated_amount
FROM makes_cents_to_me;


/*Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?*/

USE employees;

DROP TABLE IF EXISTS noether_2028.dept_avg;

CREATE TEMPORARY TABLE noether_2028.dept_avg
(SELECT dept_name, ROUND(AVG(salary), 2) AS avg_sal
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > CURDATE()
GROUP BY dept_name);

USE noether_2028;

SELECT *
FROM dept_avg;


SELECT AVG(avg_sal)
FROM dept_avg;




SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries
WHERE to_date > CURDATE();

/*-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;*/


--  Review from class

USE employees;

DROP TABLE IF EXISTS noether_2028.overall_agg;

CREATE TEMPORARY TABLE noether_2028.overall_agg AS 
(SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
FROM employees.salaries
WHERE to_date > CURDATE());

SELECT *
FROM noether_2028.overall_agg;


CREATE TEMPORARY TABLE noether_2028.metrics AS 
(SELECT dept_name, AVG(salary) AS dept_avg
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > CURDATE()
AND employees.salaries.to_date > CURDATE()
GROUP BY dept_name);

SELECT * 
FROM noether_2028.metrics;


ALTER TABLE noether_2028.metrics ADD overall_avg FLOAT(10, 2);
ALTER TABLE noether_2028.metrics ADD overall_std FLOAT(10, 2);
ALTER TABLE noether_2028.metrics ADD dept_zscore FLOAT(10, 2);


SELECT *
FROM noether_2028.metrics;


UPDATE noether_2028.metrics SET overall_avg = (SELECT avg_salary FROM noether_2028.overall_agg);


SELECT * 
FROM noether_2028.metrics;


UPDATE noether_2028.metrics SET overall_std = (SELECT std_salary FROM noether_2028.overall_agg);


SELECT * 
FROM noether_2028.metrics;


UPDATE noether_2028.metrics SET dept_zscore = (dept_avg - overall_avg) / overall_std;


SELECT * 
FROM noether_2028.metrics
ORDER BY dept_zscore DESC;


-- BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS BONUS 

USE employees;

DROP TABLE IF EXISTS noether_2028.overall_agg;

CREATE TEMPORARY TABLE noether_2028.overall_agg AS 
(SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
FROM employees.salaries
WHERE to_date > CURDATE());

SELECT *
FROM noether_2028.overall_agg;

DROP TABLE IF EXISTS noether_2028.metrics;

CREATE TEMPORARY TABLE noether_2028.metrics AS 
(SELECT dept_name, AVG(salary) AS dept_avg
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
GROUP BY dept_name);

SELECT * 
FROM noether_2028.metrics;


ALTER TABLE noether_2028.metrics ADD overall_avg FLOAT(10, 2), 
ADD overall_std FLOAT(10, 2), 
ADD dept_zscore FLOAT(10, 2);


SELECT *
FROM noether_2028.metrics;


UPDATE noether_2028.metrics SET overall_avg = (SELECT avg_salary FROM noether_2028.overall_agg);

UPDATE noether_2028.metrics SET overall_std = (SELECT std_salary FROM noether_2028.overall_agg);

UPDATE noether_2028.metrics SET dept_zscore = (dept_avg - overall_avg) / overall_std;


SELECT * 
FROM noether_2028.metrics
ORDER BY dept_zscore DESC;
