
USE employees;
/* 2. Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.*/

SELECT CONCAT(first_name, last_name) AS full_name 
FROM employees
WHERE RIGHT(last_name, 1) IN ('e') AND LEFT(last_name, 1) IN ('e');

/* 3. Convert the names produced in your last query to all uppercase.*/

SELECT UPPER(CONCAT(first_name, last_name)) AS full_name 
FROM employees
WHERE RIGHT(last_name, 1) IN ('e') AND LEFT(last_name, 1) IN ('e');

/* 4. Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),*/

SELECT first_name, last_name, birth_date, hire_date, datediff(NOW(), hire_date)/365 AS longevity FROM `employees`
WHERE birth_date LIKE '%-12-25%'
AND hire_date LIKE '199%';

/* 5. Find the smallest and largest current salary from the salaries table.*/

DESCRIBE salaries;
SELECT min(salary), max(salary) FROM salaries;

/* 6. Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:*/

SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), 
LOWER(SUBSTR(last_name, 1, 4)), 
"_", 
SUBSTR(birth_date, 6, 2), 
SUBSTR(birth_date, 9, 2)) AS user_id, 
first_name, last_name, birth_date 
FROM employees
LIMIT 10;
