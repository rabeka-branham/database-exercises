SHOW databases; -- List all the databases

USE albums_db; -- Write the SQL code necessary to use the albums_db database

SELECT database(); -- Show the currently selected database

SHOW tables; -- List all tables in the database

USE employees; -- Write the SQL code to switch to the employees database

SELECT database(); -- Show the currently selected database

SHOW tables; -- List all tables in the database

DESCRIBE employees; -- Explore the employees table. What different data types are present in this table? 
-- ANSWER: int, date, varchar(14), varchar(16), enum('M','F')

-- Which table(s) do you think contain a numeric type column?
-- ANSWER: dept_emp, dept_manager, employees, salaries, titles

-- Which table(s) do you think contain a string type column?
-- ANSWER: departments, dept_emp, dept_manager, employees, titles

-- Which table(s) do you think contain a date type column?
-- ANSWER: dept_emp, dept_manager, employees, salaries, titles

-- What is the relationship between the employees and the departments tables?
-- ANSWER: No relationship is present

SHOW CREATE TABLE dept_manager;-- Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.