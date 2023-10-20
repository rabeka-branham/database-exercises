use ursula_2332;
USE employees;
-- Create a file named temporary_tables.sql to do your work for this exercise.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT
	first_name
    , last_name
    , dept_name
FROM employees.employees e
	JOIN employees.dept_emp de
		ON e.emp_no = de.emp_no
        AND de.to_date > now()
	JOIN employees.departments d
		USING (dept_no);
-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
        
ALTER TABLE employees_with_departments ADD COLUMN full_name VARCHAR(30);
	-- a. 	Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

UPDATE employees_with_departments SET full_name = CONCAT(first_name,' ',last_name);
	-- b.	Update the table so that the full_name column contains the correct data.

ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;
	-- c. 	Remove the first_name and last_name columns from the table.

CREATE TEMPORARY TABLE employees_with_departments_2 AS									
SELECT
    dept_name
    , CONCAT(first_name,' ',last_name)
FROM employees.employees e
	JOIN employees.dept_emp de
		ON e.emp_no = de.emp_no
        AND de.to_date > now()
	JOIN employees.departments d
		USING (dept_no);
	-- d. 	What is another way you could have ended up with this same table?	

CREATE TEMPORARY TABLE sakila_payment_2 AS		-- Q2:A1
SELECT
	payment_id
    , customer_id
    , staff_id
    , rental_id
    , round((amount * 100),0) AS cents
    , payment_date
    , last_update
FROM sakila.payment;

SELECT * FROM sakila_payment_2;

CREATE TEMPORARY TABLE sakila_payment AS		-- Q2:A2
SELECT *
FROM sakila.payment;

ALTER TABLE sakila_payment MODIFY amount DEC(10,2);

UPDATE sakila_payment SET amount = (amount * 100);

ALTER TABLE sakila_payment MODIFY amount INT;

SELECT * FROM sakila_payment;        
-- 2. Create a temporary table based on the payment table from the sakila database.
		-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.



-- 3. Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?
    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved







-- Returns the current z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
    SELECT salary,
        (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
    FROM salaries
    WHERE to_date > now();
    


CREATE TEMPORARY TABLE overall_avg_and_std AS
SELECT
	avg(salary)
    , std(salary)
FROM employees.salaries
WHERE to_date > now();

CREATE TEMPORARY TABLE dept_avgs AS
SELECT
	dept_name
    , avg(salary)
FROM employees.departments d
	JOIN employees.dept_emp de
		ON d.dept_no = de.dept_no
        AND de.to_date > now()
	JOIN employees.salaries s
		on de.emp_no = s.emp_no
        AND s.to_date > now()
GROUP BY dept_name;

SELECT * FROM overall_avg_and_std;
SELECT * FROM dept_avgs;

ALTER TABLE dept_avgs ADD overall_avg FLOAT(10,2);
ALTER TABLE dept_avgs ADD overall_std FLOAT(10,2);
ALTER TABLE dept_avgs ADD zscore FLOAT(10,2);

UPDATE dept_avgs SET overall_avg = (avg(salary) FROM overall_avg_and_std);