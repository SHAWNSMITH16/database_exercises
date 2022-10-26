
USE employees;

/* 1.  a new file named group_by_exercises.sql

2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.*/

SELECT DISTINCT title FROM titles
GROUP BY title; -- 7 unique titles

/* 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.*/

SELECT last_name FROM `employees`
WHERE last_name LIKE 'E%e'
GROUP BY last_name;

/* 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.*/

SELECT first_name, last_name FROM `employees`
WHERE last_name LIKE 'E%e' AND first_name LIKE 'E%e'
GROUP BY first_name, last_name;


/* 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.*/

SELECT last_name FROM `employees`
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name; -- Chleq, Lindqvist, Qiwen

/* 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.*/

SELECT last_name, COUNT(*) FROM `employees`
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name; -- Chleq(189), Lindqvist(190), Qiwen(168)

/* 7 .Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.*/

SELECT first_name, gender, COUNT(*) FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name;

/*8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?*/

SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), 
LOWER(SUBSTR(last_name, 1, 4)), 
"_", 
SUBSTR(birth_date, 6, 2), 
SUBSTR(birth_date, 9, 2)) AS user_id, COUNT(*) AS amount
FROM employees
GROUP BY user_id HAVING amount > 1; -- 6057 duplicates


/*
Bonus: More practice with aggregate functions:

B1. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.*/

SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no;


/*
B2. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.*/

SELECT dept_no, COUNT(*)
FROM dept_emp
GROUP BY dept_no;

/*
B3. Determine how many different salaries each employee has had. This includes both historic and current.*/

SELECT emp_no, COUNT(*)
FROM salaries
GROUP BY emp_no;

/*
B4. Find the maximum salary for each employee.*/

SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no;

/*
B5. Find the minimum salary for each employee.*/

SELECT emp_no, MIN(salary)
FROM salaries
GROUP BY emp_no;

/*
B6. Find the standard deviation of salaries for each employee.*/

SELECT emp_no, STD(salary)
FROM salaries
GROUP BY emp_no;

/*
B7. Now find the max salary for each employee where that max salary is greater than $150,000.*/

SELECT `emp_no`, salary
FROM salaries
GROUP BY emp_no, salary
HAVING salary > 150000;

/*
B8. Find the average salary for each employee where that average salary is between $80k and $90k.*/

SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) BETWEEN 80000 AND 90000;