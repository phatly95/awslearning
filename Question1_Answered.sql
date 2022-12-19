--Display all the information of the Employee table.
SELECT * FROM cards_ingest.emp;
--Display unique Department names from Employee table.
SELECT DISTINCT job FROM cards_ingest.emp;
--List the details of the employees in ascending order of their salaries.
SELECT ename,job, sal FROM cards_ingest.emp ORDER BY ename;
--List the employees who joined before 1981.
SELECT ename, hiredate FROM cards_ingest.emp WHERE date_part('year', hiredate) < 1981;
--List the employees who are joined in the year 1981
SELECT ename, hiredate FROM cards_ingest.emp WHERE date_part('year', hiredate) = 1981;
--List the Empno, Ename, Sal, Daily Sal of all Employees in the ASC order of AnnSal. (Note devide sal/30 as annsal)
SELECT empno, ename, sal, Round((sal/30),2) AS AnnSal
FROM cards_ingest.emp
ORDER BY AnnSal
--List the employees who are working for the department name ACCOUNTING
SELECT ename AS EmpName,
dname AS DeptName
FROM cards_ingest.dept AS dept
JOIN cards_ingest.emp AS emp ON emp.deptno = dept.deptno
WHERE dname = 'ACCOUNTING';
--List the employees who does not belong to department name ACCOUNTING
SELECT ename AS EmpName,
dname AS DeptName
FROM cards_ingest.dept AS dept
JOIN cards_ingest.emp AS emp ON emp.deptno = dept.deptno
WHERE dname <> 'ACCOUNTING';