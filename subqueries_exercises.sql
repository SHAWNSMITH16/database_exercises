USE employees;


-- SCALAR subqueries

SELECT emp_no, salary
FROM salaries
WHERE salary > /* Here is the subquery >>>> */ (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

SELECT emp_no, salary
FROM salaries
WHERE salary > 2 * /* Here is the subquery >>>> */ (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();


-- COLUMN subqueries

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
)
LIMIT 10;


-- ROW subqueries

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = (
    SELECT emp_no
    FROM employees
    WHERE emp_no = 101010
);

-- TABLE subqueries

SELECT g.birth_date, g.emp_no, g.first_name from
(
    SELECT *
    FROM employees
    WHERE first_name like 'Geor%'
) as g;

-- OR

SELECT g.first_name, g.last_name, CONCAT("$ ", salaries.salary) AS Salary
FROM
    (
        SELECT *
        FROM employees
        WHERE first_name like 'Geor%'
    ) as g
JOIN salaries ON g.emp_no = salaries.emp_no
WHERE to_date > CURDATE();



/* 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.*/

SELECT hire_date
FROM employees
WHERE hire_date = '1990-10-22';

SELECT first_name, last_name
from employees
WHERE emp_no IN
			(SELECT emp_no FROM dept_emp WHERE to_date > CURDATE())
AND hire_date IN
	 		(SELECT hire_date FROM employees WHERE emp_no = '101010');
						

/* 2. Find all the titles ever held by all current employees with the first name Aamod.*/

SELECT title, emp_no
FROM titles

WHERE emp_no IN (SELECT emp_no FROM employees WHERE first_name = 'Aamod') 

AND titles.to_date > CURDATE();

# another approach that gives all titles ever held of current employees

SELECT title, first_name
FROM (
SELECT first_name, employees.emp_no
FROM employees 
JOIN dept_emp AS de ON de.emp_no = employees.`emp_no`WHERE first_name = 'Aamod'
and de.to_date > CURDATE()) AS e
JOIN titles AS t ON t.emp_no = e.emp_no;



/* 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. (85108) */

SELECT * 
FROM employees
WHERE emp_no IN (SELECT emp_no 
				FROM dept_emp 
					WHERE to_date < CURDATE());


/*
4. Find all the current department managers that are female. List their names in a comment in your code.*/

SELECT first_name, last_name
FROM employees
WHERE emp_no IN (SELECT emp_no FROM dept_manager WHERE to_date > CURDATE())
AND gender = 'F'; 
/*
Isamu	Legleitner
Karsten	Sigstam
Leon	DasSarma
Hilary	Kambil*/

/*
5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.*/

SELECT DISTINCT emp_no, salary
FROM salaries
WHERE salary > /* Here is the subquery >>>> */ (SELECT AVG(salary) FROM salaries)
AND to_date > CURDATE()
ORDER BY emp_no ASC;


/*
6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?*/ 

SELECT COUNT(*) AS num_of_emps, (COUNT(*) / (
											SELECT COUNT(to_date)
											FROM salaries
												WHERE to_date > CURDATE()) * 100) as percent_of_emps
												FROM salaries
												WHERE salary BETWEEN (SELECT (MAX(salary) - STD(salary))
												FROM salaries)
											AND (SELECT (MAX(salary) + STD(salary))
											FROM salaries)
											AND salaries.to_date > CURDATE();	
# My code

SELECT STD(salary)
FROM salaries
WHERE to_date > CURDATE();

SELECT MAX(salary)
FROM salaries;

SELECT emp_no, salary 
FROM salaries
WHERE salary >= (SELECT
				MAX(salary) - STDDEV(salary)
					FROM salaries)
					AND to_date > CURDATE();
					
/*
Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.*/

/*
BONUS

B1. Find all the department names that currently have female managers.*/

SELECT dept_name
FROM departments
WHERE dept_no IN (SELECT dept_no 
			     FROM dept_emp
				 	 WHERE to_date > CURDATE())
AND dept_no IN (SELECT dept_no
				FROM dept_manager
				   WHERE emp_no IN (SELECT emp_no 
								    	FROM employees
									   WHERE gender = 'F' 
									   AND to_date > CURDATE()));



/*
B2. Find the first and last name of the employee with the highest salary.*/

SELECT CONCAT(first_name, " ", last_name) AS 'Full name', emp_no
FROM employees
WHERE emp_no IN (SELECT emp_no
				FROM salaries
					WHERE salary IN (SELECT MAX(salary)
										FROM salaries 
										WHERE to_date > CURDATE()));

/*
B3. Find the department name that the employee with the highest salary works in.*/

SELECT * FROM dept_emp
WHERE dept_no IN (SELECT dept_no FROM departments WHERE dept_no = 'd007')
AND emp_no = ;

SELECT * FROM departments;