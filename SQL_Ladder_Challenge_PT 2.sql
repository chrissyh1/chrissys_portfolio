# SQL Ladder Challenge PT 2
SELECT * FROM table_name;
SELECT column1, column2 FROM table_name;
SELECT * FROM table_name WHERE column_name = 'value';
SELECT * FROM table_name ORDER BY column_name;
SELECT * FROM table_name ORDER BY column_name DESC;
SELECT COUNT(*) FROM table_name;
SELECT DISTINCT column_name FROM table_name;
SELECT SUM(column_name) FROM table_name;
SELECT AVG(column_name) FROM table_name;
SELECT MAX(column_name) FROM table_name;
SELECT MIN(column_name) FROM table_name;
SELECT column_name, COUNT(*) FROM table_name GROUP BY column_name;
SELECT column_name, COUNT(*) FROM table_name GROUP BY column_name HAVING COUNT(*) > 5;
SELECT * 
FROM table1 
JOIN table2 
ON table1.column_name = table2.column_name;
UPDATE table_name 
SET column_name = 'new_value' 
WHERE column_name = 'old_value';
DELETE FROM table_name WHERE column_name = 'value';
INSERT INTO table_name (column1, column2) 
VALUES ('value1', 'value2');
SELECT * FROM table_name LIMIT 5;