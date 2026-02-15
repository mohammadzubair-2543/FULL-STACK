-- Session 1: CREATE TABLES
-- Drop existing tables first
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student;


USE college;

CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vtu_number VARCHAR(20),
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    Department VARCHAR(10)
);

CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20),
    course_name VARCHAR(100),
    faculty_id VARCHAR(20),
    student_id INT,
    faculty_email VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES student(id)
);
