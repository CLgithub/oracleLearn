/*
单行函数：
  单行输入的函数
6种

*/
--1.字符函数
  --大小写首字母大写
  select lower('AAAaaaAaa') 小写,upper('AAAaaaAaa') 大写, initcap('AAAaaaAaa') 首字母大写 from dual;
  --substr(a,b) 从a中，第b为开始取
  select substr('abcdefg',3) from dual;
  --substr(a,b,c) 从a中，第b为开始取 ,取c位 
  select substr('abcdefg',3,2) from dual;
  --length 字符数 lengthb字节数
  select length('abcde') 字符,lengthb('abcde') 字节 from dual;
  select length('北京') 字符,lengthb('北京') 字节 from dual;
  --instr(a,b) 在a中查找b，如果找到就返回b的位置(从1开始数)，如果没找到，返回0
  select instr('abcdef','c') from dual;
  --lpad 左填充 rpad右填充
  select lpad('aaa',10,'*'),rpad('aaa',10,'*') from dual;
  --trim 去掉前后指定的字符
  select trim('*' from 'aaa*bbbcc*c*') from dual; 
  --replace 替换
  select replace('aaa*bbbcc*c*','*','-') from dual;
--2.数值函数
  select round(45.926, 2),round(45.926, 1),round(45.926, 0), 
     round(45.926, -1) from dual;      --小数点后几位开始四舍五入
  select trunc(45.926, 2),trunc(45.926, 1),trunc(45.926, 0), 
     trunc(45.926, -1)  from dual;      --截断
  --round和trunc还可以用来操作日期   
  select mod(1600, 300) from dual;        --求余
--3.日期
/*
mysql:
  date         yyyyMMdd
  datetime     yyyyMMdd hh:mm:ss
  
oracle:
  date=日期+时间   sql plus中默认格式 DD-MON-RR  
*/
  --当前时间
  select sysdate from dual;
  --sql plus 
  select to_char(sysdate,'yyyy-MM-dd hh24:mm:ss') from dual;
  
 --在日期上加上或减去一个数字结果仍为日期
     --昨天，今天，明天
     select sysdate-1 昨天,sysdate 今天,sysdate+1 明天 from dual;
     select to_char(sysdate-1,'yyyy-MM-dd') 昨天,to_char(sysdate,'yyyy-MM-dd') 今天,
         to_char(sysdate+1,'yyyy-MM-dd') 明天 from dual;
 --日期相减
     --技术员工的工龄：天 星期 月 年
     select e.ename,e.hiredate,(sysdate-e.hiredate) 天, (sysdate-e.hiredate)/7 星期,
         (sysdate-e.hiredate)/30 月,(sysdate-e.hiredate)/365 年 from emp e;
    