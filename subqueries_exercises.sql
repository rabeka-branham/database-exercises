USE employees;
SELECT database();
SHOW tables;

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;
-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:
        
SELECT concat(first_name, ' ', last_name)
FROM employees
WHERE hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010);
-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT 
	t.title,
    count(*)
FROM titles t
	JOIN dept_emp de
		ON de.emp_no = t.emp_no
        AND de.to_date > NOW()
	JOIN (
			SELECT *
			FROM employees
			WHERE first_name IN ('Aamod')
			) aamod
        ON aamod.emp_no = de.emp_no
GROUP BY t.title;

SELECT t.title,
	count(*)
FROM employees e
	JOIN dept_emp de
		ON e.emp_no = de.emp_no
        AND e.first_name IN ('aamod')
        AND de.to_date = 99990101
	JOIN titles t
		ON t.emp_no = de.emp_no
GROUP BY t.title;
-- Find all the titles ever held by all current employees with the first name Aamod.

SELECT count(*)
FROM employees e
	JOIN
			(
            SELECT  
				emp_no, 
				max(to_date) to_date
			FROM dept_emp
            GROUP BY emp_no
            ) as de
		ON de.emp_no = e.emp_no
		AND de.to_date < now();
-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- ANSWER: 59900

SELECT concat(f.first_name, ' ', f.last_name)
FROM 	
	(
	SELECT *
	FROM employees
	WHERE GENDER = 'F'
	) f
		JOIN dept_manager dm
			ON dm.emp_no = f.emp_no
			AND dm.to_date > now();
-- Find all the current department managers that are female. List their names in a comment in your code.
-- ANSWER: Isamu Legleitner, Karsten Sigstam, Leon DasSarma, & Hilary Kambil

SELECT *
FROM employees e
	JOIN salaries s
    ON e.emp_no = s.emp_no
    AND s.to_date > now()
WHERE s.salary > 
	(
	SELECT AVG(salary)
	FROM salaries
    );   
-- Find all the employees who currently have a higher salary than the companie's overall, historical average salary.

SELECT count(salary) -- 83
FROM salaries 
WHERE 
	to_date > now() 
	AND salary >= 
		(
		SELECT max(salary) - stddev(salary)
		FROM salaries
		WHERE to_date > now()
		);

SELECT CONCAT((
	(SELECT count(salary)
	FROM salaries 
	WHERE 
		to_date > now()
		AND salary >= 
			(
			SELECT max(salary) - stddev(salary)
			FROM salaries
			WHERE to_date > now()
			)
	) / 
    (
    SELECT count(*) 
    FROM salaries
	WHERE to_date > now() 
    ) * 100),'%') Percentage;
-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built-in function to calculate the standard deviation.) What percentage of all salaries is this?

-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- BONUS

SELECT d.dept_name Departments
FROM departments d
	JOIN dept_manager dm
		ON d.dept_no = dm.dept_no
	JOIN 
		(SELECT *
		FROM employees 
		WHERE gender = 'F') f
	ON dm.emp_no = f.emp_no
    AND dm.to_date > now()
ORDER BY Departments;
-- Find all the department names that currently have female managers.

SELECT 
	e.first_name 'First Name',
	e.last_name 'Last Name'
FROM employees e
	JOIN salaries s
		ON e.emp_no = s.emp_no
        AND s.to_date > now()
ORDER BY salary DESC
LIMIT 1;

SELECT 
	e.first_name 'First Name',
	e.last_name 'Last Name'
FROM employees e
	JOIN 
		( 
		SELECT emp_no, max(salary) max
		FROM salaries
		GROUP BY emp_no) s
        ON s.emp_no = e.emp_no
ORDER BY s.max DESC
LIMIT 1;
-- Find the first and last name of the employee with the highest salary.

SELECT 
	d.dept_name Department,
	e.first_name 'First Name',
    e.last_name 'Last Name'
FROM departments d
	JOIN dept_emp de
		USING (dept_no)
    JOIN employees e
		USING (emp_no)
	JOIN 
		(select 
			emp_no,
			max(salary) max
		FROM salaries
        WHERE to_date > now()
        GROUP BY emp_no
        ) s
        USING (emp_no)
ORDER BY s.max DESC
LIMIT 1;
-- Find the department name that the employee with the highest salary works in.

SELECT 
	d.dept_name Department,
	e.first_name 'First Name',
    e.last_name 'Last Name',
    s.max
FROM departments d
	JOIN dept_emp de
		USING (dept_no)
    JOIN employees e
		USING (emp_no)
	JOIN 
		(select 
			emp_no,
			max(salary) max
		FROM salaries
        WHERE to_date > now()
        GROUP BY emp_no
        ) s
        USING (emp_no)
GROUP BY Department
ORDER BY s.max DESC;
;

SELECT *
FROM departments 
	JOIN 

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;
-- Who is the highest paid employee within each department.