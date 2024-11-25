-- schema.sql --

create database studentDB;
use studentDB;

-- Create the 'Students' table --
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    email VARCHAR(100)
);

-- Create the 'Courses' table --
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(50),
    credits INT
);

-- Create the 'Enrollments' table --
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Add data --
-- data.sql --

-- insert data in students table --
INSERT INTO Students 
(student_id, first_name, last_name, dob, email)
VALUES
(1, 'John', 'Doe', '2000-01-15', 'john.doe@example.com'),
(2, 'Jane', 'Smith', '2001-05-23', 'jane.smith@example.com'),
(3, 'Michael', 'Johnson', '1999-10-30', 'michael.johnson@example.com'),
(4, 'Emily', 'Williams', '2002-08-19', 'emily.williams@example.com'),
(5, 'David', 'Brown', '2000-12-05', 'david.brown@example.com'),
(6, 'Sarah', 'Jones', '2001-07-17', 'sarah.jones@example.com'),
(7, 'Chris', 'Miller', '2000-02-22', 'chris.miller@example.com'),
(8, 'Olivia', 'Davis', '1999-11-12', 'olivia.davis@example.com'),
(9, 'Sophia', 'Martinez', '2002-03-10', 'sophia.martinez@example.com'),
(10, 'Daniel', 'Hernandez', '2000-04-28', 'daniel.hernandez@example.com'),
(11, 'Grace', 'Lopez', '2001-09-06', 'grace.lopez@example.com'),
(12, 'William', 'Gonzalez', '2000-06-25', 'william.gonzalez@example.com'),
(13, 'Isabella', 'Perez', '2001-01-13', 'isabella.perez@example.com'),
(14, 'Liam', 'Wilson', '1999-04-19', 'liam.wilson@example.com'),
(15, 'Mason', 'Anderson', '2002-12-03', 'mason.anderson@example.com'),
(16, 'Charlotte', 'Thomas', '2001-05-05', 'charlotte.thomas@example.com'),
(17, 'Ava', 'Taylor', '2002-02-20', 'ava.taylor@example.com'),
(18, 'Lucas', 'Moore', '2000-08-11', 'lucas.moore@example.com'),
(19, 'Ethan', 'Jackson', '2001-11-30', 'ethan.jackson@example.com'),
(20, 'Amelia', 'White', '1999-07-24', 'amelia.white@example.com');

-- insert data in courses table --
INSERT INTO Courses 
(course_id, course_name, instructor, credits)
VALUES
(1, 'Introduction to Computer Science', 'Dr. Alice', 3),
(2, 'Database Management Systems', 'Prof. Bob', 4),
(3, 'Mathematics for Computer Science', 'Dr. Charlie', 3),
(4, 'Data Structures and Algorithms', 'Dr. Diana', 4),
(5, 'Operating Systems', 'Prof. Edward', 3),
(6, 'Software Engineering', 'Dr. Fiona', 4),
(7, 'Discrete Mathematics', 'Prof. Greg', 3),
(8, 'Networking Fundamentals', 'Dr. Helen', 3),
(9, 'Web Development', 'Prof. Ian', 4),
(10, 'Machine Learning', 'Dr. Jack', 4);

-- insert data in students table --
INSERT INTO Enrollments
(student_id, course_id, enrollment_date)
VALUES
(1, 1, '2024-09-01'),
(1, 2, '2024-09-01'),
(2, 3, '2024-09-02'),
(2, 4, '2024-09-02'),
(3, 5, '2024-09-03'),
(4, 6, '2024-09-03'),
(5, 7, '2024-09-04'),
(5, 8, '2024-09-04'),
(6, 9, '2024-09-05'),
(7, 10, '2024-09-06'),
(8, 1, '2024-09-07'),
(9, 2, '2024-09-07'),
(10, 3, '2024-09-08'),
(11, 4, '2024-09-08'),
(12, 5, '2024-09-09'),
(13, 6, '2024-09-09'),
(14, 7, '2024-09-10'),
(15, 8, '2024-09-10'),
(16, 9, '2024-09-11'),
(17, 10, '2024-09-11');

-- SQL Queries --
-- Basic Queries--

Query 1: Select all students
Ans-- Select * From Students;

Query 2: Select students enrolled in a particular course (e.g., "Introduction to Computer Science")
Ans-- Select s.first_name, s.last_name,c.course_name
      FROM Students s
      JOIN Enrollments e ON s.student_id = e.student_id
      JOIN Courses c ON e.course_id = c.course_id
      WHERE c.course_name = 'Introduction to Computer Science';

Query 3: Select all courses a student is enrolled in (e.g., student with ID 1)
Ans-- SELECT s.first_name,c.course_name, c.instructor
      FROM students s
      Join enrollments e on e.student_id=s.student_id
      JOIN courses c ON c.course_id = e.course_id
      WHERE e.student_id = 1;

Query 4: Find students with a specific email domain
Ans-- SELECT first_name, last_name, email
      FROM Students
      WHERE email LIKE '%@example.com';

Query 5: List all courses and their credits
Ans-- SELECT course_name, credits
      FROM Courses;

-- Intermediate Queries --

Query 1: Count the number of students enrolled in each course
Ans-- SELECT c.course_name, COUNT(e.student_id) AS num_students
      FROM Courses c
      Left JOIN Enrollments e ON c.course_id = e.course_id
      GROUP BY c.course_name;

Query 2: List students who are enrolled in more than 2 courses
Ans-- SELECT s.first_name, s.last_name, COUNT(c.course_id) AS num_courses
      FROM Students s
      JOIN Enrollments e ON s.student_id = e.student_id
      Join courses c on c.course_id=e.course_id
      GROUP BY s.student_id
      HAVING num_courses > 2;
 
Query 3: Select courses with more than 3 credits
Ans-- SELECT course_name, credits
      FROM Courses
      WHERE credits > 3;

Query 4: Find all students who are enrolled in both "Database Management Systems" and "Operating Systems"
Ans-- SELECT s.first_name, s.last_name
      FROM Students s
      JOIN Enrollments e ON s.student_id = e.student_id
      JOIN Courses c ON e.course_id = c.course_id
      WHERE c.course_name IN ('Database Management Systems', 'Operating Systems')
      GROUP BY s.student_id
      HAVING COUNT(DISTINCT c.course_name) = 2;

-- Advanced Queries --

Query 1: Find the most popular course (course with the highest enrollment)
Ans-- SELECT c.course_name, COUNT(e.student_id) AS num_students
      FROM Courses c
      JOIN Enrollments e ON c.course_id = e.course_id
      GROUP BY c.course_name
      ORDER BY num_students DESC
      LIMIT 1;

Query 2: Find students who are not enrolled in any courses
Ans-- SELECT s.first_name, s.last_name,e.course_id
      FROM Students s
      LEFT JOIN Enrollments e ON s.student_id = e.student_id
      WHERE e.course_id IS NULL;

Query 3: Find the course with the maximum number of students enrolled per semester
Ans-- SELECT c.course_name, COUNT(e.student_id) AS num_students
      FROM Courses c
      JOIN Enrollments e ON c.course_id = e.course_id
      WHERE e.enrollment_date BETWEEN '2024-09-01' AND '2024-12-31'
      GROUP BY c.course_name
      ORDER BY num_students DESC
      LIMIT 1;

Query 4: Find the total credits a student is enrolled in (e.g., student ID 1)
Ans-- SELECT s.first_name, s.last_name, SUM(c.credits) AS total_credits
      FROM Students s
      JOIN Enrollments e ON s.student_id = e.student_id
      JOIN Courses c ON e.course_id = c.course_id
      WHERE s.student_id = 1
      GROUP BY s.student_id;

Query 5: Get the top 3 students with the most courses enrolled (e.g., by number of courses)
Ans-- SELECT s.first_name, s.last_name, COUNT(e.course_id) AS num_courses
      FROM Students s
      JOIN Enrollments e ON s.student_id = e.student_id
      GROUP BY s.student_id
      ORDER BY num_courses DESC
      LIMIT 3;
