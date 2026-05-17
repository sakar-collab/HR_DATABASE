# HR Database SQL Project

## Overview

This project contains a sample Human Resources (HR) database built using SQL. It demonstrates core database concepts including:

* Database creation
* Table creation
* Primary keys
* SQL queries
* Filtering and sorting
* Aggregate functions
* Subqueries
* Joins

The project is useful for beginners learning SQL and relational database concepts.

---

# Database Structure

The database created in this project is called:

```sql
CREATE DATABASE HR;
```

## Tables Included

| Table Name  | Description                         |
| ----------- | ----------------------------------- |
| EMPLOYEES   | Stores employee information         |
| JOB_HISTORY | Stores employee job history         |
| JOBS        | Stores job titles and salary ranges |
| DEPARTMENTS | Stores department information       |
| LOCATIONS   | Stores department locations         |

---

# Features Demonstrated

## Table Creation

The project includes SQL scripts for creating relational database tables with:

* Primary keys
* Data types
* Relationships

Example:

```sql
CREATE TABLE EMPLOYEES (
    EMP_ID CHAR(9) NOT NULL,
    F_NAME VARCHAR(15) NOT NULL,
    L_NAME VARCHAR(15) NOT NULL,
    SALARY DECIMAL(10,2),
    DEP_ID CHAR(9) NOT NULL,
    PRIMARY KEY (EMP_ID)
);
```

---

# SQL Concepts Covered

## 1. Filtering Data

Using:

* `WHERE`
* `LIKE`
* `BETWEEN`

Example:

```sql
SELECT *
FROM EMPLOYEES
WHERE ADDRESS LIKE "%Elgin,IL%";
```

---

## 2. Sorting Results

Using:

* `ORDER BY`

Example:

```sql
SELECT *
FROM EMPLOYEES
ORDER BY DEP_ID DESC;
```

---

## 3. Aggregate Functions

Using:

* `COUNT()`
* `AVG()`
* `GROUP BY`
* `HAVING`

Example:

```sql
SELECT DEP_ID,
       COUNT(EMP_ID) AS NUMBER_OF_EMPLOYEES,
       AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID;
```

---

## 4. Subqueries

Examples include:

* Employees earning below average salary
* Employees with specific job titles
* Employees born after a certain year

Example:

```sql
SELECT *
FROM EMPLOYEES
WHERE SALARY < (
    SELECT AVG(SALARY)
    FROM EMPLOYEES
);
```

---

## 5. Joins

The project demonstrates:

* INNER JOIN
* LEFT JOIN
* FULL OUTER JOIN simulation using UNION

Example:

```sql
SELECT E.F_NAME,
       E.L_NAME,
       JH.START_DATE
FROM EMPLOYEES AS E
INNER JOIN JOB_HISTORY AS JH
ON E.EMP_ID = JH.EMPL_ID;
```

---

# How to Run

## Requirements

* MySQL Workbench
  or
* Any SQL database system that supports MySQL syntax

---

## Steps

1. Open your SQL editor
2. Copy the SQL script
3. Run the script
4. Execute the example queries

---

# Learning Outcomes

By working through this project, you will learn:

* Relational database design
* Writing SQL queries
* Using joins and subqueries
* Data filtering and aggregation
* Basic database management

---

# Project Purpose

This project was created for SQL practice and learning database fundamentals. It can also be used as:

* A beginner SQL portfolio project
* A university assignment reference
* SQL interview preparation
* Practice for data analyst or business analyst roles

---

# Author

Sakar Shah
