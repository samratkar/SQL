1. NOTE : wildcards
There are two wild cards in SQL. They are - % and _
--% denotes one or more than one repitition of any character. (It is like . in linux and python)
_ denotes only one character

example - _r% (a sequence where r is the second character following by one ore more than one characters. )

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

6. NESTING SQL QUERIES always look forward for scope. You cannot access a variable a select clause from a select clause previous to it. You need to write a new select clause in front, as depicted below.

select pno, count(*) numemps
from works_on
group by pno
having numemps = (select min (nemps) from (select pno, count(*) nemps from works_on group by pno) tmp)

7. TABLE ALIAS
When working with multiple tables, one should use aliases for the table as below -
-- 34. Display the ssn, lname, name of project of all the employees

select e.ssn, e.lname, p.pname
from employee e inner join works_on w on e.ssn = w.essn
	inner join project p on w.pno = p.pnumber;
