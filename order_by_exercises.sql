
/* Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.*/
SHOW DATABASES;
USE employees;
/*
Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? 

The first person was Irena Reutenauer and the last person was Vidya Simmen IT seems that they just ordered the names by the first one in came across in that instance of first name*/
DESCRIBE employees;
SELECT first_name, last_name FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;

/*
Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? 

 This orders the names by first name, then alphabetically last name so all the Irenas in order, then all the Mayas and finally the Vidyas
First name in the list was Irena Acton and last was Vidya Zweizig*/
SELECT first_name, last_name FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name, last_name;

/*
Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? 

This organizes the list alphabetically by last name regardless of what first name was but still only found requested first name - First name was Acton, Irena. Last name Zyda, Maya*/
SELECT last_name, first_name FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name, first_name;

/*
Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.*/
SELECT last_name, first_name, emp_no FROM employees
WHERE RIGHT(last_name, 1) IN ('e') AND LEFT(last_name, 1) IN ('e') ORDER BY emp_no;
-- 899/  10021 Ramzi Erde and  499648 Tadahiro Erde

/*
Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.*/
SELECT last_name, first_name, hire_date FROM employees
WHERE RIGHT(last_name, 1) IN ('e') AND LEFT(last_name, 1) IN ('e') ORDER BY hire_date DESC;
-- 899 / Teiji Eldridge - newest / Sergi Erde - oldest

/*
Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.*/
SELECT * FROM `employees`
WHERE birth_date LIKE '%-12-25%'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31' ORDER by birth_date ASC, hire_date DESC;
-- 362 / oldest hired last Khun Bernini/ youngest hired first Douadi Pettis