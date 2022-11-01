-- CASE EXERCISES
/*
Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.*/

USE employees;

SELECT DISTINCT emp_no
FROM employees; # 300024

SELECT dept_no, emp_no, first_name, last_name,  from_date, to_date, if (to_date >= CURDATE(), True, False) AS is_current_employee
FROM employees
JOIN dept_emp USING(emp_no)

;


/*
Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/


SELECT first_name, last_name, 
CASE 
WHEN LEFT(last_name, 1) BETWEEN 'a' AND 'h' THEN 'A-H'
WHEN LEFT(last_name, 1) BETWEEN 'i' AND 'q' THEN 'I-Q'
ELSE 'R-Z'
END AS alpha_group
FROM employees;

/*
SELECT first_name, last_name, 
CASE 
WHEN LEFT(last_name, 1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
WHEN LEFT(last_name, 1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
ELSE 'R-Z'
END AS alpha_group
FROM employees;
*/

/*
How many employees (current or previous) were born in each decade?*/


SELECT COUNT(*),
CASE 
WHEN birth_date LIKE '195%' THEN 'Born_in_50s'
ELSE 'Born_in_60s'
END AS 'Decade_Born'
FROM employees
GROUP BY Decade_Born;

/*
What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/


SELECT ROUND(AVG(salary), 2) AS dept_avg,
CASE
WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
WHEN dept_name IN ('Reasearch', 'Development') THEN 'R&D'
WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
ELSE 'Customer service'
END AS department_groups
FROM departments
JOIN dept_emp USING (dept_no)
JOIN salaries USING (emp_no)
WHERE dept_emp.to_date > CURDATE()
AND salaries.to_date > CURDATE()
GROUP BY department_groups
;
