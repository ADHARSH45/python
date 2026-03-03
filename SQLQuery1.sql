use company_db;

select * from employee;
select * from department;

create table projects(
	prj_id int primary key,
	dept_id int,
	prj_name varchar(50),
	location varchar(50),
	start_date date,
	foreign key (dept_id) references department(dept_id));

drop table employee;
create table employee(
	emp_id int primary key,
	emp_name varchar(50),
	salary decimal(10,2),
	hire_date date,
	dept_id int,
	prj_id int
	foreign key (dept_id) references department(dept_id),
	foreign key (prj_id) references projects(prj_id));

INSERT INTO employee (emp_id, emp_name, salary, hire_date, dept_id, prj_id) VALUES
(1, 'Adharsh Nair', 45000.00, '2022-01-15', 101, 201),
(2, 'Meera Krishnan', 52000.50, '2021-03-10', 102, 202),
(3, 'Rahul Menon', 61000.75, '2020-07-22', 103, 203),
(4, 'Anjali Varma', 48000.00, '2023-05-18', 101, 204),
(5, 'Vishnu Raj', 70000.25, '2019-11-30', 104, 201),
(6, 'Sneha Pillai', 53000.00, '2022-09-12', 102, 205),
(7, 'Arjun Kumar', 46000.80, '2023-02-01', 103, 202),
(8, 'Divya Mohan', 59000.40, '2021-12-05', 104, 203),
(9, 'Kiran Das', 62000.00, '2020-04-17', 105, 204),
(10, 'Lakshmi N', 75000.90, '2018-08-25', 101, 205);

select * from department;
truncate table  department;

create table departments(dept_id int primary key,dept_name varchar(50),dept_location varchar(50));
INSERT INTO departments (dept_id, dept_name, dept_location) VALUES
(101, 'Software Development', 'Bangalore'),
(102, 'Data Science', 'Hyderabad'),
(103, 'Human Resources', 'Chennai'),
(104, 'Finance', 'Mumbai'),
(105, 'Marketing', 'Delhi'),
(106, 'Cloud Engineering', 'Pune'),
(107, 'Cyber Security', 'Kolkata'),
(108, 'DevOps', 'Noida'),
(109, 'Business Analysis', 'Ahmedabad'),
(110, 'Product Management', 'Gurgaon');

SELECT constraint_name
FROM information_schema.table_constraints
WHERE table_name = 'employee'
AND constraint_type = 'FOREIGN KEY';

ALTER TABLE employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);

ALTER TABLE employee
ADD CONSTRAINT fk_employee_project
FOREIGN KEY (prj_id)
REFERENCES projects(prj_id);

ALTER TABLE projects
ADD CONSTRAINT fk_projects_department
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);

INSERT INTO projects (prj_id, dept_id, prj_name, location, start_date) VALUES
(201, 101, 'AI Recruitment System', 'Bangalore', '2023-01-15'),
(202, 102, 'Customer Churn Prediction', 'Hyderabad', '2022-11-10'),
(203, 103, 'HR Automation Portal', 'Chennai', '2023-03-05'),
(204, 104, 'Financial Analytics Dashboard', 'Mumbai', '2021-08-20'),
(205, 105, 'Digital Marketing Campaign', 'Delhi', '2023-06-12'),
(206, 106, 'Cloud Migration Project', 'Pune', '2022-04-18'),
(207, 107, 'Security Audit System', 'Kolkata', '2023-02-25'),
(208, 108, 'CI/CD Pipeline Setup', 'Noida', '2021-12-01'),
(209, 109, 'Business Intelligence Tool', 'Ahmedabad', '2022-07-30'),
(210, 110, 'Product Launch Strategy', 'Gurgaon', '2023-05-14');

select * from employee;
select * from departments;
select * from projects;

select e.emp_name,d.dept_name,p.prj_name 
from employee e join projects p on e.prj_id = p.prj_id  
join departments d on p.dept_id = d.dept_id; 

select count(*) as number_of_employees,d.dept_name from employee e join departments d on e.dept_id = d.dept_id group by(d.dept_name);

select d.dept_name,avg(e.salary) as avg_salary 
from employee e join departments d on e.dept_id = d.dept_id 
group by(d.dept_name) having avg(e.salary) > 50000;

select * from projects;

UPDATE projects SET budjet = 800000 WHERE prj_id = 201;
UPDATE projects SET budjet = 650000 WHERE prj_id = 202;
UPDATE projects SET budjet = 720000 WHERE prj_id = 203;
UPDATE projects SET budjet = 900000 WHERE prj_id = 204;
UPDATE projects SET budjet = 550000 WHERE prj_id = 205;

UPDATE projects SET budjet = 800000 WHERE prj_id = 206;
UPDATE projects SET budjet = 650000 WHERE prj_id = 207;
UPDATE projects SET budjet = 720000 WHERE prj_id = 208;
UPDATE projects SET budjet = 900000 WHERE prj_id = 209;
UPDATE projects SET budjet = 550000 WHERE prj_id = 210;

select d.dept_name,sum(p.budjet) as total_budjet  from departments d join projects p on d.dept_id = p.dept_id group by(d.dept_name);

create view heigh_performing_employees as
select * from employee where salary > 50000;

select * from heigh_performing_employees;

create view salary_summary as
select d.dept_name,sum(e.salary) as total_salary from employee e join departments d on e.dept_id =d.dept_id group by(d.dept_name);

select * from salary_summary;

select * from employee where  salary > (select avg(salary) from employee);

select top 3* from salary_summary order by total_salary desc;

