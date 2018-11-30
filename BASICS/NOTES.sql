1. There are two wild cards in SQL. They are - % and _
% denotes one or more than one repitition of any character. (It is like . in linux and python)
_ denotes only one character

example - _r% (a sequence where r is the second character following by one ore more than one characters. )

2. Understand the difference between 'order by' and 'group by'

3. You cannot print all the columns when you are doing an aggregation using 'group by'
for example you cannot do the following -
select *
from works_on
group by pno

Rather you need to do the following -
select pno, count(essn)
from works_on
group by pno

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
