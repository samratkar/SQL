-- 0. RETRIEVE ALL ROWS AND ALL COLUMNS OF THE EMPLOYEE TABLE
select * 
from employee;

-- 0. RETRIEVE FIRST NAME AND LAST NAME OF ALL EMPLOYEES 
select fname, lname 
from employee;

-- 1. RETRIEVE DETAILS OF ALL MALE EMPLOYEES WITH SALARIES ATLEAST 30000
select * 
from employee
where sex = 'M' and salary >= 30000

-- 2. RETRIEVE THE DETAILS OF ALL DEPENDENTS OF ESSN 33445555
select *
from dependent 
where essn = '333445555'

-- 3. RETRIEVE DETAILS OF PROJECTS THAT ARE BASED OUT OF HOUSTON OR STAFFORD 
select * 
from project
where plocation = 'Stafford' or plocation = 'Houston'

-- 4. RETRIEVE THE DETAILS OF THE PROJECTS THAT ARE BASED OUT OF HOUSTON OR BELONGS TO DEPARTMENT 4
select * 
from project
where plocation = 'Houston' or dnum = 4 

-- 5. Display the name of the department and the year in which the manager
--    was appointed (Hint: Use the YEAR() function YEAR(mgr_start_date)
select dname, year(mgr_start_date)
from department

-- 6. DISPLAY THE SSN OF ALL EMPLOYEES WHO LIVE IN HOUSTON
select ssn
from employee
where address like ('%Houston%')

-- 7. Display details of all (male employee who earn more than 30000) or female employees who earn less than 30000)
select * 
from employee
where (sex = 'M' and salary > 30000) or (sex = 'F' and salary < 30000)

-- 8. Display the essn of employees who have worked betwen 25 and 50 hours
--      a) Use AND clause
--      b) use BETWEEN clause  as in Hours between 25 and 30
select essn 
from works_on
where hours between 25 and 30

-- 9. Display the names of projects that are based out of houston or stafford
--      a) Use OR clause
--      b) Use IN clause as in Plocation in ('Houston', 'Stafford')
select pname 
from project
where plocation in ('Houston', 'Stafford')


-- 10. Display the names of the project that are neither based out of houston nor out of stafford
--      a) Use AND/OR clause
--      b) use NOT IN clause as in Plocation NOT IN ('Houston','Stafford')
select pname 
from project 
where plocation not in ('Houston', 'Stafford')

-- 11. Display the ssn and fully concatenated name of all employees
-- 	Use CONCAT function as in CONCAT(fname, ' ', minit, ' ', lname)
select ssn, concat(fname, ' ', minit, ' ', lname)
from employee

-- 12. Display the employee details who does not have supervisor
-- 	Use IS NULL as in super_ssn IS NULL
select * 
from employee
where super_ssn is null


-- 13. Display the ssn of employees sorted by their salary in ascending mode
-- 	Use ORDER by SALARY
select ssn, salary
from employee
order by salary asc 

select ssn, salary 
from employee
order by salary desc


-- 14. Sort the works_on table based on Pno and Hours
select * 
from works_on
order by pno, hours

-- 15. Display the average project hours 
select avg(hours)
from works_on 

-- 16. Display the number of employees who do not have a manager
select count(ssn)
from employee
where super_ssn is null 
-- number of employees with supervisor 
select count(super_ssn)
from employee

-- 17. What is the average salary of employees who do not have a manager
select avg(salary)
from employee
where super_ssn is null;

-- 18. What is the highest salary of female employees
select max(salary)
from employee

-- 19. What is the least salary of male employees
select min(salary)
from employee

-- 20. Display the number of employees in each department
select dno, count(*) as 'Number of employees' 
from employee
group by dno
order by dno

-- 21. Display the average salary of employees (department-wise and gender-wise)
-- 	GROUP BY Dno, Sex
select avg(salary), dno 
from employee
group by dno, sex
order by dno

-- 22. Display the number of male employees in each department
select dno, sex, count(ssn)
from employee
where sex = 'M'
group by  dno

-- 23. Display the average, minimum, maximum hours spent in each project
select pno, avg(hours), min(hours), max(hours) 
from works_on
group by pno

-- 24. Display the year-wise count of employees based on their year of birth
select year(bdate), count(*) as 'Count of employees'
from employee
group by year(bdate)
order by year(bdate)

-- 25. Dipslay the number of projects each employee is working on
select essn, count(pno) as 'Number of Projects being worked on'
from works_on
group by essn
order by essn   

-- 26. Display the Dno of those departments that has at least 3 employees
select dno, count(*)
from employee 
group by dno 
having count(dno) >=3

-- 27. Among the people who draw at least 30000 salary, what is the department-wise average?
select dno, avg(salary)
from employee
where salary >= 30000 
group by dno

-- 27b. Instead of dno, display dname
select dname, avg(salary)
from employee
group by dno
where salary >= 30000 and dname in (select dname from department where dnumber = dno)






-- MISCS

select pno, count(essn)
from works_on 
group by pno

select * 
from works_on 
order by pno, hours
