hive> show databases;
/* OK
default
newdb */ 

hive> create database if not exists COMPANY;
/* OK
Time taken: 0.084 seconds */

hive> use COMPANY;
/* OK
Time taken: 0.038 seconds */

hive> create table if not exists emp(empno int, ename string, sal float, comm float, dpno int) row format delimited fields terminated by ',';
/* OK
Time taken: 0.222 seconds */
hive> SHOW TABLES;
/* OK
emp */
Time taken: 0.015 seconds, Fetched: 1 row(s)

hive> load data local inpath '/home/cloudera/Desktop/emp.csv' into table emp;
/* Loading data to table company.emp
Table company.emp stats: [numFiles=1, totalSize=445]
OK
Time taken: 0.697 seconds */

hive> select *from emp;
/* OK
NULL	ename	NULL	NULL	NULL
7839	KING	NULL	5000.0	NULL
7782	CLARK	NULL	2450.0	NULL
7934	MILLER	NULL	1300.0	NULL
7369	SMITH	NULL	800.0	NULL
7566	JONES	NULL	2975.0	NULL
7876	ADAMS	NULL	1100.0	NULL
7902	FORD	NULL	3000.0	NULL
7788	SCOTT	NULL	3000.0	NULL
7499	ALLEN	NULL	1600.0	300
7844	TURNER	NULL	1500.0	0
7900	JAMES	NULL	950.0	NULL
7698	BLAKE	NULL	2850.0	NULL
7654	MARTIN	NULL	1250.0	1400
7521	WARD	NULL	1250.0	500 
Time taken: 0.422 seconds, Fetched: 15 row(s) */

hive> create external table ext_emp(empno int, ename string, sal float, comm float, dpno int) row format delimited fields terminated by ',' location '/user/cloudera/SHARWIN/Ext';
/* OK
Time taken: 0.081 seconds */

hive> load data local inpath '/home/cloudera/Desktop/emp.csv' into table ext_emp;
/* Loading data to table company.ext_emp
Table company.ext_emp stats: [numFiles=1, totalSize=445]
OK
Time taken: 0.331 seconds */





