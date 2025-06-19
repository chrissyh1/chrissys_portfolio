sql_ladder_challenge_pt3
SELECT 
    strftime('%Y', date) AS Year,
    strftime('%m', date) AS Month,
    AVG(open) AS avg_open,
    AVG(high) AS avg_high,
    AVG(low) AS avg_low,
    AVG(close) AS avg_close,
    SUM(volume) AS total_volume
FROM yum
GROUP BY Year, Month
ORDER BY Year ASC, Month ASC;

CREATE VIEW yum_by_month AS
SELECT 
    strftime('%Y', date) AS Year,
    strftime('%m', date) AS Month,
    AVG(open) AS avg_open,
    AVG(high) AS avg_high,
    AVG(low) AS avg_low,
    AVG(close) AS avg_close,
    SUM(volume) AS total_volume
FROM yum
GROUP BY Year, Month
ORDER BY Year ASC, Month ASC;
CREATE VIEW trans_by_month AS
SELECT 
    strftime('%Y', date) AS Year,
    strftime('%m', date) AS Month,
    SUM(sales) AS total_sales
FROM transactions
GROUP BY Year, Month;
CREATE VIEW trans_by_employee AS
SELECT 
    employee_id,
    SUM(sales) AS total_sales
FROM transactions
GROUP BY employee_id;

WITH pet_initials AS (
    SELECT LOWER(SUBSTR(name, 1, 1)) AS first_initial
    FROM pets
)
SELECT first_initial, COUNT(*) AS count
FROM pet_initials
GROUP BY first_initial
ORDER BY count DESC
LIMIT 1;
WITH employee_info AS (
    SELECT 
        firstname || ' ' || lastname AS name,
        job,
        salary,
        strftime('%Y', hire_date) AS year
    FROM employees
)
SELECT 
    name || ' started in ' || year || ' and makes $' || 
    printf("%.0f", salary) || ' working in ' || 
    CASE 
        WHEN job = 'IT' THEN job
        ELSE LOWER(job)
    END || '.' 
FROM employee_info;

WITH company_types AS (
    SELECT 
        CASE 
            WHEN INSTR(company_name, 'LLC') > 0 THEN 'LLC'
            WHEN INSTR(company_name, 'Inc') > 0 THEN 'Inc'
            WHEN INSTR(company_name, 'Ltd') > 0 THEN 'Ltd'
            WHEN INSTR(company_name, 'PLC') > 0 THEN 'PLC'
            ELSE 'Other'
        END AS company_type,
        sales
    FROM transactions
)
SELECT 
    company_type, 
    SUM(sales) AS total_revenue,
    COUNT(*) AS transaction_count
FROM company_types
GROUP BY company_type;

SELECT 
    employees.firstname, employees.lastname, transactions.sales
FROM employees
JOIN transactions ON employees.employee_id = transactions.employee_id;

SELECT 
    employees.firstname, employees.lastname, SUM(transactions.sales) AS total_sales
FROM employees
JOIN transactions ON employees.employee_id = transactions.employee_id
GROUP BY employees.employee_id
ORDER BY total_sales DESC
LIMIT 1;
SELECT 
    employees.firstname, employees.lastname, trans_by_employee.total_sales
FROM employees
JOIN trans_by_employee ON employees.employee_id = trans_by_employee.employee_id
ORDER BY trans_by_employee.total_sales DESC
LIMIT 1;
WITH employee_sales AS (
    SELECT 
        employee_id, 
        SUM(sales) AS total_sales
    FROM transactions
    GROUP BY employee_id
)
SELECT 
    employees.firstname, employees.lastname, employee_sales.total_sales
FROM employees
JOIN employee_sales ON employees.employee_id = employee_sales.employee_id
ORDER BY employee_sales.total_sales DESC
LIMIT 1;
SELECT 
    employees.firstname, employees.lastname, SUM(transactions.sales) AS total_sales, employees.salary
FROM employees
JOIN transactions ON employees.employee_id = transactions.employee_id
GROUP BY employees.employee_id
HAVING total_sales > 1.5 * employees.salary;
SELECT 
    transactions.transaction_id, transactions.date, transactions.sales, employees.firstname, employees.lastname
FROM transactions
JOIN employees ON transactions.employee_id = employees.employee_id
WHERE transactions.date < employees.hire_date;
SELECT 
    strftime('%Y', transactions.date) AS year,
    strftime('%m', transactions.date) AS month,
    SUM(transactions.sales) AS company_revenue,
    SUM(yum.volume) AS yum_trade_volume
FROM transactions
JOIN yum ON strftime('%Y-%m', transactions.date) = strftime('%Y-%m', yum.date)
GROUP BY year, month;

SELECT 
    strftime('%Y', transactions.date) AS year,
    strftime('%m', transactions.date) AS month,
    SUM(transactions.sales) AS company_revenue,
    SUM(yum.volume) AS yum_trade_volume,
    MIN(yum.low) AS lowest_price,
    MAX(yum.high) AS highest_price
FROM transactions
JOIN yum ON strftime('%Y-%m', transactions.date) = strftime('%Y-%m', yum.date)
GROUP BY year, month;
