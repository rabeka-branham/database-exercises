USE employees;
SELECT database();
SHOW tables;
DESCRIBE employees;
-- Use the employees database.

SELECT emp_no, first_name
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
-- What is the employee number of the top three results?
-- ANSWER: 10200, 10397, 10610

SELECT emp_no, first_name
FROM employees 
WHERE first_name = 'Irena' 
	OR first_name = 'Vidya' 
	OR first_name = 'Maya';
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
-- What is the employee number of the top three results?
-- ANSWER: 10200, 10397, 10610
-- Does it match the previous question?
-- ANSWER: Yes

SELECT emp_no, first_name, gender
FROM employees 
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') 
	AND gender = 'M';
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
-- What is the employee number of the top three results?
-- ANSWER: 10200, 10397 10821

SELECT DISTINCT last_name 
FROM employees 
WHERE last_name LIKE 'e%';
-- Find all unique last names that start with 'E'.

SELECT DISTINCT last_name 
FROM employees 
WHERE last_name LIKE 'e%' 
	OR last_name LIKE '%e';
-- Find all unique last names that start or end with 'E'.

SELECT DISTINCT last_name 
FROM employees 
WHERE last_name LIKE '%e' 
	AND last_name NOT LIKE 'e%';
-- Find all unique last names that end with E, but does not start with E.

SELECT DISTINCT last_name 
FROM employees 
WHERE last_name LIKE 'e%' 
	AND last_name LIKE '%e';
-- Find all unique last names that start and end with 'E'.

SELECT emp_no, hire_date
FROM employees 
WHERE hire_date BETWEEN 19900101 AND 19991231;
-- Find all current or previous employees hired in the 90s. 
-- Enter a comment with the top three employee numbers.
-- ANSWER: 10008, 10011, 10012

SELECT emp_no, birth_date 
FROM employees 
WHERE month(birth_date) = 12 
	AND day(birth_date) = 25;
-- Find all current or previous employees born on Christmas. 
-- Enter a comment with the top three employee numbers.
-- ANSWER: 10078, 10115, 10261

SELECT emp_no, hire_date, birth_date 
FROM employees 
WHERE (month(birth_date) = 12 AND day(birth_date) = 25) 
	AND hire_date BETWEEN 19900101 AND 19991231;
-- Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the top three employee numbers.
-- ANSWER: 10261, 10438, 10681

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%';
-- Find all unique last names that have a 'q' in their last name.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%';
-- Find all unique last names that have a 'q' in their last name but not 'qu'.