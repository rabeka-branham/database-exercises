USE employees;
SELECT database();
SHOW tables;
DESCRIBE employees;
-- Create a new SQL script named limit_exercises.sql.

-- MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
	-- SELECT DISTINCT title FROM titles;

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;
-- List the first 10 distinct last names sorted in descending order.
	-- ANSWER: Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, & Zongker

SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND (month(birth_date) = 12 AND day(birth_date) = 25)
ORDER BY hire_date ASC
LIMIT 5;
-- Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
	-- ANSWER: Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, & Petter Stroustrup

SELECT *
FROM employees
WHERE hire_date BETWEEN 19900101 AND 19991231
	AND (month(birth_date) = 12 AND day(birth_date) = 25)
ORDER BY hire_date ASC
LIMIT 5 OFFSET 45;
-- Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
	-- ANSWER: Pranay Narwekar, Marjo Farrow, Ennio Karcich, Dines Lubachevsky, & Ipke Fontan

-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
	-- ANSWER: LIMIT X (PAGE # - 1) = OFFSET