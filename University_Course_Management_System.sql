CREATE DATABASE UniversityCourseManagement;
USE UniversityCourseManagement;

-- 2.1 Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- 2.2 Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    BirthDate DATE,
    EnrollmentDate DATE
);

-- 2.3 Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    Credits INT NOT NULL,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

-- 2.4 Instructors

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    DepartmentID INT NOT NULL,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

-- 2.5 Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);



-- Departments
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

-- Students
INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');

-- Courses
INSERT INTO Courses
(CourseID, CourseName, DepartmentID, Credits)
VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);

-- Instructors
INSERT INTO Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID, Salary)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 65000.00),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 60000.00);

-- Enrollments
INSERT INTO Enrollments
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');


-- ============================================================
-- 4. BASIC VERIFICATION QUERIES
-- ============================================================

SHOW TABLES;

DESCRIBE Departments;
DESCRIBE Students;
DESCRIBE Courses;
DESCRIBE Instructors;
DESCRIBE Enrollments;

SELECT * FROM Departments;
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Enrollments;



-- 5. CRUD OPERATIONS
-- CREATE / INSERT
INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
(3, 'Alex', 'Brown', 'alex.brown@email.com', '2001-03-12', '2023-08-01');

INSERT INTO Departments
(DepartmentID, DepartmentName)
VALUES
(3, 'Physics');

INSERT INTO Courses
(CourseID, CourseName, DepartmentID, Credits)
VALUES
(103, 'Physics Fundamentals', 3, 4);

INSERT INTO Instructors
(InstructorID, FirstName, LastName, Email, DepartmentID, Salary)
VALUES
(3, 'David', 'Miller', 'david.miller@univ.com', 3, 58000.00);

INSERT INTO Enrollments
(EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES
(3, 3, 103, '2023-08-01');


-- READ
SELECT * FROM Students;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Enrollments;


-- UPDATE
UPDATE Students
SET Email = 'alex.new@email.com'
WHERE StudentID = 3;

UPDATE Courses
SET Credits = 5
WHERE CourseID = 103;

UPDATE Instructors
SET Salary = 60000.00
WHERE InstructorID = 3;

UPDATE Departments
SET DepartmentName = 'Physics & Science'
WHERE DepartmentID = 3;


-- DELETE
-- Delete the enrollment before deleting the student/course
-- because Enrollments contains foreign keys.
DELETE FROM Enrollments
WHERE EnrollmentID = 3;

DELETE FROM Students
WHERE StudentID = 3;

DELETE FROM Courses
WHERE CourseID = 103;

DELETE FROM Instructors
WHERE InstructorID = 3;

DELETE FROM Departments
WHERE DepartmentID = 3;


-- 6. PROJECT QUERY #1
-- Perform CRUD operations on all tables
-- INSERT
INSERT INTO Students
(StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
(3, 'Alex', 'Brown', 'alex.brown@email.com', '2001-03-12', '2023-08-01');

-- SELECT
SELECT * FROM Students;

-- UPDATE
UPDATE Students
SET Email = 'alex.updated@email.com'
WHERE StudentID = 3;

-- DELETE
DELETE FROM Students
WHERE StudentID = 3;



SELECT
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate
FROM Students
WHERE EnrollmentDate >= '2022-01-01';



SELECT
    c.CourseID,
    c.CourseName,
    c.Credits,
    d.DepartmentName
FROM Courses AS c
INNER JOIN Departments AS d
    ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;



-- 9. PROJECT QUERY #4
-- Number of students in each course
-- Only courses with more than 5 students


SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS TotalStudents
FROM Courses AS c
INNER JOIN Enrollments AS e
    ON c.CourseID = e.CourseID
GROUP BY
    c.CourseID,
    c.CourseName
HAVING COUNT(e.StudentID) > 5;




SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
    ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;



SELECT DISTINCT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
    ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures');


-- 12. PROJECT QUERY #7
-- Average number of credits for all courses


SELECT
    AVG(Credits) AS AverageCredits
FROM Courses;



SELECT
    MAX(i.Salary) AS MaximumSalary
FROM Instructors AS i
INNER JOIN Departments AS d
    ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';


-- 14. PROJECT QUERY #9
-- Count students enrolled in each department


SELECT
    d.DepartmentID,
    d.DepartmentName,
    COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM Departments AS d
LEFT JOIN Courses AS c
    ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments AS e
    ON c.CourseID = e.CourseID
GROUP BY
    d.DepartmentID,
    d.DepartmentName;




SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseID,
    c.CourseName,
    e.EnrollmentDate
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
    ON e.CourseID = c.CourseID;



SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName
FROM Students AS s
LEFT JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses AS c
    ON e.CourseID = c.CourseID;



SELECT
    s.StudentID,
    s.FirstName,
    s.LastName
FROM Students AS s
WHERE s.StudentID IN (
    SELECT e.StudentID
    FROM Enrollments AS e
    WHERE e.CourseID IN (
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);



SELECT
    StudentID,
    FirstName,
    LastName,
    EnrollmentDate,
    YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;


-- 19. PROJECT QUERY #14
-- Concatenate instructor first and last name


SELECT
    InstructorID,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Instructors;



SELECT
    e.EnrollmentDate,
    e.EnrollmentID,
    COUNT(*) OVER (
        ORDER BY e.EnrollmentDate, e.EnrollmentID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotalStudents
FROM Enrollments AS e
ORDER BY
    e.EnrollmentDate,
    e.EnrollmentID;



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



-- A. Students sorted by enrollment date
SELECT *
FROM Students
ORDER BY EnrollmentDate DESC;


-- B. Courses sorted by credits
SELECT *
FROM Courses
ORDER BY Credits DESC;


-- C. Students with full name
SELECT
    StudentID,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Email
FROM Students;


-- D. Courses with department names
SELECT
    c.CourseID,
    c.CourseName,
    d.DepartmentName,
    c.Credits
FROM Courses AS c
JOIN Departments AS d
    ON c.DepartmentID = d.DepartmentID;


-- E. Instructor full details with department
SELECT
    i.InstructorID,
    CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName,
    i.Email,
    d.DepartmentName,
    i.Salary
FROM Instructors AS i
JOIN Departments AS d
    ON i.DepartmentID = d.DepartmentID;


-- F. Total number of students
SELECT COUNT(*) AS TotalStudents
FROM Students;


-- G. Total number of courses
SELECT COUNT(*) AS TotalCourses
FROM Courses;


-- H. Total number of instructors
SELECT COUNT(*) AS TotalInstructors
FROM Instructors;


-- I. Total number of departments
SELECT COUNT(*) AS TotalDepartments
FROM Departments;


-- J. Total number of enrollments
SELECT COUNT(*) AS TotalEnrollments
FROM Enrollments;


-- K. Highest course credit
SELECT MAX(Credits) AS HighestCredits
FROM Courses;


-- L. Lowest course credit
SELECT MIN(Credits) AS LowestCredits
FROM Courses;


-- M. Total credits offered
SELECT SUM(Credits) AS TotalCredits
FROM Courses;


-- N. Students born after 2000
SELECT *
FROM Students
WHERE BirthDate > '2000-01-01';


-- O. Students whose first name starts with J
SELECT *
FROM Students
WHERE FirstName LIKE 'J%';


-- P. Students whose last name ends with 'e'
SELECT *
FROM Students
WHERE LastName LIKE '%e';


-- Q. Courses having 4 or more credits
SELECT *
FROM Courses
WHERE Credits >= 4;


-- R. Number of courses in each department
SELECT
    d.DepartmentName,
    COUNT(c.CourseID) AS TotalCourses
FROM Departments AS d
LEFT JOIN Courses AS c
    ON d.DepartmentID = c.DepartmentID
GROUP BY
    d.DepartmentID,
    d.DepartmentName;


-- S. Average credits by department
SELECT
    d.DepartmentName,
    AVG(c.Credits) AS AverageCredits
FROM Departments AS d
INNER JOIN Courses AS c
    ON d.DepartmentID = c.DepartmentID
GROUP BY
    d.DepartmentID,
    d.DepartmentName;


-- T. Departments having more than 1 course
SELECT
    d.DepartmentName,
    COUNT(c.CourseID) AS TotalCourses
FROM Departments AS d
INNER JOIN Courses AS c
    ON d.DepartmentID = c.DepartmentID
GROUP BY
    d.DepartmentID,
    d.DepartmentName
HAVING COUNT(c.CourseID) > 1;


-- U. Student enrollment details
SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName,
    d.DepartmentName,
    e.EnrollmentDate
FROM Students AS s
JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
JOIN Courses AS c
    ON e.CourseID = c.CourseID
JOIN Departments AS d
    ON c.DepartmentID = d.DepartmentID
ORDER BY e.EnrollmentDate;


-- V. Number of courses taken by each student
SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    COUNT(e.CourseID) AS TotalCourses
FROM Students AS s
LEFT JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName;


-- W. Students with more than one course
SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    COUNT(e.CourseID) AS TotalCourses
FROM Students AS s
JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName
HAVING COUNT(e.CourseID) > 1;


-- X. Rank courses by credits using a window function
SELECT
    CourseID,
    CourseName,
    Credits,
    RANK() OVER (ORDER BY Credits DESC) AS CreditRank
FROM Courses;


-- Y. Row number for students by enrollment date
SELECT
    StudentID,
    CONCAT(FirstName, ' ', LastName) AS StudentName,
    EnrollmentDate,
    ROW_NUMBER() OVER (
        ORDER BY EnrollmentDate
    ) AS RowNumber
FROM Students;


-- Z. Department-wise student count using joins
SELECT
    d.DepartmentName,
    COUNT(DISTINCT e.StudentID) AS StudentCount
FROM Departments AS d
LEFT JOIN Courses AS c
    ON d.DepartmentID = c.DepartmentID
LEFT JOIN Enrollments AS e
    ON c.CourseID = e.CourseID
GROUP BY
    d.DepartmentID,
    d.DepartmentName
ORDER BY StudentCount DESC;



