USE employees;
SELECT database();

select 
	emp_no
    , concat(first_name, ' ', last_name) full_name
    , dept_no
    , from_date
    , to_date
	, to_date > now() current
from employees e
	JOIN dept_emp de
		USING (emp_no);
-- 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.

select 
	first_name
	, last_name 
    , CASE
		WHEN substr(last_name,1,1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN substr(last_name,1,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        ELSE 'R-Z'
	END AS alpha_group
FROM employees;
-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

select
	CASE 
		WHEN birth_date LIKE '195%' THEN '50s' 
		ELSE '60s'
    END AS decade
	, count(*)
FROM employees
GROUP BY decade;
-- 3. How many employees (current or previous) were born in each decade?
-- 1950s: 182886
-- 1960s: 117138

select 
	CASE
        WHEN dept_name = 'Research' OR dept_name = 'Development' THEN 'R&D'
        WHEN dept_name = 'Sales' OR dept_name = 'Marketing' Then 'Sales & Marketing'
        WHEN dept_name = 'Production' OR dept_name = 'Quality Management' THEN 'Prod & QM'
        WHEN dept_name = 'Finance' OR dept_name = 'Human Resources' THEN 'Finance & HR'
 		ELSE 'Customer Service'
	END Section
    , avg(salary)
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
        AND de.to_date > now()
	JOIN salaries s
		on de.emp_no = s.emp_no
        AND s.to_date > now()
GROUP BY Section;
-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select
	de.emp_no
    , de.dept_no
    , de.from_date
    , de.to_date
	, de.to_date > now() current
from dept_emp de

WHERE de.to_date = max.to_date;

select 
	e.emp_no
    , concat(first_name, ' ', last_name) full_name
    , de.dept_no
    , de.from_date
    , de.to_date
	, de.to_date > now() current
from employees e
	JOIN dept_emp de
		USING (emp_no)
	JOIN 
			(
			select emp_no
				, max(to_date) to_date
			from dept_emp
			group by emp_no
			) max
		USING (emp_no)
WHERE de.to_date = max.to_date;

-- BONUS: Remove duplicate employees from exercise 1.