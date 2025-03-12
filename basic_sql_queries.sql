------------------ BASIC SQL COMMANDS ---------------


 ------- CREATE, RETRIEVE, UPDATE, DELETE, ALTER-------
 ------- WHERE, ORDER BY, LIMIT, OFFSET, Comparison ------
 ------- CHECK, CONSTRAINTS ----------------------
		  
-- Create Table --
CREATE TABLE IF NOT EXISTS student_table(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
student_id VARCHAR(10) UNIQUE
);

-- Delete row from table with where clause --
DELETE FROM student_table WHERE id = 1;

-- Add column to the table with not null, default and CHECK constraint --
ALTER TABLE student_table
ADD COLUMN gender VARCHAR(10) NOT NULL DEFAULT 'N/A',
ADD COLUMN age INT CONSTRAINT check_age CHECK (age <= 18);

-- Inserting Data into table --
INSERT INTO student_table (id, name, student_id) 
VALUES
(1, 'Siddiq', 's1'),
(2, 'Jennifer', 's2'),
(3, 'Muaaz', 's3'),
(4, 'Hanzalah', 's4'),
(5, 'Sarah', 's5')

-- Updating table row with OR operator --
UPDATE student_table SET gender = 'male' WHERE 
name = 'Muaaz' OR name = 'Siddiq' 
OR name ='Hanzalah';

-- Updating table row with IN operator (IN works as OR operator but matches with list values) --
UPDATE student_table SET gender = 'female' WHERE 
name IN ('Jennifer', 'Sarah');

-- Updateing Age with simple "=" -- 
UPDATE student_table SET age = 17 WHERE 
name = 'Jennifer';

-- Selecting all --
SELECT * FROM student_table;

-- Selecting Distinct Value with limit --
SELECT DISTINCT gender FROM student_table LIMIT 2;

-- Selecting Distinct Value with offset and limit --
SELECT DISTINCT gender FROM student_table LIMIT 2 OFFSET 1;

-- Selecting specific fields only --
SELECT name, student_id FROM student_table;

-- Simple Distinct --
SELECT DISTINCT name FROM student_table;

-- Select with comparison operator --
SELECT name, student_id FROM student_table WHERE age >= 16 
AND gender = 'male';

-- Selecting age with between operator --
SELECT name, student_id FROM student_table WHERE age BETWEEN 16 AND 18; 

-- Check all the entries where age + 3 > 20 --
SELECT * FROM student_table WHERE age + 3 > 20;

-- Better use case to avoid just specific type of data --
SELECT * FROM student_table WHERE gender != 'female';

-- Better use case to avoid just multiple specific type of data --
SELECT * FROM student_table WHERE gender NOT IN ('male');

-- Order by Name (by default ASC)--
SELECT * FROM student_table ORDER BY name ASC;

-- Order by age for most aged one (top 3) --
SELECT * FROM student_table ORDER BY age DESC LIMIT 3;

-- GROUP BY CLAUSE (Make sense to use with agg func. and also the groupby column must be in the select statement) --
SELECT gender, COUNT(id) FROM student_table 
GROUP BY gender;

-- HAVING CLAUSE --
SELECT gender, COUNT(id) FROM student_table
GROUP BY gender HAVING max(age) > 17;

----------------- Aggregate Functions ---------------

-- MAX --
SELECT max(age) FROM student_table;

-- MIN --
SELECT MIN(age) FROM student_table;

-- AVG --
SELECT AVG(age) FROM student_table;

-- SUM --
SELECT SUM(age) FROM student_table;

-- COUNT --
SELECT COUNT(id) FROM student_table;