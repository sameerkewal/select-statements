--nvl
--practice by doing an exercise waar je die mensen zonder manager zoekt en hun een nieuwe manager geeft or sth 

--if the function is null it returns 0
--the 2 values you pass to the nvl must be the same datatype
select EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, nvl(COMMISSION_PCT, 0)
from EMPLOYEES;


--if employee with no job then this shall appear
select EMPLOYEE_ID, FIRST_NAME, JOB_ID, nvl(JOB_ID, 'No Job yet')
from EMPLOYEES
order by JOB_ID;


select EMPLOYEE_ID, FIRST_NAME, JOB_ID, nvl(HIRE_DATE, '1-Jan-03')
from EMPLOYEES;



create table test(
    test_id number generated by DEFAULT on null as identity,
    test_date DATE
);


insert into test(test_date)
values('1 Jan 2002');
insert into test(test_date)
values('10 Jan 2003');
insert into test(test_date)
values('1 Jun 2004');

--Ook bij nvl wordt er implicit conversion gedaan. In dit geval gaat het om die date(Zolang het een valid format is ofc)
select test_id, nvl(test_date, '20 June 2002')
from TEST;



--omdat commission pct is a number,dan als je "no commission wilt displayen" moet je die commission_pct eerst converten naar een char
--since same datatype and all
select EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, nvl(to_char(COMMISSION_PCT), 'No commission')
from EMPLOYEES;

--nvl2 neemt 3 arguments
--if exp1 is not null then it returns expr2
--if exp1 is null then it returns the expr3
select EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, nvl2(COMMISSION_PCT, COMMISSION_PCT, 0)
from EMPLOYEES;

--nvl2 is ook flexible when it comes to datatype, unlike nvl
--However expression2 and expr3 moeten wel dezelfde datatype zijn.
select EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, nvl2(COMMISSION_PCT, 'sal and comm', 'only salary')
income from EMPLOYEES;


--nullif
--nullif neemt 2 parameters. Als expr1=expr2 then it returns null, else it returns expr1

/* 
Eliminating specific values: You can use NULLIF to convert specific values to NULL. For instance, 
if you have a column that contains a default value or a placeholder 
that you want to treat as NULL, you can use NULLIF to achieve that. For example:
SELECT NULLIF(column_name, 'default') AS modified_column
FROM your_table; */


select FIRST_NAME, LENGTH(FIRST_NAME), LAST_NAME, length(LAST_NAME),
nullif(LENGTH(FIRST_NAME), length(LAST_NAME)) results 
from EMPLOYEES;



--in geval je for some reason alle gevallen waar commission pct null is will displayen als null
select COMMISSION_PCT,
        nullif(COMMISSION_PCT, 0.3)
from EMPLOYEES
order by COMMISSION_PCT;


--coalesce will return the first not null value
select EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
COALESCE(COMMISSION_PCT, MANAGER_ID, salary) from EMPLOYEES;

--nested nvl is the same as using coalesce
--in dit geval, inner shit checkt als commission_pct null is,
-- dan returned het manager_id. Als het niet null is dan returned het commission_pct

--Die outer function checkt als die waarde dat is gekomen uit die inner function null is. If it is null then return salary
--if not null just return the value that came out the inner function
select employee_id, FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY, 
nvl(nvl(COMMISSION_PCT, MANAGER_ID),salary)
from EMPLOYEES;



--als je values niet gelijk zijn dan returned het expression 1
select nullif(to_date('21 Jan 2002', 'DD Mon yyyy'), to_date('20 Jan 2002', 'DD Mon yyyy')) from dual;


--if expression 1 is not null then it returns expression 2
--if expression 1 is null then it returns expression 3
select nvl2('not null', 'yippee', 'value3') from dual;
select nvl2(null, 'yippee', 'value3') from dual;


select nvl(null, 'expression2', 'expression3')from dual;
