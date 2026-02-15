-- View all courses
SELECT * FROM course;

-- View all students  
SELECT * FROM student;

SELECT * FROM course;
SELECT * FROM student WHERE Department = 'CSE';
SELECT Department, COUNT(*) as student_count FROM student GROUP BY Department;

-- WHERE clause (filtering)
SELECT * FROM student WHERE Department = 'CSE';

-- ORDER BY clause (sorting)  
SELECT * FROM student ORDER BY name ASC;

-- GROUP BY clause (aggregation)
SELECT Department, COUNT(*) as total_students 
FROM student GROUP BY Department;

-- Multiple clauses combined
SELECT name, Department FROM student 
WHERE Department = 'CSE' 
ORDER BY name;



