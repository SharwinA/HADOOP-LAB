[cloudera@quickstart ~]$ hdfs dfs -ls
Found 5 items
/* drwx------   - cloudera cloudera          0 2022-11-24 21:00 .Trash
drwx------   - cloudera cloudera          0 2022-11-24 22:17 .staging
drwxr-xr-x   - cloudera cloudera          0 2022-11-24 21:47 Desktop
drwxr-xr-x   - cloudera cloudera          0 2022-11-24 21:54 SHARWIN
drwxr-xr-x   - cloudera cloudera          0 2022-09-30 21:14 SJCOCT22 */


[cloudera@quickstart ~]$ hadoop fs -copyFromLocal /home/cloudera/Desktop/emp.csv /user/cloudera/SHARWIN
[cloudera@quickstart ~]$ hdfs dfs -copyFromLocal /home/cloudera/Desktop/text.txt /user/cloudera/SHARWIN

grunt> A = load '/user/cloudera/SHARWIN/emp.csv' using PigStorage(',') as (eid:int, ename:chararray, epos:chararray, esal:int, ecom:int, edpno:int);
grunt> dump A;
/* (,ename,epos,,,)
(7839,KING,PRESIDENT,5000,,10)
(7782,CLARK,MANAGER,2450,,10)
(7934,MILLER,CLERK,1300,,10)
(7369,SMITH,CLERK,800,,20)
(7566,JONES,MANAGER,2975,,20)
(7876,ADAMS,CLERK,1100,,20)
(7902,FORD,ANALYST,3000,,20)
(7788,SCOTT,ANALYST,3000,,20)
(7499,ALLEN,SALESMAN,1600,300,30)
(7844,TURNER,SALESMAN,1500,0,30)
(7900,JAMES,CLERK,950,,30)
(7698,BLAKE,MANAGER,2850,,30)
(7654,MARTIN,SALESMAN,1250,1400,30)
(7521,WARD,SALESMAN,1250,500,30)*/

grunt> B = filter A by edpno==30 and epos=='SALESMAN';
grunt> dump B;
/* (7499,ALLEN,SALESMAN,1600,300,30)
(7844,TURNER,SALESMAN,1500,0,30)
(7654,MARTIN,SALESMAN,1250,1400,30)
(7521,WARD,SALESMAN,1250,500,30) */

grunt> c= limit A 5;
grunt> dump c;
/* (,ename,epos,,,)
(7369,SMITH,CLERK,800,,20)
(7782,CLARK,MANAGER,2450,,10)
(7839,KING,PRESIDENT,5000,,10)
(7934,MILLER,CLERK,1300,,10) */

grunt> d= order A by esal;
grunt> dump d;
/* (,ename,epos,,,)
(7369,SMITH,CLERK,800,,20)
(7900,JAMES,CLERK,950,,30)
(7876,ADAMS,CLERK,1100,,20)
(7521,WARD,SALESMAN,1250,500,30)
(7654,MARTIN,SALESMAN,1250,1400,30)
(7934,MILLER,CLERK,1300,,10)
(7844,TURNER,SALESMAN,1500,0,30)
(7499,ALLEN,SALESMAN,1600,300,30)
(7782,CLARK,MANAGER,2450,,10)
(7698,BLAKE,MANAGER,2850,,30)
(7566,JONES,MANAGER,2975,,20)
(7788,SCOTT,ANALYST,3000,,20)
(7902,FORD,ANALYST,3000,,20)
(7839,KING,PRESIDENT,5000,,10) */

grunt> e= order A by epos desc;
grunt> dump e;
/* (,ename,epos,,,)
(7521,WARD,SALESMAN,1250,500,30)
(7654,MARTIN,SALESMAN,1250,1400,30)
(7844,TURNER,SALESMAN,1500,0,30)
(7499,ALLEN,SALESMAN,1600,300,30)
(7839,KING,PRESIDENT,5000,,10)
(7698,BLAKE,MANAGER,2850,,30)
(7566,JONES,MANAGER,2975,,20)
(7782,CLARK,MANAGER,2450,,10)
(7876,ADAMS,CLERK,1100,,20)
(7369,SMITH,CLERK,800,,20)
(7934,MILLER,CLERK,1300,,10)
(7900,JAMES,CLERK,950,,30)
(7902,FORD,ANALYST,3000,,20)
(7788,SCOTT,ANALYST,3000,,20) */

grunt> f = foreach A generate ename;
grunt> dump f;
/* (ename)
(KING)
(CLARK)
(MILLER)
(SMITH)
(JONES)
(ADAMS)
(FORD)
(SCOTT)
(ALLEN)
(TURNER)
(JAMES)
(BLAKE)
(MARTIN)
(WARD) */

grunt> g = foreach A generate *, esal*5 as Incentives;
grunt> dump g;
/* (,ename,epos,,,,)
(7839,KING,PRESIDENT,5000,,10,25000)
(7782,CLARK,MANAGER,2450,,10,12250)
(7934,MILLER,CLERK,1300,,10,6500)
(7369,SMITH,CLERK,800,,20,4000)
(7566,JONES,MANAGER,2975,,20,14875)
(7876,ADAMS,CLERK,1100,,20,5500)
(7902,FORD,ANALYST,3000,,20,15000)
(7788,SCOTT,ANALYST,3000,,20,15000)
(7499,ALLEN,SALESMAN,1600,300,30,8000)
(7844,TURNER,SALESMAN,1500,0,30,7500)
(7900,JAMES,CLERK,950,,30,4750)
(7698,BLAKE,MANAGER,2850,,30,14250)
(7654,MARTIN,SALESMAN,1250,1400,30,6250)
(7521,WARD,SALESMAN,1250,500,30,6250) */

grunt> describe g;
-- g: {eid: int,ename: chararray,epos: chararray,esal: int,ecom: int,edpno: int,Incentives: int}

grunt> h= foreach A generate SUBSTRING(ename,0,1);
grunt> dump  h
*/ (e)
(K)
(C)
(M)
(S)
(J)
(A)
(F)
(S)
(A)
(T)
(J)
(B)
(M)
(W) */ 

grunt> i = group A by epos;
grunt> dump i;
/* (epos,{(,ename,epos,,,)})
(CLERK,{(7934,MILLER,CLERK,1300,,10),(7369,SMITH,CLERK,800,,20),(7900,JAMES,CLERK,950,,30),(7876,ADAMS,CLERK,1100,,20)})
(ANALYST,{(7902,FORD,ANALYST,3000,,20),(7788,SCOTT,ANALYST,3000,,20)})
(MANAGER,{(7566,JONES,MANAGER,2975,,20),(7698,BLAKE,MANAGER,2850,,30),(7782,CLARK,MANAGER,2450,,10)})
(SALESMAN,{(7499,ALLEN,SALESMAN,1600,300,30),(7844,TURNER,SALESMAN,1500,0,30),(7654,MARTIN,SALESMAN,1250,1400,30),(7521,WARD,SALESMAN,1250,500,30)})
(PRESIDENT,{(7839,KING,PRESIDENT,5000,,10)}) */

grunt> j = foreach i generate group as epos, COUNT($1) as count;
grunt> dump j;
/* (epos,0)
(CLERK,4)
(ANALYST,2)
(MANAGER,3)
(SALESMAN,4)
(PRESIDENT,1) */

grunt> k = group A all;
grunt> k1 = foreach k generate MAX(A.esal) as maxsal,MIN(A.esal) as minsal, SUM(A.esal) as sumsal, COUNT($1) as count;
grunt> dump k1;
-- (5000,800,29025,14)

grunt> l = group A by (edpno, epos);
grunt> dump l;
/* ((10,CLERK),{(7934,MILLER,CLERK,1300,,10)})
((10,MANAGER),{(7782,CLARK,MANAGER,2450,,10)})
((10,PRESIDENT),{(7839,KING,PRESIDENT,5000,,10)})
((20,CLERK),{(7369,SMITH,CLERK,800,,20),(7876,ADAMS,CLERK,1100,,20)})
((20,ANALYST),{(7788,SCOTT,ANALYST,3000,,20),(7902,FORD,ANALYST,3000,,20)})
((20,MANAGER),{(7566,JONES,MANAGER,2975,,20)})
((30,CLERK),{(7900,JAMES,CLERK,950,,30)})
((30,MANAGER),{(7698,BLAKE,MANAGER,2850,,30)})
((30,SALESMAN),{(7521,WARD,SALESMAN,1250,500,30),(7654,MARTIN,SALESMAN,1250,1400,30),(7844,TURNER,SALESMAN,1500,0,30),(7499,ALLEN,SALESMAN,1600,300,30)})
((,epos),{(,ename,epos,,,)}) */

grunt> SPLIT A into B1 if edpno==10, C1 if edpno==20, D1 if epos=='MANAGER';
grunt> dump D1;
/* (7782,CLARK,MANAGER,2450,,10)
(7566,JONES,MANAGER,2975,,20)
(7698,BLAKE,MANAGER,2850,,30) */

grunt> dump B1;
/* (7839,KING,PRESIDENT,5000,,10)
(7782,CLARK,MANAGER,2450,,10)
(7934,MILLER,CLERK,1300,,10) */

grunt> dump C1;
/* (7369,SMITH,CLERK,800,,20)
(7566,JONES,MANAGER,2975,,20)
(7876,ADAMS,CLERK,1100,,20)
(7902,FORD,ANALYST,3000,,20)
(7788,SCOTT,ANALYST,3000,,20) */

grunt> B = load '/user/cloudera/SHARWIN/dept.csv' using PigStorage(',') as (edpno:int,epos:chararray,ecity:chararray);
grunt> dump B;
/* (,epos,ecity)
(10,ACCOUNTING,NEW YORK)
(20,RESEARCH,DALLAS)
(30,SALES,CHICAGO)
(40,OPERATIONS,BOSTON) */

grunt> C = JOIN A by edpno,B by edpno;
grunt> dump C;
/* (7934,MILLER,CLERK,1300,,10,10,ACCOUNTING,NEW YORK)
(7782,CLARK,MANAGER,2450,,10,10,ACCOUNTING,NEW YORK)
(7839,KING,PRESIDENT,5000,,10,10,ACCOUNTING,NEW YORK)
(7876,ADAMS,CLERK,1100,,20,20,RESEARCH,DALLAS)
(7566,JONES,MANAGER,2975,,20,20,RESEARCH,DALLAS)
(7369,SMITH,CLERK,800,,20,20,RESEARCH,DALLAS)
(7788,SCOTT,ANALYST,3000,,20,20,RESEARCH,DALLAS)
(7902,FORD,ANALYST,3000,,20,20,RESEARCH,DALLAS)
(7521,WARD,SALESMAN,1250,500,30,30,SALES,CHICAGO)
(7654,MARTIN,SALESMAN,1250,1400,30,30,SALES,CHICAGO)
(7698,BLAKE,MANAGER,2850,,30,30,SALES,CHICAGO)
(7900,JAMES,CLERK,950,,30,30,SALES,CHICAGO)
(7844,TURNER,SALESMAN,1500,0,30,30,SALES,CHICAGO)
(7499,ALLEN,SALESMAN,1600,300,30,30,SALES,CHICAGO) */

grunt> d = foreach C generate A::eid,B::epos;
grunt> dump d;
/* (7934,ACCOUNTING)
(7782,ACCOUNTING)
(7839,ACCOUNTING)
(7876,RESEARCH)
(7566,RESEARCH)
(7369,RESEARCH)
(7788,RESEARCH)
(7902,RESEARCH)
(7521,SALES)
(7654,SALES)
(7698,SALES)
(7900,SALES)
(7844,SALES)
(7499,SALES) */

grunt> e= JOIN A by edpno RIGHT OUTER, B by edpno;        -- Returns all the rows from right table even if there is no matched rows in the left table.
grunt> dump e;
/* (7934,MILLER,CLERK,1300,,10,10,ACCOUNTING,NEW YORK)
(7782,CLARK,MANAGER,2450,,10,10,ACCOUNTING,NEW YORK)
(7839,KING,PRESIDENT,5000,,10,10,ACCOUNTING,NEW YORK)
(7876,ADAMS,CLERK,1100,,20,20,RESEARCH,DALLAS)
(7566,JONES,MANAGER,2975,,20,20,RESEARCH,DALLAS)
(7369,SMITH,CLERK,800,,20,20,RESEARCH,DALLAS)
(7788,SCOTT,ANALYST,3000,,20,20,RESEARCH,DALLAS)
(7902,FORD,ANALYST,3000,,20,20,RESEARCH,DALLAS)
(7521,WARD,SALESMAN,1250,500,30,30,SALES,CHICAGO)
(7654,MARTIN,SALESMAN,1250,1400,30,30,SALES,CHICAGO)
(7698,BLAKE,MANAGER,2850,,30,30,SALES,CHICAGO)
(7900,JAMES,CLERK,950,,30,30,SALES,CHICAGO)
(7844,TURNER,SALESMAN,1500,0,30,30,SALES,CHICAGO)
(7499,ALLEN,SALESMAN,1600,300,30,30,SALES,CHICAGO)
(,,,,,,40,OPERATIONS,BOSTON)
(,,,,,,,epos,ecity) */

**WORD COUNT**

grunt> A = load '/user/cloudera/SHARWIN/text.txt' as (line:chararray);
grunt> dump A;
/* (Hi hello how are you. Hadoop Lab prep.)
(Hello hello hello everybody. Hadoop File System.)
(Suiiiii.) */

grunt> token= foreach A generate TOKENIZE(line);
grunt> dump token
/* ({(Hi),(hello),(how),(are),(you.),(Hadoop),(Lab),(prep.)})
({(Hello),(hello),(hello),(everybody.),(Hadoop),(File),(System.)})
({(Suiiiii.)}) */

grunt> flat= foreach token generate FLATTEN($0);
grunt> dump flat
/* Hi)
(hello)
(how)
(are)
(you.)
(Hadoop)
(Lab)
(prep.)
(Hello)
(hello)
(hello)
(everybody.)
(Hadoop)
(File)
(System.)
(Suiiiii.) */

grunt> wrd_group= group flat by $0;
grunt> dump wrd_group;
/* (Hi,{(Hi)})
(Lab,{(Lab)})
(are,{(are)})
(how,{(how)})
(File,{(File)})
(you.,{(you.)})
(Hello,{(Hello)})
(hello,{(hello),(hello),(hello)})
(prep.,{(prep.)})
(Hadoop,{(Hadoop),(Hadoop)})
(System.,{(System.)})
(Suiiiii.,{(Suiiiii.)})
(everybody.,{(everybody.)}) */

grunt> countwrd = foreach wrd_group generate group as word, COUNT($1) as wordcount;
grunt> dump countwrd;
/* (Hi,1)
(Lab,1)
(are,1)
(how,1)
(File,1)
(you.,1)
(Hello,1)
(hello,3)
(prep.,1)
(Hadoop,2)
(System.,1)
(Suiiiii.,1)
(everybody.,1) */













