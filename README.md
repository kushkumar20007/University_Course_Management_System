# 🎓 University Course Management System --- SQL Final Project

> A professional MySQL database project designed to manage **students,
> courses, instructors, enrollments, and academic departments** while
> demonstrating practical SQL concepts from CRUD to window functions and
> conditional logic.

------------------------------------------------------------------------

## 📌 Project Overview

The **University Course Management System (UCMS)** is a relational
database designed to organize university academic information.

The project demonstrates:

-   Database and table creation
-   Primary Keys and Foreign Keys
-   CRUD operations
-   `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
-   `INNER JOIN` and `LEFT JOIN`
-   Aggregate functions: `COUNT()`, `AVG()`, `MAX()`
-   `GROUP BY` and `HAVING`
-   Subqueries
-   String functions
-   Date functions
-   Window functions
-   `CASE` expressions
-   Data filtering and sorting

------------------------------------------------------------------------

## 🎯 Project Objectives

The main objectives are to:

1.  Store student information.
2.  Manage university courses.
3.  Maintain instructor records.
4.  Track student enrollments.
5.  Organize academic departments.
6.  Retrieve meaningful information using SQL queries.
7.  Apply advanced SQL logic to solve real-world database problems.

------------------------------------------------------------------------

## 🗂️ Database Structure

### Tables

  Table           Purpose
  --------------- ----------------------------------------------------
  `Students`      Stores student personal and enrollment information
  `Courses`       Stores available university courses
  `Instructors`   Stores instructor information
  `Enrollments`   Connects students with courses
  `Departments`   Stores academic department information

### 🔗 Relationship Logic

``` text
Departments
    │
    ├──────────< Courses
    │
    └──────────< Instructors

Students
    │
    └──────────< Enrollments >────────── Courses
```

### Key Relationships

-   `Courses.DepartmentID` → `Departments.DepartmentID`
-   `Instructors.DepartmentID` → `Departments.DepartmentID`
-   `Enrollments.StudentID` → `Students.StudentID`
-   `Enrollments.CourseID` → `Courses.CourseID`

This design follows a normalized relational structure and avoids storing
repeated student/course information inside the enrollment table.

------------------------------------------------------------------------

# 🧱 Database Schema

## 1. Students

  Column           Data Type      Key
  ---------------- -------------- -----
  StudentID        INT            PK
  FirstName        VARCHAR(50)    
  LastName         VARCHAR(50)    
  Email            VARCHAR(100)   
  BirthDate        DATE           
  EnrollmentDate   DATE           

## 2. Courses

  Column         Data Type      Key
  -------------- -------------- -----
  CourseID       INT            PK
  CourseName     VARCHAR(100)   
  DepartmentID   INT            FK
  Credits        INT            

## 3. Instructors

  Column         Data Type       Key
  -------------- --------------- --------------------
  InstructorID   INT             PK
  FirstName      VARCHAR(50)     
  LastName       VARCHAR(50)     
  Email          VARCHAR(100)    
  DepartmentID   INT             FK
  Salary         DECIMAL(10,2)   Optional extension

> **Important:** The original assignment asks for the maximum instructor
> salary in Query #8, but `Salary` is not listed in the original
> Instructors fields. Therefore, this README treats `Salary` as an
> additional column required for Query #8.

## 4. Enrollments

  Column           Data Type   Key
  ---------------- ----------- -----
  EnrollmentID     INT         PK
  StudentID        INT         FK
  CourseID         INT         FK
  EnrollmentDate   DATE        

## 5. Departments

  Column           Data Type      Key
  ---------------- -------------- -----
  DepartmentID     INT            PK
  DepartmentName   VARCHAR(100)   

------------------------------------------------------------------------

# ⚙️ Database Setup

## Step 1 --- Create Database

``` sql
CREATE DATABASE UniversityCourseManagement;

USE UniversityCourseManagement;
```

## Step 2 --- Create Departments

``` sql
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
```

## Step 3 --- Create Students

``` sql
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    BirthDate DATE,
    EnrollmentDate DATE
);
```

## Step 4 --- Create Courses

``` sql
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
```

## Step 5 --- Create Instructors

``` sql
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
```

## Step 6 --- Create Enrollments

``` sql
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);
```

------------------------------------------------------------------------

# 🧪 Sample Data

## Departments

``` sql
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Computer Science'),
(2, 'Mathematics');
```
<img width="790" height="130" alt="image" src="https://github.com/user-attachments/assets/f270106d-5da0-4360-ba7b-4332e4f647c2" />

## Students

``` sql
INSERT INTO university_course_management_system.student
(StudentsID, FirstName, LastName, Email, BirthDate, EnrolmentDate)
VALUES
(2, 'Rahul', 'Sharma', 'rahul@gmail.com', '2007-05-14', '2026-09-22'),
(3, 'Aman', 'Verma', 'aman@gmail.com', '2008-02-18', '2026-09-22'),
(4, 'Priya', 'Singh', 'priya@gmail.com', '2007-11-09', '2026-09-22'),
(5, 'Neha', 'Patel', 'neha@gmail.com', '2008-07-25', '2026-09-22'),
(1, 'Mohan', 'Kumar', 'mohan@gmail.com', '2005-12-02', '2025-02-22');
```
<img width="1019" height="165" alt="image" src="https://github.com/user-attachments/assets/707a8604-cede-4cd1-b7b3-83df3be45295" />

## Courses

``` sql
INSERT INTO Courses
(CourseID, CourseName, DepartmentID, Credits)
VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);
```
<img width="959" height="91" alt="image" src="https://github.com/user-attachments/assets/f1819c63-e4a6-4e9f-8992-1ba3a82e2956" />

## Instructors

``` sql
INSERT INTO Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID, Salary)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 65000.00),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 60000.00);
```
<img width="1005" height="91" alt="image" src="https://github.com/user-attachments/assets/03278c83-d694-491f-ae44-ac1d28d332e7" />

## Enrollments

``` sql
INSERT INTO Enrollments
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');
```
<img width="1007" height="110" alt="image" src="https://github.com/user-attachments/assets/28e0b839-d7b7-42e8-8c94-92122ddc87c4" />

------------------------------------------------------------------------
## 🎥 Video Demonstration

[![Watch Video](https://img.shields.io/badge/🎥-Watch_Video-red?style=for-the-badge)](video)


# 🚀 SQL Queries & Logic

## 1. Perform CRUD Operations on All Tables

### CREATE / INSERT

``` sql
INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
(3, 'Alex', 'Brown', 'alex.brown@email.com', '2001-03-12', '2023-08-01');
```

### READ

``` sql
SELECT * FROM Students;
```

### UPDATE

``` sql
UPDATE Students
SET Email = 'alex.new@email.com'
WHERE StudentID = 3;
```

### DELETE

``` sql
DELETE FROM Students
WHERE StudentID = 3;
```

The same CRUD pattern can be applied to `Courses`, `Instructors`,
`Enrollments`, and `Departments`.

------------------------------------------------------------------------

## 2. Retrieve Students Who Enrolled After 2022

### Logic

Filter `EnrollmentDate` using a date condition.

``` sql
SELECT
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate
FROM Students
WHERE EnrollmentDate >= '2022-01-01';
```
<img width="846" height="125" alt="image" src="https://github.com/user-attachments/assets/f55091e2-5510-4ef3-a0a6-c8a47440500f" />

------------------------------------------------------------------------

## 3. Retrieve Courses Offered by the Mathematics Department with LIMIT 5

### Logic

1.  Join Courses with Departments.
2.  Find `Mathematics`.
3.  Return a maximum of 5 courses.

``` sql
SELECT
    c.CourseID,
    c.CourseName,
    c.Credits,
    d.DepartmentName
FROM Courses c
INNER JOIN Departments d
    ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;
```
<img width="936" height="81" alt="image" src="https://github.com/user-attachments/assets/553f3ae6-b0b8-40ac-9f43-6596cf3b1b2e" />

------------------------------------------------------------------------

## 4. Find the Number of Students Enrolled in Each Course

Only display courses having more than 5 students.

### Logic

`COUNT()` counts students and `HAVING` filters grouped results.

``` sql
SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS TotalStudents
FROM Courses c
INNER JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 5;
```
<img width="900" height="105" alt="image" src="https://github.com/user-attachments/assets/578d74ea-1d67-48af-9f9d-1e8541bd640e" />

------------------------------------------------------------------------

## 5. Find Students Enrolled in Both Introduction to SQL and Data Structures

### Logic

A student must have enrollment records for **both courses**.

``` sql
SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;
```

------------------------------------------------------------------------

## 6. Find Students Enrolled in Either Introduction to SQL or Data Structures

### Logic

Use `IN` when either of the specified courses is acceptable.

``` sql
SELECT DISTINCT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');
```

------------------------------------------------------------------------

## 7. Calculate the Average Number of Credits for All Courses

``` sql
SELECT
    AVG(Credits) AS AverageCredits
FROM Courses;
```

### Logic

`AVG()` calculates the arithmetic mean of the `Credits` column.

------------------------------------------------------------------------

## 8. Find the Maximum Salary of Instructors in Computer Science

``` sql
SELECT
    MAX(i.Salary) AS MaximumSalary
FROM Instructors i
INNER JOIN Departments d
    ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';
```

### Logic

-   `JOIN` connects instructors with departments.
-   `WHERE` selects Computer Science.
-   `MAX()` returns the highest salary.

------------------------------------------------------------------------

## 9. Count Students Enrolled in Each Department

``` sql
SELECT
    d.DepartmentID,
    d.DepartmentName,
    COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Courses c
    ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY
    d.DepartmentID,
    d.DepartmentName;
```

### Why `LEFT JOIN`?

It keeps departments even when no student is currently enrolled in one
of their courses.

------------------------------------------------------------------------

## 10. INNER JOIN --- Retrieve Students and Their Corresponding Courses

``` sql
SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseID,
    c.CourseName,
    e.EnrollmentDate
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID;
```

### Logic

`INNER JOIN` returns only records that have matching rows in the related
tables.

------------------------------------------------------------------------

## 11. LEFT JOIN --- Retrieve All Students and Their Courses, If Any

``` sql
SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses c
    ON e.CourseID = c.CourseID;
```

### Difference from INNER JOIN

  JOIN           Result
  -------------- -----------------------------------------------------
  `INNER JOIN`   Only students having matching enrollments
  `LEFT JOIN`    All students, including students with no enrollment

------------------------------------------------------------------------

## 12. Subquery --- Students Enrolled in Courses Having More Than 10 Students

``` sql
SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students s
WHERE s.StudentID IN (
    SELECT e.StudentID
    FROM Enrollments e
    WHERE e.CourseID IN (
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);
```

### Logic

The query works from inside to outside:

``` text
1. GROUP BY CourseID
        ↓
2. Find courses with > 10 students
        ↓
3. Find StudentIDs in those courses
        ↓
4. Retrieve student details
```

------------------------------------------------------------------------

## 13. Extract the Year from Student Enrollment Date

``` sql
SELECT
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate,
    YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;
```

### Example

`2022-08-01` → `2022`

------------------------------------------------------------------------

## 14. Concatenate Instructor's First and Last Name

``` sql
SELECT
    InstructorID,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Instructors;
```

### Example

``` text
Alice + Johnson
        ↓
Alice Johnson
```

------------------------------------------------------------------------

## 15. Calculate the Running Total of Students Enrolled in Courses

A window function can calculate the cumulative enrollment count.

``` sql
SELECT
    e.EnrollmentDate,
    e.EnrollmentID,
    COUNT(*) OVER (
        ORDER BY e.EnrollmentDate, e.EnrollmentID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotalStudents
FROM Enrollments e
ORDER BY e.EnrollmentDate, e.EnrollmentID;
```

### Logic

``` text
Enrollment 1 → Running Total = 1
Enrollment 2 → Running Total = 2
Enrollment 3 → Running Total = 3
...
```

> `COUNT() OVER()` is a **window function**. Unlike `GROUP BY`, it keeps
> individual rows while also calculating an aggregate value.

------------------------------------------------------------------------

## 16. Label Students as Senior or Junior Using CASE

Requirement:

-   More than 4 years since enrollment → `Senior`
-   Otherwise → `Junior`

``` sql
SELECT
    StudentID,
    CONCAT(FirstName, ' ', LastName) AS StudentName,
    EnrollmentDate,
    CASE
        WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
            THEN 'Senior'
        ELSE 'Junior'
    END AS StudentLevel
FROM Students;
```

### CASE Logic

``` text
Enrollment older than 4 years
            ↓
         Senior

Enrollment 4 years or less
            ↓
         Junior
```

------------------------------------------------------------------------

# 🧠 Advanced SQL Concepts Used

  Concept           Used In
  ----------------- -----------------------
  `INSERT`          CRUD
  `SELECT`          All retrieval queries
  `UPDATE`          CRUD
  `DELETE`          CRUD
  `WHERE`           Q2, Q3, Q6, Q8
  `LIMIT`           Q3
  `COUNT()`         Q4, Q9, Q15
  `AVG()`           Q7
  `MAX()`           Q8
  `GROUP BY`        Q4, Q9, Q12
  `HAVING`          Q4, Q5, Q12
  `INNER JOIN`      Q3, Q8, Q10
  `LEFT JOIN`       Q9, Q11
  Subquery          Q12
  `YEAR()`          Q13
  `CONCAT()`        Q10, Q11, Q14
  Window Function   Q15
  `CASE`            Q16
  `DATE_SUB()`      Q16

------------------------------------------------------------------------

# 🔍 Important SQL Logic

## WHERE vs HAVING

``` text
WHERE
  ↓
Filters individual rows
  ↓
GROUP BY
  ↓
HAVING
  ↓
Filters grouped results
```

Example:

``` sql
WHERE DepartmentID = 1
```

filters rows **before grouping**.

``` sql
HAVING COUNT(*) > 5
```

filters groups **after grouping**.

------------------------------------------------------------------------

# 🔗 JOIN Logic

### INNER JOIN

``` text
Table A ∩ Table B
```

Only matching records.

### LEFT JOIN

``` text
All rows from Table A
+
Matching rows from Table B
```

This is useful when we want to keep students even if they have no course
enrollment.

------------------------------------------------------------------------

# 📊 Normalization Logic

The database separates information into different tables instead of
storing everything in one large table.

For example:

``` text
Students
   ↓
StudentID

Enrollments
   ↓
StudentID + CourseID

Courses
   ↓
CourseID
```

This reduces:

-   Duplicate data
-   Update anomalies
-   Insert anomalies
-   Delete anomalies

------------------------------------------------------------------------

# 🛡️ Data Integrity

The project uses:

### Primary Keys

Uniquely identify records.

``` sql
PRIMARY KEY
```

### Foreign Keys

Maintain relationships between tables.

``` sql
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID);
```

### UNIQUE

Prevents duplicate email addresses.

``` sql
Email VARCHAR(100) UNIQUE
```

### NOT NULL

Ensures required information is provided.

``` sql
FirstName VARCHAR(50) NOT NULL
```

------------------------------------------------------------------------

# ⚠️ Assignment Data Note

The provided assignment contains only a small sample dataset.

Some queries intentionally use conditions such as:

``` sql
HAVING COUNT(StudentID) > 5
```

and

``` sql
HAVING COUNT(StudentID) > 10
```

With only two sample enrollments, those queries may return **zero
rows**. That is expected.

For testing the full logic, insert additional enrollment records.

------------------------------------------------------------------------

# 🧪 Useful Verification Queries

## Check all tables

``` sql
SHOW TABLES;
```

## Check table structure

``` sql
DESCRIBE Students;
DESCRIBE Courses;
DESCRIBE Instructors;
DESCRIBE Enrollments;
DESCRIBE Departments;
```

## Check all records

``` sql
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Enrollments;
SELECT * FROM Departments;
```

------------------------------------------------------------------------

# 🛠️ Technology Stack

-   **Database:** MySQL
-   **Query Language:** SQL
-   **Database Tools:** MySQL Workbench / XAMPP / phpMyAdmin
-   **Project Type:** Relational Database Management System
-   **Domain:** University / Education Management

------------------------------------------------------------------------

# 📁 Recommended Project Structure

``` text
University-Course-Management-System/
│
├── README.md
│
├── sql/
│   ├── 01_database.sql
│   ├── 02_tables.sql
│   ├── 03_insert_data.sql
│   └── 04_queries.sql
│
└── screenshots/
    ├── database.png
    ├── tables.png
    └── query-results.png
```

------------------------------------------------------------------------

# ▶️ How to Run the Project

### 1. Open MySQL

Use MySQL Workbench, XAMPP/phpMyAdmin, or another MySQL client.

### 2. Create the database

``` sql
CREATE DATABASE UniversityCourseManagement;
USE UniversityCourseManagement;
```

### 3. Create tables

Run the table creation queries in the correct order:

``` text
Departments
      ↓
Students
      ↓
Courses
      ↓
Instructors
      ↓
Enrollments
```

### 4. Insert sample data

Run the `INSERT` queries.

### 5. Execute project queries

Run Queries #1--#16 individually and verify the results.

------------------------------------------------------------------------

# 📈 Project Learning Outcomes

After completing this project, the learner can demonstrate practical
knowledge of:

-   Relational database design
-   SQL CRUD operations
-   Database relationships
-   Primary and foreign keys
-   Data filtering
-   Aggregation
-   Grouping
-   Joins
-   Subqueries
-   Date manipulation
-   String manipulation
-   Window functions
-   Conditional expressions
-   Data integrity
-   Query optimization basics

------------------------------------------------------------------------

# 👨‍💻 Author

**Kush Kumar**

### Focus Areas

-   SQL
-   MySQL
-   Python
-   Data Analytics
-   AI / Machine Learning

------------------------------------------------------------------------

## ⭐ Project Summary

This project converts a university's academic requirements into a
structured relational database and demonstrates how SQL can be used to
**store, connect, analyze, filter, and transform data**.

> **From database design → data relationships → SQL queries → analytical
> insights.**
