/*
Task1 Project Title: Academic Management System (using SQL)

Project Description: Design and develop an Academic Management System using SQL. The projects should Involve three tables 1.Studentinfo 2. Coursesinfo 3.Enrollmentinfo. The Aim is to create a system that allows for managing student information and course enrollment.
The project will include the following tasks:

Database Creation:
a) Create the Studentinfo table with columns STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS. b) Create the Coursesinfo table with columns COURSE_ID, COURSE_NAME,COURSE_INSTRUCTOR NAME. c)Create the Enrollmentinfo with columns ENROLLMENT_ID, STU_ID, COURSE_ID,
ENROLL_STATUS(Enrolled/Not Enrolled). The FOREIGN KEY constraint in the Enrollmentinfo table references the STU_ID column in the Studentinfo table and the COURSE_ID column in the Coursesinfo table.

*/

create table StudentInfo(
STU_ID int PRIMARY KEY,
STU_NAME varchar(25),
DOB date,
PHONE_NO varchar(15),
EMAIL_ID varchar(50),
ADDRESS varchar(100));

create table CoursesInfo(
Course_ID int PRIMARY KEY,
COURSE_NAME varchar(50),
COURSE_INSTRUCTOR_NAME varchar(50));

create table EnrollmentInfo(
ENROLLMENT_ID VARCHAR(15),
STU_ID INT,
COURSE_ID INT,
ENROLL_STATUS varchar(20) CHECK (ENROLL_STATUS IN ('Enrolled', 'NOT Enrolled')) NOT NULL,
FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(Course_ID));

/* 
2. Data Creation:
Insert some sample data for Studentinfo table, Coursesinfo table, Enrollmentinfo with respective fields.
*/

INSERT INTO StudentInfo(STU_ID,STU_NAME,DOB,PHONE_NO,EMAIL_ID,ADDRESS)
Values
(1, 'Kiran', '1997-02-13', '9876543210', 'kiran97@mail.com', 'Park Avenue, Springfield'),
(2, 'Rhea', '1994-08-20', '8765432190', 'rhea94@mail.com', 'Elm Street, Beverly Hills'),
(3, 'Arjun', '1996-03-18', '9123456780', 'arjun96@mail.com', 'Sunset Boulevard, LA'),
(4, 'Maya', '1990-12-12', '8527419630', 'maya90@mail.com', 'Ocean Drive, Miami'),
(5, 'Dev', '2000-01-01', '7564839201', 'dev2000@mail.com', 'Main Street, Denver'),
(6, 'Sneha', '1999-08-09', '6549871230', 'sneha99@mail.com', 'Maple Street, Seattle');

INSERT INTO CoursesInfo(COURSE_ID,COURSE_NAME,COURSE_INSTRUCTOR_NAME)
VALUES
(101, 'SQL', 'Ankita'),
(102, 'PYTHON', 'Suresh'),
(103, 'JAVA', 'Pradeep');

INSERT INTO EnrollmentInfo(ENROLLMENT_ID,STU_ID,COURSE_ID,ENROLL_STATUS)
VALUES
('E101', 1, 101, 'Enrolled'),
('E102', 1, 102, 'Enrolled'),
('E103', 2, 101, 'Enrolled'),
('E104', 3, 102, 'Enrolled'),
('E105', 4, 102, 'Enrolled'),
('E106', 5, 103, 'Enrolled'),
('E107', 6, 103, 'Enrolled');


/* 3. Retrieve the Student Information
a) Write a query to retrieve student details, such as student name, contact information, and Enrollment status. */

Select
s.STU_NAME as Student_Name,
s.PHONE_NO as Phone_number,
S.EMAIL_ID as Email_id,
S.ADDRESS as Address,
E.ENROLL_STATUS as Enrollment_status,
C.course_name as Course_name
From
StudentInfo s
JOIN
EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN
CoursesINFO c ON e.course_id = c.course_id;

-- b) Write a query to retrieve a list of courses in which a specific student is enrolled.

select s.stu_name, c.course_name
from
CoursesInfo c
join
EnrollmentInfo e ON c.Course_id = e.Course_id
join
StudentInfo s on s.STU_ID = e.STU_ID
WHERE
s.Stu_name = 'Kiran';

-- c) Query to retrieve a list of course information, including course name, instructor information.

Select course_name, Course_instructor_name as Instructor_name
from CoursesInfo;

-- d) Query to retrieve a list of course information for a specific course.

select Course_name, Course_id, Course_instructor_name as Instructor_name 
from CoursesInfo
where course_name = 'JAVA';

-- e) Query to retrieve a list of course information for multiple courses.

select Course_name, Course_id, Course_instructor_name as Instructor_name 
from CoursesInfo;

/* f) Test the queries to ensure accurate retrieval of student information.
      (execute the queries and verify the results against the expected output.) */
      
select * from StudentInfo
where stu_name IN ('Rhea', 'Sneha');  -- Sample testing with IN operator.

select * from StudentInfo
where stu_name = 'Rhea' OR stu_name = 'Sneha';   -- Sample testing with OR operator.

/* 4) Reporting and Analytics (Using joining queries)
     a) Write a query to retrieve the number of students enrolled in each course. */

Select c.COURSE_NAME, COUNT(s.STU_NAME) AS Student_count
FROM
StudentInfo s
JOIN EnrollmentInfo e on s.stu_id = e.stu_id
Join CoursesInfo c on c.Course_ID = e.Course_ID
WHERE
e.ENROLL_STATUS = 'Enrolled'
Group by c.Course_name;

-- b) Query to retrieve list of students enrolled in a specific course.

Select s.STU_NAME as Students_enrolled_in_SQL
FROM
StudentInfo s
JOIN EnrollmentInfo e on s.stu_id = e.stu_id
Join CoursesInfo c on c.Course_ID = e.Course_ID
WHERE
e.ENROLL_STATUS = 'Enrolled' and e.course_id = '101';

-- c) Query to retrieve the count of students enrolled for each instructor.

Select c.course_instructor_name, count(s.stu_name) as Students_enrolled
from
StudentInfo s
JOIN EnrollmentInfo e on s.stu_id = e.stu_id
join CoursesInfo c on e.Course_id = c.course_id
where
e.ENROLL_STATUS = 'Enrolled'
Group by c.course_instructor_name;

-- d) Query to retrieve the list of students who are enrolled in multiple courses.

select s.STU_Name as Students_enrolled_in_multiple_courses
from
CoursesInfo c
JOIN EnrollmentInfo e on c.Course_ID = e.Course_ID
JOIN StudentInfo s on s.STU_ID = e.STU_ID
where ENROLL_STATUS = 'Enrolled'
GROUP BY
s.STU_NAME
Having
count(*) > 1;

-- e) Query to retrieve the list of courses that have the highest number of enrolled students (arrange from highest to lowest):

Select c.Course_name, Count(s.Stu_name) as Enrolled_students_Count
FROM
CoursesInfo c
Join EnrollmentInfo e on c.Course_ID = e.Course_ID
JOIN StudentInfo s on s.STU_ID = e.STU_ID
where ENROLL_STATUS = 'Enrolled'
group by
c.Course_name
order by
Enrolled_students_Count DESC;

select * from StudentInfo;
select * from CoursesInfo;
select * from EnrollmentInfo;
