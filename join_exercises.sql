SHOW databases;
USE join_example_db;
SELECT database();
SHOW tables;
-- Use the join_example_db. 

SELECT *
FROM users;

SELECT * 
FROM roles;
-- Select all the records from both the users and roles tables.

SELECT 
	u.name,
	r.name
FROM users u
	JOIN roles r
	ON u.role_id = r.id;
    
SELECT 
	u.name,
	r.name
FROM users u
	LEFT JOIN roles r
	ON u.role_id = r.id;
    
SELECT 
	u.name,
	r.name
FROM users u
	RIGHT JOIN roles r
	ON u.role_id = r.id;
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT 
	r.name,
    count(*)
FROM users u
	JOIN roles r
	ON u.role_id = r.id
GROUP BY r.name;
-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that have the role. Hint: You will also need to use group by in the query.

SHOW databases;
USE employees;
SELECT database();
SHOW tables;
-- 1. Use the employees database.

SELECT 
	dept.dept_name 'Department Name', 
    concat(emp.first_name, ' ', emp.last_name) 'Department Manager'
FROM departments dept
	JOIN dept_manager man
		ON dept.dept_no = man.dept_no
	JOIN employees emp
		ON emp.emp_no = man.emp_no
WHERE man.to_date LIKE '9999%'
ORDER BY dept_name;
-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT 
	dept.dept_name 'Department Name', 
    concat(emp.first_name, ' ', emp.last_name) 'Department Manager'
FROM departments dept
	JOIN dept_manager man
		ON dept.dept_no = man.dept_no
	JOIN employees emp
		ON emp.emp_no = man.emp_no
WHERE man.to_date LIKE '9999%'
	AND gender = 'F'
ORDER BY dept_name;
-- 3. Find the name of all departments currently managed by women.

SELECT 
	t.title Title,
	count(*) Count
FROM titles t
	JOIN dept_emp de
		ON t.emp_no = de.emp_no
	JOIN departments d
		ON d.dept_no = de.dept_no
WHERE de.to_date LIKE '9999%'
	AND t.to_date LIKE '9999%'
	AND d.dept_name = 'Customer Service'
GROUP BY t.title
ORDER BY t.title;
-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT 
    dept.dept_name 'Department Name',
    CONCAT(emp.first_name, ' ', emp.last_name) 'Department Manager',
    s.salary Salary
FROM
    departments dept
        JOIN
    dept_manager man ON dept.dept_no = man.dept_no
        JOIN
    employees emp ON emp.emp_no = man.emp_no
        JOIN
    salaries s ON s.emp_no = emp.emp_no
WHERE
    man.to_date LIKE '9999%'
        AND s.to_date LIKE '9999%'
ORDER BY dept_name;
-- 5. Find the current salary of all current managers.

SELECT
	d.dept_no,
    d.dept_name,
    count(*) num_employees
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
WHERE de.to_date LIKE '9999%'
GROUP BY d.dept_no
ORDER BY dept_no;
-- 6. Find the number of current employees in each department.

SELECT d.dept_name,
	avg(s.salary)
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN salaries s
		ON s.emp_no = de.emp_no
WHERE de.to_date LIKE '9999%'
	AND s.to_date LIKE '9999%'
GROUP BY d.dept_name
ORDER BY avg(s.salary) DESC
LIMIT 1;
-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT 
	e.first_name,
	e.last_name
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN employees e
		ON e.emp_no = de.emp_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
WHERE s.to_date LIKE '9999%'
	AND de.to_date LIKE '9999%'
    AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;
-- 8. Who is the highest paid employee in the Marketing department?

SELECT 
	e.first_name,
    e.last_name,
    s.salary,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = e.emp_no
WHERE
    dm.to_date LIKE '9999%'
        AND s.to_date LIKE '9999%'
ORDER BY s.salary DESC
LIMIT 1;
-- 9. Which current department manager has the highest salary?

SELECT 
	d.dept_name,
	round(avg(s.salary),0)
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN salaries s
		ON s.emp_no = de.emp_no
GROUP BY d.dept_name
ORDER BY avg(s.salary) DESC;
-- 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT 
	concat(e.first_name, ' ', e.last_name),
    d.dept_name,
	current_dept_man.Department_Manager
FROM departments d
	JOIN dept_manager dm
		ON dm.dept_no = d.dept_no
	JOIN dept_emp de
		ON de.dept_no = dm.dept_no
	JOIN employees e
		ON e.emp_no = de.emp_no
	JOIN 
		(SELECT 
			dept.dept_name Department_Name, 
			concat(emp.first_name, ' ', emp.last_name) Department_Manager
		FROM departments dept
			JOIN dept_manager man
				ON dept.dept_no = man.dept_no
			JOIN employees emp
				ON emp.emp_no = man.emp_no
		WHERE man.to_date LIKE '9999%'
		ORDER BY dept_name) as current_dept_man
			ON current_dept_man.Department_Name = d.dept_name
WHERE de.to_date LIKE '9999%'
	AND dm.to_date LIKE '9999%'
;
-- Bonus: Find the names of all current employees, their department name, and their current manager's name.

SELECT 
	concat(e.first_name, ' ', e.last_name) employee_name,
	d.dept_name department,
    concat(m.first_name, ' ', m.last_name) manager_name
FROM departments d
	JOIN dept_manager dm
		ON dm.dept_no = d.dept_no
	JOIN dept_emp de
		ON de.dept_no = dm.dept_no
	JOIN employees e
		ON e.emp_no = de.emp_no
	JOIN employees m
		ON m.emp_no = dm.emp_no
WHERE de.to_date LIKE '9999%'
	AND dm.to_date LIKE '9999%';
-- Bonus: Find the names of all current employees, their department name, and their current manager's name.