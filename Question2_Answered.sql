create schema ORG;


CREATE TABLE  org.Worker (
	WORKER_ID INT ,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT,
	JOINING_DATE date,
	DEPARTMENT CHAR(25)
);

INSERT INTO org.Worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, to_date('3-12-1981','dd-mm-yyyy'), 'HR'),
		(002, 'Niharika', 'Verma', 80000,to_date('3-12-1982','dd-mm-yyyy'), 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, to_date('5-1-1980','dd-mm-yyyy'), 'HR'),
		(004, 'Amitabh', 'Singh', 500000, to_date('3-12-1980','dd-mm-yyyy'), 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, to_date('3-12-1981','dd-mm-yyyy'), 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, to_date('5-10-1981','dd-mm-yyyy'), 'Account'),
		(007, 'Satish', 'Kumar', 75000, to_date('1-1-1981','dd-mm-yyyy'), 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, to_date('3-7-1986','dd-mm-yyyy'), 'Admin');

SELECT * FROM org.Worker
--1.SQL Query to print the number of employees per department in the organization
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name" , 
    w.department AS "Department",
    COUNT(*) OVER (PARTITION BY w.department) AS "department_count"
FROM 
    org.Worker AS w
--2.SQL Query to find the employee details who got second maximum salary
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name",
    w.department AS "Department",
    w.salary,
    MAX(w.salary) OVER (PARTITION BY w.department),
    RANK() OVER (ORDER BY w.salary)
FROM org.Worker AS w

--3.SQL Query to find the employee details who got second maximum salary in each department
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name",
    w.department AS "Department",
    w.salary,
    MAX(w.salary) OVER (PARTITION BY w.department),
    RANK() OVER (ORDER BY w.salary)
FROM org.Worker AS w
--4.SQL Query to find the employee who got minimum salary in 2019
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name",
    w.department AS "Department",
    w.salary,
    MIN(w.salary) OVER (PARTITION BY w.department),
    RANK() OVER (ORDER BY w.salary)
FROM org.Worker AS w
--5.SQL query to select the employees getting salary greater than the average salary of the department that are working in
SELECT 
    *
FROM (
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name",
    w.department AS "Department",
    w.salary,
    AVG(w.salary) OVER (PARTITION BY w.department) AS sal_avg
FROM org.Worker AS w) AS sal
WHERE sal.salary > sal.sal_avg

--6.SQL query to compute the group salary of all the employees .
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name",
    w.department AS "Department",
    w.salary,
    SUM(w.salary) OVER (PARTITION BY w.department) AS sal_avg
FROM org.Worker as w
--7.SQL query to list the employees and name of employees reporting to each person.
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name",
    w.department AS "Department",
    LAG(w.first_name,1) OVER (ORDER BY w.department) AS "report_to"
FROM org.Worker as w
--8.SQL query to find the department with highest number of employees.
SELECT 
    *
FROM (
SELECT 
    CONCAT(w.first_name, ' ', w.last_name) AS "Name" , 
    w.department AS "Department",
    COUNT(*) OVER (PARTITION BY w.department) AS "department_count"
FROM 
    org.Worker AS w) AS h
WHERE (h.department_count) = 4;
