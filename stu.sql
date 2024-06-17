use student
create table students(student_id int primary key,
first_name varchar(50), last_name varchar(50),
date_of_birth date,email varchar(50),phone_number varchar(15));

insert into students values
(1,'Alex','Volkov','2002-03-22','alexavavolkov@gmail.com','7025183020'),
(2,'Stella','Alonso','2001-05-30','stellachristian@gmail.com','9627004073'),
(3,'Josh','Chen','2002-11-23','joshchenjules@gmail.com','9632510576'),
(4,'Bridget','Rhys','2001-12-03','princessbridget@gmail.com','7832154009')

select * from students;

create table teachers (teacher_id int primary key,
first_name nvarchar(20),last_name nvarchar(20),email nvarchar(50));
insert into teachers values
(1,'David','Martin','david.martin@gmail.com'),
(2,'Michael','Thomas','michael.thomas@gmail.com'),
(3,'Sarah','White','sarah.white@gmail.com'),
(4,'Laura','Lee','laura.lee@gmail.com');

select * from teachers;

create table courses(course_id int primary key,course_name nvarchar(30),
credits int,teacher_id int foreign key references teachers(teacher_id));
insert into courses values
(101,'science',3,1),
(102,'biology',2,2),
(103,'chemistry',4,3),
(104,'English',3,4);

select * from courses;

create table enrollment(enrollment_id int primary key,
student_id int foreign key references students(student_id),course_id int,enrollment_date date);
insert into enrollment values
(1,1,101,'2023-01-10'),
(2,2,102,'2023-01-11'),
(3,3,103,'2023-01-12'),
(4,4,104,'2023-01-13');

select * from enrollment;

create table payments(payment_id int primary key,student_id int foreign key references students(student_id),
amount decimal(10,2), payment_date date);
insert into payments values
(1,1,1000.00,'2023-02-01'),
(2,2,2000.00,'2023-02-02'),
(3,3,1500.00,'2023-02-03'),
(4,4,1300.00,'2023-02-04');

select * from payments;
--TASKS:
--1. Write an SQL query to insert a new student named John Doe into the "Students" table.
insert into students values
(5,'John','Doe','2000-04-13','johndoe@gmail.com','9010353222');
select * from students

--2. Write an SQL query to enroll an existing student in a course, specifying the enrollment date.
select * from courses;
select * from students;
select * from enrollment
insert into enrollment values (5,1,101,'2023-03-11')
--3. Update the email address of a teacher in the "Teachers" table.
update teachers set email='lauralee.er4@gmail.com' where teacher_id=4;
select * from teachers

--4. Write an SQL query to delete a specific enrollment record, choosing based on the student and course.
select * from courses;
select * from students;
select * from enrollment;
delete from enrollment where student_id=3 and course_id=103;

--5.Update a course to assign a specific teacher using the "Courses" table.
select * from courses;
select * from teachers;
update courses set teacher_id=3 where course_id=102

--6. Write an SQL query to calculate the total payments made by a specific student.
select SUM(amount) as total from payments where student_id=(select );
select * from students;
select * from payments;

--7. Retrieve a list of courses along with the count of students enrolled in each.
select * from courses;
select * from students;
select * from enrollment
select c.course_name,
(select COUNT(student_id) from enrollment as e where e.course_id=c.course_id) 
as stu_count from courses c;

--8. Find the names of students who have not enrolled in any course.
select * from courses;
select * from students;
select * from enrollment
select s.first_name,s.last_name from students as s where s.student_id not in(select student_id from enrollment)

--9. Retrieve the first name and last name of students, along with the names of the courses they are enrolled in.
select first_name,last_name,course_name from students as s 
join enrollment as e on s.student_id=e.student_id 
join courses as c on e.course_id=c.course_id

--10. List names of teachers and the courses they are assigned to.
select * from courses;
select * from teachers;
select first_name ,last_name,course_name from teachers as t join courses as c on t.teacher_id=c.teacher_id

--11. Calculate the average number of students enrolled in each course 
--using aggregate functions and subqueries.
select * from courses;
select * from students;
select * from enrollment
select AVG(student_count)as avg_count	
from(select course_id, COUNT(student_id) as student_count from enrollment group by course_id)
as course_enrollments;

--12. Identify the student(s) who made the highest payment using a subquery.
select * from payments
select * from students
select top 1* from 
(Select student_id,sum(amount) as Total_amount from Payments  group by student_id ) as new 
order by Total_amount desc ;

--13. Retrieve a list of courses with the highest number of enrollments using subqueries.
select * from courses
select * from enrollment
select course_id,course_name from courses as c where course_id in
(select course_id from enrollment as e
group by course_id) 

--15. Identify students who are enrolled in more than one course.

select Students.student_id,CONCAT(first_name,' ',last_name)as stu_name,No_of_courses from Students 
inner join(Select count(course_id) as No_of_courses, student_id  from Enrollment group by student_id) 
as counts
on Students.student_id=counts.student_id where No_of_courses>1;