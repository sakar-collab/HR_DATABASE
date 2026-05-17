Create Database HR;
Use HR;
CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
  CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(30),
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));
Select * From Departments;
Select * from employees;
Select * from job_history;
Select * from jobs;
Select * from locations;

-- SQL Comparison operators
# =checks for equality

-- Q1.	Retrieve all employees whose address is in Elgin,IL YOU HAVE TO USE WILD CARD
Select * from employees WHERE address like "%Elgin,IL%";

-- Q2 2.	Retrieve all employees in department 5 whose salary is between 60000 and 70000.
Select * from employees
where DEP_ID=5
And Salary >=60000 and salary<=70000;

-- Q3 Retrieve a list of employees ordered by department ID. ORDER BY dept_id BY DEFAULT AES ORDERS
Select * From employees
order by Dep_ID DESC;


-- Q4 For each department ID retrieve the number of employees in the department
Select Dep_ID, Count(Emp_id) As number_of_employees
From employees
Group by Dep_ID;


-- Q5 For each department retrieve the number of employees in the department, and the average employee salary in the department.
Select Dep_ID, Count(Emp_id) As number_of_employees, AVG(SALARY) as AVG_sALARY
From employees
Group by Dep_ID;



-- Q6For each department retrieve the number of employees in the department, and the average employee salary in the department and limit the result to departments with fewer than 4 employees.
Select Dep_ID, Count(Emp_id) As number_of_employees, AVG(SALARY) 
From employees
Group by Dep_ID HAVING number_of_employees<4;

Select * from Employees;
show tables;


-- Sub queries
-- Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table
Select * from jobs;
Select * from employees;

Select * from employees where Job_ID
IN(SELECT Job_ident from jobs);

-- Retrieve only the list of employees whose JOB_TITLE is Jr. Designer.
Select * from employees where Job_ID
IN(SELECT Job_ident from jobs where JOB_TITLE= 'Jr. Designer');

-- Retreive JOb information who earn salary more than 70000.

Select * from JOBs where Job_ident
In(select job_ID from employees where salary>70000);

-- Retrieve JOB information and whose birth year is after 1976.
Select * from JOBs where Job_ident
In(select job_ID from employees where YEAR(B_date)>1976);

-- Retrieve JOB information for female employees whose birth year is after 1976.
Select * from JOBs where Job_ident
In(select job_ID from employees Where Sex='F' and year(B_date)>1976);

-- 	Execute a working query using a sub-select to retrieve all employees records whose salary is lower than the average salary.
Select * from Employees
Where salary <(select Avg(salary) from employees);

-- Execute a Column Expression that retrieves all employees’ records with EMP_ID, SALARY and maximum salary as MAX_SALARY in every row.
Select * from Employees;
Select EMP_ID, SALARY,(Select Max(salary) from employees) as MAX_SALARY
from employees;

-- Write a query to find the average salary of the five least-earning employees.
Select * from employees;
Select AVG(SALARY) FROM 
(Select * from employees order by salary limit 5) as Salary_Table;


-- 4.	Write a query to find the records of employees older than the average age of all employees.
Select * from Employees;
-- SELECT * FROM EMPLOYESS
-- WHERE AGE> (SELECT AVE(AGE) FROM EMPLOYEES);
Select * from employees
where timestampdiff(YEAR,B_DATE,CURRENT_DATE)> (select AVG(TIMESTAMPDIFF(YEAR,B_DATE,CURRENT_DATE)) FROM Employees);


-- 5.	From the Job History table, display the list of Employee IDs, years of service, and average years of service for all entries.
select * from employees;
show tables;
select * from JOB_HISTORY;
select timestampdiff(year, start_date, current date);
Select EMPL_ID, 
TIMESTAMPDIFF(YEAR, START_DATE, CURRENT_DATE) AS years_OF_service,
(select AVG(TIMESTAMPDIFF(YEAR, START_DATE, CURRENT_DATE)) FROM JOB_HISTORY) as Average_years_of_service
From JOB_HISTORY;


-- JOINS

-- Select the names and job start dates of all employees who work for the department number 5.

SELECT* FROM EMPLOYEES;
SELECT* FROM JOB_HISTORY;

SELECT EMPLOYEES.F_NAME,EMPLOYEES.L_NAME,JOB_HISTORY.START_DATE
FROM EMPLOYEES
INNER JOIN JOB_HISTORY ON EMPLOYEES.EMP_ID=JOB_HISTORY.EMPL_ID
WHERE Employees.DEP_ID=5;


SELECT E.F_NAME, E.L_NAME, JH.START_DATE
FROM EMPLOYEES AS E
INNER JOIN JOB_HISTORY AS JH ON E.EMP_ID = JH.EMPL_ID
WHERE E.DEP_ID=5;

-- Select the names, job start dates, and job titles of all employees who work for the department number 5.

SELECT* FROM EMPLOYEES;
SELECT* FROM JOBS;
SELECT* FROM JOb_history;

Select E.F_NAME,E.L_NAME,JH.START_DATE, J.JOB_TITLE
fROM EMPLOYEES AS E
INNER JOIN JOB_HISTORY AS JH ON E.EMP_ID=JH.EMPL_ID
INNER JOIN JOBS AS J ON J.JOB_IDENT=JH.JOBS_ID
WHERE E.DEP_ID=5;

-- Perform a Left Outer Join on the EMPLOYEES and DEPARTMENT tables and select employee id, last name, department id and department name for all employees.
select* from employees;
Select* from departments;
Select E.EMP_ID, E.L_NAME,E.DEP_ID,D.DEP_NAME
FROM  EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP;

 -- Re-write the previous query but limit the result set to include only the rows for employees born before 1980
Select E.EMP_ID, E.L_NAME,E.DEP_ID,D.DEP_NAME,E.B_DATE
FROM  EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP
WHERE year(E.B_DATE)<1980;

-- Re-write the previous query but have the result set include all the employees but department names for only the employees who were born before 1980.
SELECT E.EMP_ID, E.L_NAME,E.DEP_ID,D.DEP_NAME,E.B_DATE
FROM  EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP
AND  year(E.B_DATE)<1980 ;

-- Perform a Full Join on the EMPLOYEES and DEPARTMENT tables and select the First name, Last name and Department name of all employees.
SELECT * FROM EMPLOYEES;
Select* from departments;
SELECT E.F_NAME,E.L_NAME,D.DEP_NAME
FROM EMPLOYEES AS E
LEFT JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP
UNION
SELECT E.F_NAME,E.L_NAME,D.DEP_NAME
FROM EMPLOYEES AS E
RIGHT JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP;

-- Re-write the previous query but have the result set include all employee names but department id and department names only for male employees.
SELECT E.F_NAME,E.L_NAME,D.DEP_NAME
FROM EMPLOYEES AS E
LEFT JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP
AND SEX='M'
UNION
SELECT E.F_NAME,E.L_NAME,D.DEP_NAME
FROM EMPLOYEES AS E
RIGHT JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP
AND SEX='M';s