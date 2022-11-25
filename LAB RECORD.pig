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
/*(,ename,epos,,,)
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

