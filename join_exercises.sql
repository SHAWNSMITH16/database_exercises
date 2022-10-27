USE employees;

SELECT dept_name, dept_no FROM departments ORDER BY dept_no;

SELECT emp_no, dept_no FROM dept_manager;

SELECT DISTINCT emp_no FROM employees;
/* 1. Use the employees database.

2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.*/

SELECT departments.dept_name, 
CONCAT(employees.first_name, ' ', employees.last_name) AS full_name
FROM employees
	JOIN dept_manager USING(emp_no)
		# dept_manager.emp_no = employees.emp_no
	JOIN departments USING(dept_no)
		#ON departments.dept_no = dept_manager.dept_no
	WHERE dept_manager.to_date > CURDATE() 
	ORDER BY dept_name;
	
/* 3. Find the name of all departments currently managed by women.  */	
SELECT departments.dept_name, 
CONCAT(employees.first_name, ' ', employees.last_name) AS full_name
FROM employees
	JOIN dept_manager
		ON dept_manager.emp_no = employees.emp_no
	JOIN departments
		ON departments.dept_no = dept_manager.dept_no
	WHERE dept_manager.to_date = '9999-01-01' AND employees.gender = 'F'
	ORDER BY dept_name;
	
/* 4. Find the current titles of employees currently working in the Customer Service department.*/

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM titles;
	
SELECT titles.title, COUNT(*)
FROM titles
	JOIN dept_emp
		ON dept_emp.emp_no = titles.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN employees
		ON employees.emp_no = titles.emp_no
		WHERE titles.to_date = '9999-01-01' AND dept_name = 'Customer Service'
		GROUP BY title
		ORDER BY title;

/* 5. Find the current salary of all current managers. */

SELECT departments.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS `Name`, salaries.salary
FROM employees
	JOIN dept_emp
		ON dept_emp.emp_no = employees.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		ON salaries.emp_no = employees.emp_no
	JOIN dept_manager
		ON dept_manager.emp_no = employees.emp_no
	WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
	ORDER BY dept_name;

/* 6. Find the number of current employees in each department. */

SELECT departments.dept_no, departments.dept_name, COUNT(employees.emp_no)#Can also use COUNT(*)
FROM employees
	JOIN dept_emp
		ON dept_emp.emp_no = employees.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	WHERE dept_emp.to_date = '9999-01-01'
	GROUP BY departments.dept_no
	ORDER BY departments.dept_no;
	
/* 7. Which department has the highest average salary? Hint: Use current not historic information */
SELECT departments.dept_name, AVG(salaries.salary)
FROM salaries
-- JOIN employees
-- ON employees.emp_no = salaries.emp_no
JOIN dept_emp
ON dept_emp.emp_no = salaries.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date = '9999-01-01' AND dept_emp.to_date LIKE '999%'
GROUP BY departments.dept_name
ORDER BY AVG(salaries.salary) DESC
LIMIT 1;

/* 8. Who is the highest paid employee in the Marketing department? */

SELECT e.first_name, e.last_name
FROM employees AS e
	JOIN salaries
		ON salaries.emp_no = e.emp_no
	JOIN dept_emp
		ON dept_emp.emp_no = salaries.emp_no
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	WHERE departments.dept_name = 'Marketing' AND salaries.to_date LIKE '9999%'
	ORDER BY salaries.salary DESC
	
	LIMIT 1;
	
/* 9. Which current department manager has the highest salary? */

SELECT first_name, last_name, dept_name, salary
FROM employees
	JOIN dept_manager
		ON dept_manager.emp_no = employees.emp_no
	JOIN departments
		ON departments.dept_no = dept_manager.dept_no
	JOIN salaries
		ON salaries.emp_no = dept_manager.emp_no
	WHERE salaries.to_date LIKE '9999%' AND dept_manager.to_date LIKE '9999%'
	ORDER BY salary DESC
	LIMIT 1;

/* 10. Determine the average salary for each department. Use all salary information and round your results. */

SELECT departments.dept_name, ROUND(AVG(salaries.salary), 0)
FROM salaries
-- JOIN employees
-- ON employees.emp_no = salaries.emp_no
JOIN dept_emp
ON dept_emp.emp_no = salaries.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date <= '9999-01-01'
GROUP BY departments.dept_name
ORDER BY AVG(salaries.salary) DESC;

/* B1. Bonus Find the names of all current employees, their department name, and their current manager's name. */

SELECT CONCAT(first_name, ' ', last_name) AS "Employee Name", dept_name AS 'Department' 
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date LIKE '9999%';

(SELECT 
CONCAT(employees.first_name, ' ', employees.last_name) AS 'Manager Name'
FROM employees
	JOIN dept_manager USING(emp_no)
		# dept_manager.emp_no = employees.emp_no
	WHERE dept_manager.to_date > CURDATE() )






