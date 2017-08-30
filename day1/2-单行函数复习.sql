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
------日期函数
------months_between(a,b) a日期与b日期相差多少个月
--------使用日期函数months_between精确计算月份  天可以用- 年可以用月*12 所有需要一个计算月的方法
select e.ename,e.hiredate,sysdate-e.hiredate 天,
months_between(sysdate,e.hiredate) 月,months_between(sysdate,e.hiredate)/12 年
from emp e;
--------生命
select (sysdate-to_date('19900222','yyyymmdd')) 天,months_between(sysdate,to_date('19900222','yyyymmdd'))月,
months_between(sysdate,to_date('19900222','yyyymmdd'))/12 年
from dual;
------add_months(a,b) 在a日期上加上b个数月后的日期
--------今天一个月以后的日期
select add_months(sysdate,1) from dual;
select add_months(sysdate,-3) from dual;
------last_day(a)  a日期所在月份的最后一天的日期
select last_day(sysdate) from dual;
------next_day(a,星期b)  从a日期开始，算出下一个'星期b'的日期
select next_day(sysdate,'星期日') from dual;
--------应用，每周一自动备份数据
------round(a,b) 日期四舍五入,a日期四舍五入为b,b 'day' 'month' 'year'
select round(sysdate,'day') from dual;
select round(sysdate,'month') from dual;    --过来当月一半，就算下一个月
select round(sysdate,'year') from dual;     --过了当年一半，就算下一年
------trunc(a,b) 日期截取，a日期截取为b，b 'day' 'month' 'year'
select trunc(sysdate,'day') from dual;
select trunc(sysdate,'month') from dual;
select trunc(sysdate,'year') from dual;
----4.转换函数

----5.通用函数

----6.条件表达式