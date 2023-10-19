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
        
SELECT *
FROM employees e
	JOIN dept_emp de
    ON e.emp_no = de.emp_no
    AND de.to_date > now()
WHERE hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010);
-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT DISTINCT title
FROM titles
WHERE emp_no IN 
	(
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
    )
    AND to_date > now();
-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT *
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
        
-- REVIEW CODE:
SELECT count(*)
FROM employees 
WHERE emp_no NOT IN
	(
    SELECT emp_no
    FROM dept_emp
    WHERE to_date > now()
    );
-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
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
            
-- REVIEW CODE:
SELECT *
FROM employees
WHERE gender = 'F'
	AND emp_no IN
		(
        SELECT emp_no
		FROM dept_manager
		WHERE to_date > now()
        );
-- 4. Find all the current department managers that are female. List their names in a comment in your code.
-- ANSWER: Isamu Legleitner, Karsten Sigstam, Leon DasSarma, & Hilary Kambil

SELECT count(*)
FROM salaries 
WHERE 
	to_date > now()
    AND salary > 
		(
		SELECT AVG(salary)
		FROM salaries
		);
-- 5. Find all the employees who currently have a higher salary than the companie's overall, historical average salary.

SELECT count(*) -- 83
FROM salaries 
WHERE 
	to_date > now() 
	AND salary >= 
		(
		SELECT max(salary) - stddev(salary)
		FROM salaries
		WHERE to_date > now()
		);
	
SELECT CONCAT(( -- .0346%
	(SELECT count(*)
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