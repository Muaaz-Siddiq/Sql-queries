/* Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates. */

SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE 'a%' 
OR CITY LIKE 'e%'
OR CITY LIKE 'i%'
OR CITY LIKE 'o%'
OR CITY LIKE 'u%';

/* Query the list of CITY names ending with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates. */
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%a' 
OR CITY LIKE '%e'
OR CITY LIKE '%i'
OR CITY LIKE '%o'
OR CITY LIKE '%u';

/*Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
Your result cannot contain duplicates. */
-- In MySQL we use regex expression where ^(start), $(end), .*(match all), 'i'(case insensitve)--
SELECT DISTINCT CITY
FROM STATION
WHERE REGEXP_LIKE(CITY, '^[AEIOU].*[AEIOU]$', 'i');

-- In PostgreSQL --
SELECT DISTINCT CITY
FROM STATION
WHERE CITY SIMILAR TO '[AEIOU]%[AEIOU]';

/* Query the list of CITY names from STATION that do not start with vowels.
 Your result cannot contain duplicates. */
SELECT DISTINCT CITY
FROM STATION
WHERE NOT REGEXP_LIKE(CITY, '^[AEIOU]', 'i');

/* Query the list of CITY names from STATION that do not ends with vowels.
 Your result cannot contain duplicates. */
SELECT DISTINCT CITY
FROM STATION
WHERE NOT REGEXP_LIKE(CITY, '[AEIOU]$', 'i');

/* Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), 
secondary sort them by ascending ID. */
SELECT NAME FROM STUDENTS WHERE MARKS > 75
ORDER BY RIGHT(NAME, 3), ID;

-- In above query Right(Name, 3) slice out last three characters and ,ID provides secondary sort if there is a tie from the name and order by them.--

/* Query the average population for all cities in CITY, rounded down to the nearest integer. */
SELECT ROUND(AVG(POPULATION), 0) FROM CITY

/* Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN. */
SELECT SUM(POPULATION) AS overall_population
FROM CITY
WHERE COUNTRYCODE = 'JPN';

/*Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error 
(i.e.:  average monthly salaries), and round it up to the next integer.*/
SELECT CEIL(ROUND(AVG(SALARY) - AVG(REPLACE(SALARY, '0', '')), 2)) FROM EMPLOYEES;