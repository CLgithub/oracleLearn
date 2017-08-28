----------------------------------------------单行函数  单行输入的函数
--共6种单行函数     
----1.字符函数
------大小写首字母大写
select lower('aAAbBBbCcC') 小写,upper('aAAbBBbCcC') 大写,initcap('aAAbBBbCcC') 首字母大写 from dual;
------substr(a,b) 从a中，第b位开始取
select substr('abcdefg',3) from dual;
------length 字符数 lengthb字节数
select length('abc中文'),lengthb('abc中文') from dual;
------instr(a,b) 在a中查找b，如果找到就返回b的位置(从1开始数)，如果没找到，返回0
select instr('abcdabcdabcd','b') from dual;
------lpad 左填充 rpad右填充
select lpad('aa',3,'*') from dual;
select rpad('aa',3,'*') from dual;
------trim 去掉前后指定的字符
select trim('*' from 'abc*def*ghi**') from dual;
------replace 替换
select replace('aabbcc','a','*') from dual;

----2.数值函数  其实也是日期函数，可以用在日期上
------ round 小数点后几位开始四舍五入
select round(45.926, 2),round(45.926, 1),round(45.926, 0),round(45.926, -1) from dual;
------ trunc 截断
select trunc(45.926, 2),trunc(45.926, 1),trunc(45.926, 0),trunc(45.926, -1) from dual;
------ mod 求余
select mod(1600,300) from dual;

----3.日期
------当前时间
select sysdate from dual;
select to_char(sysdate,'yyyy-MM-dd hh24:mi:ss') from dual;
------在日期上加上或减去一个数字结果仍为日期
-------- 昨天，今天，明天
select sysdate-1 昨天,sysdate 今天, sysdate+1 明天 from dual;
-------- 技术员工的工龄：天 星期 月 年   此时只能算出近似值，通过日期函数能算准
select e.ename,e.hiredate,trunc((sysdate-e.hiredate),0) 天,
trunc((sysdate-e.hiredate)/7,0) 周,(sysdate-e.hiredate)/30 月,(sysdate-e.hiredate)/365
 from emp e

----4.转换函数

----5.通用函数

----6.条件表达式


