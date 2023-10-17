USE employees;
SELECT database();
SHOW tables;
-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

SELECT 
	concat(e.first_name, ' ', e.last_name)
FROM 
	(SELECT *
        FROM employees
        WHERE emp_no = 101010) thatguy
	JOIN employees e
 		ON thatguy.hire_date = e.hire_date;
-- Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT 
	t.title,
    count(*)
FROM 
	(SELECT *
		FROM employees
        WHERE first_name IN ('Aamod')) as aamod
	JOIN titles t
		ON t.emp_no = aamod.emp_no
	JOIN dept_emp de
		ON de.emp_no = t.emp_no
WHERE de.to_date = 99990101
GROUP BY t.title;

SELECT t.title,
	count(*)
FROM employees e
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
	JOIN titles t
		ON t.emp_no = de.emp_no
WHERE de.to_date = 99990101
	AND e.first_name IN ('aamod')
GROUP BY t.title;
-- Find all the titles ever held by all current employees with the first name Aamod.

SELECT *
FROM employees e
	JOIN
		(SELECT DISTINCT emp_no
			FROM dept_emp
			WHERE to_date != 99990101
			GROUP BY emp_no) as de
		ON de.emp_no = e.emp_no;
-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- ANSWER: 91479


-- Find all the current department managers that are female. List their names in a comment in your code.

-- Find all the employees who currently have a higher salary than the companie's overall, historical average salary.

-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built-in function to calculate the standard deviation.) What percentage of all salaries is this?

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- BONUS

-- Find all the department names that currently have female managers.
-- Find the first and last name of the employee with the highest salary.
-- Find the department name that the employee with the highest salary works in.

-- Who is the highest paid employee within each department.

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;