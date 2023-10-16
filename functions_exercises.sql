SHOW databases;
USE employees;
SELECT database();
SHOW tables;
-- You may choose to copy the order by exercises and save it as functions_exercises.sql, to save time as you will be editing the queries to answer your functions exercises.

SELECT
 	concat(first_name, ' ', last_name) full_name
FROM employees
WHERE last_name LIKE 'E%E';
-- Write a query to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

SELECT 
	upper(concat(first_name, ' ', last_name))
FROM employees
WHERE last_name LIKE 'E%E';
-- Convert the names produced in your last query to all uppercase.

SELECT 
	count(concat(first_name, ' ', last_name))
FROM employees
WHERE last_name LIKE 'E%E';
-- Use a function to determine how many results were returned from your previous query.

SELECT 
	first_name,
    last_name,
    hire_date,
    datediff(now(), hire_date) days_since_hired
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25';
-- Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT 
	MIN(salary) smallest,
    MAX(salary) largest
FROM salaries;
-- Find the smallest and largest current salary from the salaries table.

SELECT
	lower(
		concat(
			substr(first_name,1,1),
			substr(last_name,1,4),
			'_',
			substr(birth_date,6,2),
            substr(birth_date,3,2)
        )) as user_name,
	first_name,
    last_name,
    birth_date
FROM employees;
-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like: