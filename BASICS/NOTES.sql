1. NOTE : wildcards
There are two wild cards in SQL. They are - % and _
--% denotes one or more than one repitition of any character. (It is like . in linux and python)
_ denotes only one character

example - _r% (a sequence where r is the second character following by one ore more than one characters. )

How many countries are there whose name starts with I and ends with A
select Name
from country
where Name like 'I%A'

2. NOTE: order by and group by
Understand the difference between 'order by' and 'group by'

3. NOTE: group by parameter should be selected first in the select clause.
You cannot print all the columns when you are doing an aggregation using 'group by'
for example you cannot do the following -
select *
from works_on
group by pno

Rather you need to do the following -
select pno, count(essn)
from works_on
group by pno

--NOTE: The select clause should only have the aggregator function on the columns on which group by is not being done. For example you cannot print essn in the above query.
-- 30. Which project(s) have the least number of employees?



4. order by clause should come after group by clause.

5. understand the difference between 'having' and 'where' clauses. Basically 'having' is 'where' with an aggregator function.

Note here that we are not doing an aggregation. So, where is fine.
select dno, avg(salary)
from employee
where salary >= 30000
group by dno

But since we are doing an aggregation below, having is used.
select dno, count(*)
from employee
group by dno
having count(dno) >=3

Among the following, which language is the official language of the more number of countries?
select Language, count(CountryCode) ct, IsOfficial
from countrylanguage
where IsOfficial='T'
group by Language
order by ct desc

6. NESTING SQL QUERIES always look forward for scope. You cannot access a variable a select clause from a select clause previous to it. You need to write a new select clause in front, as depicted below.

select pno, count(*) numemps
from works_on
group by pno
having numemps = (select min (nemps) from (select pno, count(*) nemps from works_on group by pno) tmp)

7. CORRELATED SUB QUERIES - CONTRARY TO WHAT IS WRITTEN ABOVE, WE CAN ACCESS A TABLE ON OUR LEFT. THEY ARE CORRELATED SUB QUERY.
-- 41. CORRELAtED QUERY
-- SHOW THE NAMES OF EMPLOYEES WHOSE SALARY IS GREATER THAN THE RESPECTIVE DEPARTEMENTS AVERAGE SALARY
select fname, lname, salary, dno
from employee e1
where salary >= (select avg(salary)
                from employee e2
                where e2.dno = e1.dno)
--NOTE: we can always use the aggregator function based out of just where clause, instead of any group by operation!!


8. TABLE ALIAS
When working with multiple tables, one should use aliases for the table as below -
-- 34. Display the ssn, lname, name of project of all the employees

select e.ssn, e.lname, p.pname
from employee e inner join works_on w on e.ssn = w.essn
	inner join project p on w.pno = p.pnumber;

9. USING RESULTS OF NESTED QUERIES AS EXPRESSIONS.
-- 36. What is the name of the department that has least number of
--     employees?
select dname, count(ssn) c
from employee inner join department on dno=dnumber
group by dname
having c = (select min(ct)
			from (select count(ssn) ct
				  from employee
				  group by dno
                  )t
			);

NOTE THAT THIS IS NOT THE CASE OF NESTED SELECT -
select dname, avg(salary) avsal
from employee inner join department on dno=dnumber
group by dname
having avsal = (select max(salary)
								from employee
                )


10. EVERY DERIVED TABLE MUST HAVE ITS OWN ALIAS.
DONT USE 'TABLE' AS ALIAS, AS IT IS A STANDARD KEYWORD.
-- 37. What is the name of the department whose employees have the highest
--     average salary?
select dname, avg(salary) avsal
from employee inner join department on dno=dnumber
group by dname
having avsal = (select max(salary)
								from employee
                )t

11. group by can exist without aggregator methods.
select max(salary) from employee

12. NOTE THAT THIS IS THE CASE WHERE THERE IS NO SUB TABLE. SO NAMING IS NOT REQUIRED. NOTE THAT EVEN THERE ARE TWO SELECT IN THIS CASE, BUT IT IS NOT A CASE OF NESTED SELECT. NESTED SELECT HAPPENS WHEN YOU HAVE A SELECT USED INSTEAD OF A TABLE IN THE 'FROM' CLAUSE.
-- 37. What is the name of the department whose employees have the highest
--     average salary?
select dname, avg(salary) avsal
from employee inner join department on dno=dnumber
group by dname
having avsal = (select max(salary)
								from employee
                )

13. REMOVING DUPLICATES
select distinct * from emp

14. JOINING ONE TABLE TO ITSELF.
-- 38. Display the fname of the employee along with the fname of the manager
--METHOD 1
select emp.fname, mgr.mgr_fname
from employee emp inner join
    (select distinct e.ssn mgr_ssn, e.fname mgr_fname
        from employee e inner join employee s on e.ssn=s.super_ssn) mgr
where emp.super_ssn = mgr_ssn

--METHOD 2
select e.fname 'EmpName', m.fname 'MgrName'
from employee e, employee m
where e.super_ssn = m.ssn;

15. 4 WAY JOIN
-- 35a. Display the ssn, their department, the project they work on and
--     the name of the department which runs that project
-- 	Hint: Needs a 5 table join
-- 	Output heading: ssn, emp-dept-name, pname, proj-dept-no
select ssn, dname as 'emp-dept-name' , pname, pnumber as 'proj-dept-no'
from employee e inner join department d on e.dno=d.dnumber
				inner join works_on w on e.ssn=w.essn
                inner join project p on w.pno=p.pnumber

16. SELECT THE FIRST ROW OF THE TABLE, USE THE COMMAND
limit 1
