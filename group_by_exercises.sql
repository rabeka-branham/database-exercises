SHOW databases;
USE employees;
SELECT database();
SHOW tables;
-- Create a new file named group_by_exercises.sql

SELECT DISTINCT title 
FROM titles;
-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
-- ANSWER: 7

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;
-- Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;
-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT last_name
FROM employees
WHERE last_name LIKE '%Q%' 
	AND last_name NOT LIKE '%QU%'
GROUP BY last_name;
-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
-- ANSWER: Chleq, Lindqvist, Qiwen

SELECT last_name, count(last_name)
FROM employees
WHERE last_name LIKE '%Q%' 
	AND last_name NOT LIKE '%QU%'
GROUP BY last_name;
-- Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.

SELECT first_name, gender, count(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.

SELECT
	lower(
		concat(
			substr(first_name,1,1),
			substr(last_name,1,4),
			'_',
			substr(birth_date,6,2),
            substr(birth_date,3,2)
        )) user_name,
	count(*)
FROM employees
GROUP BY user_name;
-- Using your query that generates a username for all employees, generate a count of employees with each unique username.

SELECT
	lower(
		concat(
			substr(first_name,1,1),
			substr(last_name,1,4),
			'_',
			substr(birth_date,6,2),
            substr(birth_date,3,2)
        )) as user_name,
	count(*)
FROM employees
GROUP BY user_name
HAVING count(*) > 1
ORDER BY count(*) DESC;
-- From your previous query, are there any duplicate usernames? What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there?
-- ANSWER: yes | 6 

SELECT count(duplicates.user_name)
FROM
	(SELECT
		lower(
			concat(
				substr(first_name,1,1),
				substr(last_name,1,4),
				'_',
				substr(birth_date,6,2),
				substr(birth_date,3,2)
			)) as user_name,
		count(*)
	FROM employees
	GROUP BY user_name
	HAVING count(*) > 1
	) as duplicates;
-- Bonus: How many duplicate usernames are there?
-- ANSWER: 13251


SELECT emp_no,
	avg(salary)
FROM salaries
GROUP BY emp_no;
-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

SELECT dept_no department,
	count(*) employee_count
FROM dept_emp
WHERE to_date LIKE '9999%'
GROUP BY dept_no;
-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

SELECT emp_no,
	count(salary)
FROM salaries
GROUP BY emp_no;
-- Determine how many different salaries each employee has had. This includes both historic and current.

SELECT emp_no, 
	max(salary)
FROM salaries
GROUP BY emp_no;
-- Find the maximum salary for each employee.

SELECT emp_no, 
	min(salary)
FROM salaries
GROUP BY emp_no;
-- Find the minimum salary for each employee.

SELECT emp_no,
	stddev(salary)
FROM salaries
GROUP BY emp_no;
-- Find the standard deviation of salaries for each employee.

SELECT emp_no,
	max(salary) 
FROM salaries
GROUP BY emp_no
HAVING max(salary) > 150000;
-- Find the max salary for each employee where that max salary is greater than $150,000.

SELECT emp_no,
	avg(salary)
FROM salaries
GROUP BY emp_no
HAVING avg(salary) BETWEEN 80000 AND 90000;
-- Find the average salary for each employee where that average salary is between $80k and $90k.