--------------------------------------------------
-- SESSION 1 : DATABASE & TABLE CREATION
--------------------------------------------------

CREATE DATABASE IF NOT EXISTS college;
USE college;

-- Drop tables if already exist
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student;

-- Create Student Table
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vtu_number VARCHAR(20),
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    Department VARCHAR(10)
);

-- Create Course Table
CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20),
    course_name VARCHAR(100),
    faculty_id VARCHAR(20),
    student_id INT,
    faculty_email VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES student(id)
);

--------------------------------------------------
-- INSERT MINIMUM 5 RECORDS
--------------------------------------------------

INSERT INTO student (vtu_number, name, email, phone, Department) VALUES
('1VTUCS123', 'Ram Kumar', 'ram@vtu.edu', '9876543210', 'CSE'),
('1VTUCS124', 'Priya Singh', 'priya@vtu.edu', '9876543211', 'CSE'),
('1VTUME125', 'Amit Patel', 'amit@vtu.edu', '9876543212', 'MECH'),
('1VTUCS126', 'Sneha Rao', 'sneha@vtu.edu', '9876543213', 'CSE'),
('1VTUISE127', 'Kiran Desai', 'kiran@vtu.edu', '9876543214', 'ISE'),
('1VTUME128', 'Ravi Sharma', 'ravi@vtu.edu', '9876543215', 'MECH');

INSERT INTO course (course_code, course_name, faculty_id, student_id, faculty_email) VALUES
('CS101', 'Data Structures', 'F001', 1, 'ram.faculty@vtu.edu'),
('CS102', 'Algorithms', 'F002', 2, 'priya.faculty@vtu.edu'),
('ME101', 'Thermodynamics', 'F003', 3, 'amit.faculty@vtu.edu'),
('CS103', 'Database Systems', 'F004', 4, 'sneha.faculty@vtu.edu'),
('ISE101', 'Web Programming', 'F005', 5, 'kiran.faculty@vtu.edu'),
('ME102', 'Fluid Mechanics', 'F006', 6, 'ravi.faculty@vtu.edu');

--------------------------------------------------
-- SESSION 3 : SELECT QUERIES
--------------------------------------------------

-- Display all records
SELECT * FROM student;
SELECT * FROM course;

-- Aggregate function
SELECT Department, COUNT(*) AS total_students
FROM student
GROUP BY Department;

-- Sort by VTU number
SELECT * FROM student ORDER BY vtu_number ASC;
SELECT * FROM student ORDER BY vtu_number DESC;

-- Students of particular department
SELECT * FROM student WHERE Department = 'CSE';

-- Join VTU number with course & faculty
SELECT s.vtu_number, s.name, c.course_name, c.faculty_id, c.faculty_email
FROM student s
JOIN course c ON s.id = c.student_id;

--------------------------------------------------
-- SESSION 4 : ADVANCED QUERIES
--------------------------------------------------

-- 1. Students based on course & count
SELECT c.course_name, COUNT(s.id) AS total_students
FROM student s
JOIN course c ON s.id = c.student_id
GROUP BY c.course_name;

-- 2. Courses handled by a faculty & insert into new table
CREATE TABLE faculty_courses AS
SELECT * FROM course WHERE faculty_id = 'F001';

-- 3. Update top 5 students of CSE with country code
UPDATE student
SET phone = CONCAT('+91', phone)
WHERE Department = 'CSE'
LIMIT 5;

--------------------------------------------------
-- SESSION 5 : TRANSACTIONS
--------------------------------------------------

-- Transaction with commit
START TRANSACTION;
UPDATE student SET phone = '+919999999999' WHERE id = 1;
COMMIT;

-- Savepoint & rollback
START TRANSACTION;
UPDATE student SET phone = '+918888888888' WHERE id = 2;
SAVEPOINT sp1;
UPDATE student SET phone = '+917777777777' WHERE id = 3;
ROLLBACK TO sp1;
COMMIT;

--------------------------------------------------
-- USER DEFINED FUNCTIONS
--------------------------------------------------

DELIMITER //

-- Mathematical Function
CREATE FUNCTION add_numbers(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a + b;
END //

-- Select-based Function
CREATE FUNCTION get_student_count(dept_name VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM student
    WHERE Department = dept_name;
    RETURN total;
END //

DELIMITER ;

-- Test functions
SELECT add_numbers(10,5);
SELECT get_student_count('CSE');


