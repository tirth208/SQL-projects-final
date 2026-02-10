CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    BirthDate DATE,
    EnrollmentDate DATE
);
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');
INSERT INTO Students VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');
INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);
INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 90000),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 85000);
INSERT INTO Enrollments VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');

INSERT INTO Students VALUES (3, 'Mark', 'Taylor', 'mark@email.com', '2001-02-10', '2023-08-01');


UPDATE Students SET Email = 'john.new@email.com' WHERE StudentID = 1;

DELETE FROM Students WHERE StudentID = 3;

SELECT * FROM Students;
SELECT * FROM Students
WHERE EnrollmentDate > '2022-01-01';
SELECT CourseName
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;
SELECT CourseID, COUNT(StudentID) AS TotalStudents
FROM Enrollments
GROUP BY CourseID
HAVING COUNT(StudentID) > 5;
SELECT s.StudentID, s.FirstName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (101, 102)
GROUP BY s.StudentID
HAVING COUNT(DISTINCT e.CourseID) = 2;
SELECT DISTINCT s.FirstName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (101, 102);
SELECT AVG(Credits) AS AverageCredits FROM Courses;
SELECT MAX(Salary) AS MaxSalary
FROM Instructors i
JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';
SELECT d.DepartmentName, COUNT(e.StudentID) AS TotalStudents
FROM Departments d
JOIN Courses c ON d.DepartmentID = c.DepartmentID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentName;
SELECT s.FirstName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;
SELECT s.FirstName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;
SELECT FirstName
FROM Students
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID IN (
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);
SELECT StudentID, YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students;
SELECT CONCAT(FirstName, ' ', LastName) AS InstructorName
FROM Instructors;
SELECT CourseID,
COUNT(StudentID) OVER (ORDER BY CourseID) AS RunningTotal
FROM Enrollments;
SELECT FirstName,
CASE
    WHEN EnrollmentDate <= DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
    THEN 'Senior'
    ELSE 'Junior'
END AS Status
FROM Students;

