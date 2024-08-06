CREATE TABLE employee_history (Employee_History_ID serial primary key,
                       Hire_DT date,
                       Start_DT date,
                       End_DT date,
                       Job_Title varchar(100),
                       Salary_ID int,
                       Department varchar(50),
                       Manager int,
                       Employee_ID int,
                       Location_ID int,
                       Education_ID int
                       
                      );
                      
CREATE TABLE salary (Salary_ID SERIAL primary key,
                    Salary_Amount int
                    );
                    

CREATE TABLE education (Education_ID SERIAL primary key,
                       Education_Level varchar(50));
                       

CREATE TABLE location (Location_ID SERIAL primary key,
                        Address varchar(100),
                      Location_NM varchar(50),
                      City varchar(50),
                       State varchar(2)
                      );
                      
CREATE TABLE employee(Employee_ID serial primary key,
                     EMP_ID varchar(8),
                     Employee_NM varchar(50),
                      Email varchar(100)
                     );
                      

Alter table employee_history
ADD CONSTRAINT fk_salary_id FOREIGN KEY (salary_id) REFERENCES salary(Salary_ID);


Alter table employee_history
ADD CONSTRAINT fk_manager_id FOREIGN KEY (manager) REFERENCES employee(Employee_ID);

Alter table employee_history
ADD CONSTRAINT fk_employee_id FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID);


Alter table employee_history
ADD CONSTRAINT fk_location_id FOREIGN KEY (Location_ID) REFERENCES location(Location_ID);


Alter table employee_history
ADD CONSTRAINT fk_education_id FOREIGN KEY (Education_ID) REFERENCES education(Education_ID);




--SELECT * FROM employee;

--Inserts
Insert into salary(Salary_Amount)
select distinct salary from proj_stg;



--SELECT * FROM salary;



Insert into education(Education_Level)
select distinct education_lvl from proj_stg;

--select * from education;

insert into location(Address, Location_NM, city, state)
select p.address, p.location, p.city, p.state
from proj_stg as p
group by p.address, p.location, p.city, p.state;

--select * from location;

insert into employee(EMP_ID, Employee_NM, Email)
select p.Emp_ID, p.Emp_NM, p.Email
from proj_stg as p
group by p.Emp_ID, p.Emp_NM, p.Email;


--SELECT * FROM employee;

insert into employee_history(Hire_DT,
                       Start_DT,
                       End_DT,
                       Job_Title,
                       Salary_ID,
                       Department,
                       Manager,
                       Employee_ID,
                       Location_ID,
                       Education_ID)
select 
p.hire_dt, 
p.start_dt,
p.end_dt,
p.job_title,
s.Salary_ID,
p.department_nm,
m.Employee_ID,
e.Employee_ID,
l.Location_ID,
edu.Education_ID
from proj_stg as p
join salary as s
on p.salary = s.Salary_Amount
left join employee as m
on p.Manager = m.Employee_NM
join employee as e
on p.Emp_NM = e.Employee_NM
join location as l
on p.address = l.address
join education as edu
on p.education_lvl = edu.Education_Level;

--select * from employee_history;

select e.Employee_NM, h.Job_Title, h.Department
from employee_history as h
join employee as e
on h.Employee_ID = e.Employee_ID;


Insert into employee_history (job_title)
Values ('Web Programmer');

select * from employee_history
where job_title = 'Web Programmer';

UPDATE employee_history
SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';

select * from employee_history
where job_title = 'Web Developer';

Delete from employee_history
Where job_title = 'Web Developer';

select h.Department, count(e.Employee_NM) as employee_count
from employee_history as h
join employee as e
on h.Employee_ID = e.Employee_ID
group by h.Department;


select e.Employee_NM, h.Job_Title, h.Department, m.Employee_NM as Manager, h.Start_DT, h.End_DT
from employee_history as h
join employee as e
on h.Employee_ID = e.Employee_ID
left join employee as m
on h.Manager = m.Employee_ID
where e.Employee_NM = 'Toni Lembeck';



--psql -f /home/workspace/scratchpad.sql