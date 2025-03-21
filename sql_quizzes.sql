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

/*We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
Then print these values as  space-separated integers.*/
SELECT MAX(salary*months), COUNT(*) FROM EMPLOYEE
WHERE salary*months = (SELECT MAX(salary*months) FROM EMPLOYEE);

/*Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than .
Truncate your answer to  decimal places.*/
SELECT TRUNCATE(SUM(LAT_N), 4)
FROM STATION 
WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

/*Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to  decimal places.*/
SELECT MAX(TRUNCATE(LAT_N, 4)) FROM STATION
WHERE LAT_N < 137.2345;

/*Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to  decimal places.*/
SELECT ROUND(LONG_W,4) FROM STATION
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION 
               WHERE LAT_N < 137.2345);

/*Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to  decimal places.*/
SELECT ROUND(MIN(LAT_N), 4) FROM STATION
WHERE LAT_N > 38.7880;

/*Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than . Round your answer to  decimal places.*/
SELECT ROUND(LONG_W, 4) FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION
               WHERE LAT_N > 38.7880);

/*Consider P1(a, b) and P2(c, d) to be two points on a 2D plane.

 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 bhappens to equal the minimum value in Western Longitude (LONG_W in STATION).
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.*/

SELECT ROUND(ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)), 4);

/*Consider  and  to be two points on a 2D plane where  are the respective minimum and maximum values of Northern Latitude (LAT_N) and  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.*/
SELECT TRUNCATE( 
    SQRT (
        POWER(MAX(LAT_N) - MIN(LAT_N),2) + POWER(MAX(LONG_W) - MIN(LONG_W),2)
    ), 4) 
FROM STATION;

/*Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.*/
SELECT SUM(ci.POPULATION) FROM CITY as ci INNER JOIN COUNTRY as ct ON
ci.COUNTRYCODE = ct.CODE WHERE ct.CONTINENT = 'ASIA';


/*Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.*/
SELECT ci.NAME FROM CITY as ci INNER JOIN COUNTRY as ct ON
ci.COUNTRYCODE = ct.CODE WHERE ct.CONTINENT = 'AFRICA';

/*Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.*/\
SELECT ct.CONTINENT, FLOOR(AVG(ci.POPULATION)) AS av FROM CITY AS ci INNER JOIN COUNTRY AS ct
ON ci.COUNTRYCODE = ct.CODE
GROUP BY ct.CONTINENT ORDER BY av ASC

/*Ketty gives Eve a task to generate a report containing three 
columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade 
lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. 
If there is more than one student with the same grade (8-10) assigned to them, order those 
particular students by their name alphabetically. Finally, if the grade is lower than 8, use 
"NULL" as their name and list them by their grades in descending order. 
If there is more than one student with the same grade (1-7) assigned to them, 
order those particular students by their marks in ascending order.*/

SELECT 
    CASE
        WHEN gr.grade >= 8 THEN st.NAME
        ELSE 'NULL'
    END AS Stu_Name, gr.GRADE, st.MARKS 
FROM STUDENTS AS st JOIN GRADES AS gr ON st.marks BETWEEN gr.MIN_MARK AND gr.MAX_MARK
ORDER BY gr.GRADE DESC, Stu_Name ASC, st.MARKS ASC