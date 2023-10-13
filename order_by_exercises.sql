USE employees;
SELECT database();
SHOW tables;
DESCRIBE employees;
-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
-- In your comments, answer: What was the first and last name in the first row of the results?
	-- ANSWER: Irena Reutenauer
-- What was the first and last name of the last person in the table?
	-- ANSWER: Vidya Simmen

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
	-- ANSWER: Irena Acton
-- What was the first and last name of the last person in the table?
	-- ANSWER: Vidya Zweizig

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
	-- ANSWER: Irena Acton
-- What was the first and last name of the last person in the table?
	-- ANSWER: Maya Zyda

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no ASC;
-- Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number.
-- Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
	-- ANSWER: 899
    -- ANSWER: 10021 Ramzi Erde
    -- ANSWER: 499648 Tadahiro Erde

SELECT first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC;
-- Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
	-- ANSWER: 899
    -- ANSWER: Teiji Eldridge
    -- ANSWER: Sergi Erde

SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND (month(birth_date) = 12 AND day(birth_date) = 25)
ORDER BY birth_date ASC, hire_date DESC;
-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
	-- ANSWER: 362
	-- ANSWER: Khun Bernini
	-- ANSWER: Douadi Pettis