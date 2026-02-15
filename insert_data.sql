-- INSERT_DATA.SQL - Session 1 Sample Data (5+ records each table)
USE college;

-- Insert 5+ students first
INSERT INTO student (vtu_number, name, email, phone, Department) VALUES
('1VTUCS123', 'Ram Kumar', 'ram@vtu.edu', '9876543210', 'CSE'),
('1VTUCS124', 'Priya Singh', 'priya@vtu.edu', '9876543211', 'CSE'),
('1VTUME125', 'Amit Patel', 'amit@vtu.edu', '9876543212', 'MECH'),
('1VTUCS126', 'Sneha Rao', 'sneha@vtu.edu', '9876543213', 'CSE'),
('1VTUISE127', 'Kiran Desai', 'kiran@vtu.edu', '9876543214', 'ISE'),
('1VTUME128', 'Ravi Sharma', 'ravi@vtu.edu', '9876543215', 'MECH');

-- Insert 5+ courses (using student IDs 1-5)
INSERT INTO course (course_code, course_name, faculty_id, student_id, faculty_email) VALUES
('CS101', 'Data Structures', 'F001', 1, 'ram.faculty@vtu.edu'),
('CS102', 'Algorithms', 'F002', 2, 'priya.faculty@vtu.edu'),
('ME101', 'Thermodynamics', 'F003', 3, 'amit.faculty@vtu.edu'),
('CS103', 'Database Systems', 'F004', 4, 'sneha.faculty@vtu.edu'),
('ISE101', 'Web Programming', 'F005', 5, 'kiran.faculty@vtu.edu'),
('ME102', 'Fluid Mechanics', 'F006', 6, 'ravi.faculty@vtu.edu');

-- Verify data inserted
SELECT 'Students' as Table_Name, COUNT(*) as Record_Count FROM student
UNION ALL
SELECT 'Courses' as Table_Name, COUNT(*) as Record_Count FROM course;
