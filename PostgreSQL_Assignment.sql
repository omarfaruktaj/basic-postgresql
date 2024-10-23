-- Active: 1729529177718@@127.0.0.1@5432@university_db

-- Creating database
CREATE DATABASE university_db;


-- Creating Students table
CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age  INT not NULL ,
    email VARCHAR(100) UNIQUE NOT NULL,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

-- Creating courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);

-- Creating enrollment table
CREATE TABLE enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    course_id INT NOT NULL REFERENCES courses(course_id)
);


-- Insert data into students table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


-- Insert data into courses table
INSERT INTO courses (course_name, credits) VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);


-- Insert data into enrollment table
INSERT INTO enrollment (student_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);


-- Queries

-- Query 1
-- Insert new student record
INSERT INTO students(student_name,age,email,frontend_mark,backend_mark,status) VALUES(
    'Omar',21,'omarabdullah1811@gmail.com',60,60,NULL
);

-- Query 2
-- Retrieve the names of all students who are enrolled in the course title 'Next.js'.
SELECT student_name
FROM students as s 
INNER JOIN enrollment as e ON s.student_id = e.student_id
INNER JOIN courses as c ON e.course_id = c.course_id
WHERE course_name = 'Next.js'


-- Query 3
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

UPDATE students SET status = 'Awarded' WHERE student_id=(
    SELECT student_id
    FROM students
    ORDER BY(frontend_mark + backend_mark) DESC
    LIMIT 1
);

-- Query 4
--  Delete all courses that have no students enrolled.
DELETE FROM courses 
WHERE course_id IN (
    SELECT c.course_id
    FROM courses as c
    LEFT JOIN enrollment as e ON c.course_id = e.course_id
    GROUP BY c.course_id
    HAVING COUNT(e.student_id) = 0
);

-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT  student_name
FROM students 
ORDER BY student_id
OFFSET 2 LIMIT 2;


-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.

SELECT c.course_name, COUNT(e.student_id) as students_enrolled
FROM courses as c
LEFT JOIN enrollment as e ON c.course_id = e.course_id
GROUP BY c.course_name;


-- Query 7:
-- Calculate and display the average age of all students.

SELECT round(AVG(age)) as average_age
FROM students

-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students 
WHERE email LIKE '%example.com%'




