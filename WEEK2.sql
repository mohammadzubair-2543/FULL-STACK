--------------------------------------------------
-- WEEK 2 : EXTENSION OF COLLEGE DATABASE
--------------------------------------------------

USE college;

--------------------------------------------------
-- 1. CREATE FACULTY TABLE (NORMALIZATION)
--------------------------------------------------

DROP TABLE IF EXISTS faculty;

CREATE TABLE faculty (
    id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_id VARCHAR(20) UNIQUE NOT NULL,
    faculty_name VARCHAR(100) NOT NULL,
    faculty_email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(10) NOT NULL
);

--------------------------------------------------
-- 2. MODIFY COURSE TABLE (ADD FACULTY REFERENCE)
--------------------------------------------------

ALTER TABLE course
DROP COLUMN faculty_email;

ALTER TABLE course
ADD faculty_ref INT,
ADD CONSTRAINT fk_faculty
FOREIGN KEY (faculty_ref) REFERENCES faculty(id);

--------------------------------------------------
-- 3. INSERT FACULTY RECORDS
--------------------------------------------------

INSERT INTO faculty (faculty_id, faculty_name, faculty_email, department) VALUES
('F001', 'Dr. Ramesh', 'ramesh@vtu.edu', 'CSE'),
('F002', 'Dr. Anjali', 'anjali@vtu.edu', 'CSE'),
('F003', 'Dr. Suresh', 'suresh@vtu.edu', 'MECH'),
('F004', 'Dr. Kavya', 'kavya@vtu.edu', 'CSE'),
('F005', 'Dr. Manjunath', 'manju@vtu.edu', 'ISE'),
('F006', 'Dr. Arvind', 'arvind@vtu.edu', 'MECH');

--------------------------------------------------
-- 4. UPDATE COURSE TABLE WITH FACULTY REFERENCES
--------------------------------------------------

UPDATE course SET faculty_ref = 1 WHERE faculty_id = 'F001';
UPDATE course SET faculty_ref = 2 WHERE faculty_id = 'F002';
UPDATE course SET faculty_ref = 3 WHERE faculty_id = 'F003';
UPDATE course SET faculty_ref = 4 WHERE faculty_id = 'F004';
UPDATE course SET faculty_ref = 5 WHERE faculty_id = 'F005';
UPDATE course SET faculty_ref = 6 WHERE faculty_id = 'F006';

--------------------------------------------------
-- 5. CREATE INDEX (PERFORMANCE OPTIMIZATION)
--------------------------------------------------

CREATE INDEX idx_department ON student(department);

--------------------------------------------------
-- 6. CREATE VIEW (REPORTING PURPOSE)
--------------------------------------------------

CREATE VIEW student_course_view AS
SELECT 
    s.vtu_number,
    s.name AS student_name,
    c.course_name,
    f.faculty_name
FROM student s
JOIN course c ON s.id = c.student_id
JOIN faculty f ON c.faculty_ref = f.id;

--------------------------------------------------
-- 7. STORED PROCEDURE (ADD NEW STUDENT)
--------------------------------------------------

DELIMITER //

CREATE PROCEDURE add_student(
    IN vtu VARCHAR(20),
    IN sname VARCHAR(100),
    IN semail VARCHAR(100),
    IN sphone VARCHAR(20),
    IN dept VARCHAR(10)
)
BEGIN
    INSERT INTO student (vtu_number, name, email, phone, department)
    VALUES (vtu, sname, semail, sphone, dept);
END //

DELIMITER ;

--------------------------------------------------
-- 8. TRIGGER (AUTO ADD +91 TO PHONE NUMBER)
--------------------------------------------------

DELIMITER //

CREATE TRIGGER before_insert_student
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
    SET NEW.phone = CONCAT('+91', NEW.phone);
END //

DELIMITER ;

--------------------------------------------------
-- TESTING
--------------------------------------------------

-- Test Stored Procedure
CALL add_student('1VTUCS129', 'Arjun Reddy', 'arjun@vtu.edu', '9876543216', 'CSE');

-- Test View
SELECT * FROM student_course_view;













--TASK 2



USE college;

--------------------------------------------------
-- CREATE TABLE FOR DATE OPERATIONS
--------------------------------------------------

DROP TABLE IF EXISTS events;

CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

--------------------------------------------------
-- INSERT SAMPLE DATA
--------------------------------------------------

INSERT INTO events (event_name, start_date, end_date, created_at) VALUES
('Workshop', '2026-02-01', '2026-02-10', '2026-02-15 10:00:00'),
('Seminar', '2026-02-05', '2026-02-20', '2026-02-14 12:00:00'), -- Saturday
('Conference', '2026-02-07', '2026-02-25', '2026-02-16 09:30:00');

--------------------------------------------------
-- 1. FIND NUMBER OF DAYS BETWEEN START AND END DATE
--------------------------------------------------

SELECT 
    event_name,
    DATEDIFF(end_date, start_date) AS total_days
FROM events;

--------------------------------------------------
-- 2. FIND EXPIRY DATE AFTER 30 DAYS FROM START_DATE
--------------------------------------------------

SELECT 
    event_name,
    start_date,
    DATE_ADD(start_date, INTERVAL 30 DAY) AS expiry_date
FROM events;

--------------------------------------------------
-- 3. GET DATE BEFORE 7 DAYS FROM TODAY
--------------------------------------------------

SELECT DATE_SUB(CURDATE(), INTERVAL 7 DAY) AS seven_days_before_today;

--------------------------------------------------
-- 4. GET RECORDS CREATED ON WEEKEND (SATURDAY/SUNDAY)
--------------------------------------------------

SELECT *
FROM events
WHERE DAYOFWEEK(created_at) IN (1,7);
-- 1 = Sunday, 7 = Saturday (MySQL)

--------------------------------------------------
-- 5. READ INPUT DATE AS STRING AND CONVERT FORMAT
--    THEN DISPLAY MONTH NAME
--------------------------------------------------

-- Example input string
SET @input_date = '19-02-2026';

SELECT 
    @input_date AS original_string,
    STR_TO_DATE(@input_date, '%d-%m-%Y') AS converted_date,
    MONTHNAME(STR_TO_DATE(@input_date, '%d-%m-%Y')) AS month_name;





--TASK3



USE college;

--------------------------------------------------
-- CREATE SAMPLE TABLE FOR INDEXING PRACTICE
--------------------------------------------------

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    email VARCHAR(150),
    aadhar VARCHAR(20),
    status VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

--------------------------------------------------
-- INSERT SAMPLE DATA
--------------------------------------------------

INSERT INTO users (username, email, aadhar, status) VALUES
('ram123', 'ram@gmail.com', '123456789012', 'active'),
('priya456', 'priya@gmail.com', '234567890123', 'inactive'),
('amit789', 'amit@gmail.com', '345678901234', 'active'),
('sneha111', 'sneha@gmail.com', '456789012345', 'active'),
('kiran222', 'kiran@gmail.com', '567890123456', 'inactive');

--------------------------------------------------
-- 1. IMPROVE SEARCH PERFORMANCE ON EMAIL COLUMN
--------------------------------------------------

CREATE INDEX idx_email ON users(email);

-- Example Query
SELECT * FROM users WHERE email = 'ram@gmail.com';

--------------------------------------------------
-- 2. CREATE UNIQUE INDEX ON USERNAME
--------------------------------------------------

CREATE UNIQUE INDEX idx_unique_username ON users(username);

--------------------------------------------------
-- 3. DROP UNUSED INDEX
--------------------------------------------------

-- Example: If idx_email is unused
DROP INDEX idx_email ON users;

--------------------------------------------------
-- 4. FIX SLOW QUERY ON AADHAR USING INDEX
--------------------------------------------------

CREATE INDEX idx_aadhar ON users(aadhar);

-- Optimized Query
SELECT * FROM users WHERE aadhar = '123456789012';

--------------------------------------------------
-- 5. CREATE COMPOSITE INDEX (status, created_at)
--------------------------------------------------

CREATE INDEX idx_status_created 
ON users(status, created_at);

-- Optimized Query Example
SELECT *
FROM users
WHERE status = 'active'
ORDER BY created_at DESC;





--TASK4





USE college;

--------------------------------------------------
-- WEEK 2 : TASK 4
-- STRING FUNCTIONS + DATA CLEANING + AGGREGATION
--------------------------------------------------

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    email VARCHAR(100),
    contact VARCHAR(50),
    mobile VARCHAR(20),
    phone VARCHAR(20),
    name VARCHAR(100),
    department VARCHAR(50),
    joining_date DATE
);

--------------------------------------------------
-- INSERT SAMPLE DATA
--------------------------------------------------

INSERT INTO employees (username, email, contact, mobile, phone, name, department, joining_date) VALUES
('ram.kumar', 'ram.kumar@gmail.com', '987 654-3210', NULL, '080-2345-6789', 'rAm kuMAR', 'CSE', '2018-05-10'),
('priya.singh', 'priya.singh@gmail.com', '98-76 543210', '9988776655', NULL, 'PRIYA sINGH', 'CSE', '2020-07-15'),
('amit.patel', 'amit.patel@gmail.com', '98765@43210', NULL, NULL, 'aMit pATel', 'MECH', '2016-03-20'),
('sneha.rao', 'sneha.rao@gmail.com', '98765 43210', '9090909090', '080 1111 2222', 'SNEHA rAO', 'ISE', '2019-11-01');

--------------------------------------------------
-- 1. EXTRACT LETTERS BEFORE @ AND APPEND 123
--------------------------------------------------

SELECT 
    username,
    CONCAT(SUBSTRING_INDEX(email, '@', 1), '123') AS default_password
FROM employees;

--------------------------------------------------
-- 2. CLEAN CONTACT NUMBER (REMOVE SPACES, DASHES, SYMBOLS)
--------------------------------------------------

SELECT 
    contact AS original_contact,
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(contact, ' ', ''),
            '-', ''),
        '@', ''),
    '.', '') AS cleaned_contact
FROM employees;

--------------------------------------------------
-- 3. NORMALIZE EMPLOYEE NAMES (PROPER CASE)
--------------------------------------------------

SELECT 
    name AS original_name,
    CONCAT(
        UPPER(SUBSTRING(name,1,1)),
        LOWER(SUBSTRING(name,2))
    ) AS normalized_name
FROM employees;

--------------------------------------------------
-- 4. FALLBACK CONTACT PRIORITY (Mobile → Phone → Email)
--------------------------------------------------

SELECT 
    username,
    COALESCE(mobile, phone, email) AS preferred_contact
FROM employees;

--------------------------------------------------
-- 5. AVERAGE EXPERIENCE PER DEPARTMENT
--------------------------------------------------

SELECT 
    department,
    AVG(TIMESTAMPDIFF(YEAR, joining_date, CURDATE())) AS avg_experience_years
FROM employees
GROUP BY department;





--TASK5




USE college;

--------------------------------------------------
-- WEEK 2 : TASK 5
-- USER DEFINED FUNCTIONS
--------------------------------------------------

--------------------------------------------------
-- 1. FUNCTION TO CALCULATE NET SALARY AFTER 10% TAX
--------------------------------------------------

DELIMITER //

CREATE FUNCTION calculate_net_salary(gross_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN gross_salary - (gross_salary * 0.10);
END //

DELIMITER ;

-- Test
SELECT calculate_net_salary(50000);


--------------------------------------------------
-- 2. FUNCTION TO CHECK USER ACTIVITY
-- Active if last login within 30 days
--------------------------------------------------

DELIMITER //

CREATE FUNCTION check_user_activity(last_login DATE)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF DATEDIFF(CURDATE(), last_login) <= 30 THEN
        RETURN 'Active';
    ELSE
        RETURN 'Inactive';
    END IF;
END //

DELIMITER ;

-- Test
SELECT check_user_activity('2026-02-01');


--------------------------------------------------
-- 3. FUNCTION FOR DYNAMIC TAX SLAB CALCULATION
--------------------------------------------------

DELIMITER //

CREATE FUNCTION calculate_tax(salary DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE tax DECIMAL(12,2);

    IF salary <= 300000 THEN
        SET tax = 0;
    ELSEIF salary <= 600000 THEN
        SET tax = salary * 0.10;
    ELSEIF salary <= 1000000 THEN
        SET tax = salary * 0.20;
    ELSE
        SET tax = salary * 0.30;
    END IF;

    RETURN tax;
END //

DELIMITER ;

-- Test
SELECT calculate_tax(750000);


--------------------------------------------------
-- 4. FUNCTION TO CATEGORIZE EMPLOYEES BASED ON EXPERIENCE
--------------------------------------------------

DELIMITER //

CREATE FUNCTION employee_category(years INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF years < 2 THEN
        RETURN 'Fresher';
    ELSEIF years BETWEEN 2 AND 5 THEN
        RETURN 'Junior';
    ELSEIF years BETWEEN 6 AND 10 THEN
        RETURN 'Mid';
    ELSE
        RETURN 'Senior';
    END IF;
END //

DELIMITER ;

-- Test
SELECT employee_category(7);


--------------------------------------------------
-- 5. LATE FEE CALCULATOR
-- ₹50 per day after due date
-- Maximum limit ₹1000
--------------------------------------------------

DELIMITER //

CREATE FUNCTION late_fee(due_date DATE, return_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE days_late INT;
    DECLARE fee INT;

    SET days_late = DATEDIFF(return_date, due_date);

    IF days_late <= 0 THEN
        RETURN 0;
    END IF;

    SET fee = days_late * 50;

    IF fee > 1000 THEN
        SET fee = 1000;
    END IF;

    RETURN fee;
END //

DELIMITER ;

-- Test
SELECT late_fee('2026-02-01', '2026-02-15');






