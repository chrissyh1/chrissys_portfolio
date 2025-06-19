1: Query all the data in the `pets` table
SELECT *
FROM pets;

2: Query only the first 5 rows of the `pets` table
SELECT *
FROM pets
LIMIT 5;

3: Query only the names and ages of the pets in the `pets` table
SELECT name, age
FROM pets;

4: Query the pets in the `pets` table, sorted youngest to oldest
SELECT *
FROM pets
ORDER BY age ASC;

5: Query the pets in the `pets` table alphabetically
SELECT *
FROM pets
ORDER BY name ASC;

6: Query all the male pets in the `pets` table
SELECT *
FROM pets
WHERE sex = 'Male';

7: Query all the cats in the `pets` table
SELECT *
FROM pets
WHERE species = 'Cat';

8: Query all the pets in the `pets` table that are at least 5 years old
SELECT *
FROM pets
WHERE age >= 5;

9: Query all the male dogs in the `pets` table. Do not include the sex or species column
SELECT name, age
FROM pets
WHERE sex = 'Male' AND species = 'Dog';

10: Get all the names of the dogs in the `pets` table that are younger than 5 years old
SELECT name
FROM pets
WHERE species = 'Dog' AND age < 5;

11: Query all the pets in the `pets` table that are either male dogs or female cats
SELECT *
FROM pets
WHERE (sex = 'Male' AND species = 'Dog') OR (sex = 'Female' AND species = 'Cat');

12: Query the five oldest pets in the `pets` table
SELECT *
FROM pets
ORDER BY age DESC
LIMIT 5;

13: Get the names and ages of all the female cats in the `pets` table sorted by age, descending
SELECT name, age
FROM pets
WHERE sex = 'Female' AND species = 'Cat'
ORDER BY age DESC;

14: Get all pets from `pets` whose names start with P
SELECT *
FROM pets
WHERE name LIKE 'P%';

15: Select all employees from `employees_null` where the salary is missing
SELECT *
FROM employees_null
WHERE salary IS NULL;

16: Select all employees from `employees_null` where the salary is below $35,000 or missing
SELECT *
FROM employees_null
WHERE salary < 35000 OR salary IS NULL;

17: Select all employees from `employees_null` where the job title is missing
SELECT *
FROM employees_null
WHERE job_title IS NULL;

18: Who is the newest employee in `employees`? The most senior?
-- Newest employee
SELECT *
FROM employees
ORDER BY hire_date DESC
LIMIT 1;

-- Most senior employee
SELECT *
FROM employees
ORDER BY hire_date ASC
LIMIT 1;

19: Select all employees from `employees` named Thomas
SELECT *
FROM employees
WHERE name = 'Thomas';

20: Select all employees from `employees` named Thomas or Shannon
SELECT *
FROM employees
WHERE name IN ('Thomas', 'Shannon');

21: Select all employees from `employees` named Robert, Lisa, or any name that begins with a J, but not in sales
SELECT *
FROM employees
WHERE (name IN ('Robert', 'Lisa') OR name LIKE 'J%')
  AND department != 'Sales';
