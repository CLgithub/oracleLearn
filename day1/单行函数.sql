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
--2.数值函数  其实也是日期函数，可以用在日期上
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
     --技术员工的工龄：天 星期 月 年   此时只能算出近似值，通过日期函数能算准
     select e.ename,e.hiredate,(sysdate-e.hiredate) 天, (sysdate-e.hiredate)/7 星期,
         (sysdate-e.hiredate)/30 月,(sysdate-e.hiredate)/365 年 from emp e;
--日期函数
 --使用日期函数months_between精确计算月份
 select e.ename,e.hiredate,(sysdate-e.hiredate)/30 月,
        months_between(sysdate,e.hiredate) 月,
        months_between(sysdate,e.hiredate)/12 年 from emp e;
 --  add_months 在指定的日期上加上指定的个数月后的日期
 select add_months(sysdate, 1) from dual;   --今天1个月以后的日期
 select add_months(sysdate, -3) from dual;   --今天3个月以前的日期
 -- last_day  日期所在月份的最后一天
 select last_day(sysdate) from dual;
 -- next_day  从指定的日期开始，算出下一个星期x的日期
 select next_day(sysdate,'星期日') from dual; 
     --应用，每周一自动备份数据 day4讲
 -- round 日期四舍五入
 select round(sysdate,'day') from dual;      --截取到天
 select round(sysdate,'month') from dual;    --截取到月，天过了当月的一半，就是下一个月
 select round(sysdate,'year') from dual;     --截取到年，月过了当年的一半，就是下一年
 -- trunc 日期截断
 select trunc(sysdate,'year') from dual;

--4.转换函数
 --转换函数,在不同的数据类型间完成转换
 --隐式转换
       --前提:被转换对象是可以转换的
       select * from emp where deptno=10;  --查看10号部门的员工
       select * from emp where deptno='10';  --查看10号部门的员工   字符串'10'可以隐式转换成数字10
 --显示转换 
   --3中类型 number数字 character字符串 date日期
     /* 
          number  --to_char->   character  -to_date->  date
          number  <-to_number-  character  <-to_char-  date
     */
    --to_char 将数字或日期转换成字符串
    --to_number,to_date 将字符串转换数字或日期

    --1.to_char 日期转换为字符串
      --日期的格式
        -- YYYY 四位数字的年     2011
        -- YEAR                twenly eleven
        -- MM 两位数字的月       04
        -- MONTH (TH)可以省略   4月
        -- DY 星期              星期一
        -- DAY  星期            星期一
        -- DD 两位数字日期       02
        -- mi 两位分钟

           --例：要显示:现在是2016-12-11 15:23:19，今天是星期日
           select to_char(sysdate,'"现在是"yyyy-mm-dd hh24:mi:ss"，今天是"day') from dual;
           --将：现在是2016-12-11 15:23:19，今天是星期日 变成日期
           select to_date('现在是2016-12-11 15:23:19，今天是星期日',
                  '"现在是"yyyy-mm-dd hh24:mi:ss"，今天是"day') from dual;
      
    --2.to_char 数字转换为字符串
      --数字格式
        -- 9 一位数字
        -- 0 零
        -- $ 美元符
        -- L 本地货币符号
        -- . 小数点
        -- , 千位符
        
           --例：查询员工薪水,格式：货币符号 千位符 两位小数
           select to_char(e.sal,'L9,999.99') s from emp e order by s desc;
           --将字符串转换为数字
           select to_number(to_char(e.sal,'L9,999.99'),'L9,999.99'),e.sal from emp e

--5.通用函数
  --适用于任何数据类型，同时也适用于空值
   
   -- nvl(expr1,expr2)  当expr1不为null切不为空字符串，返回expr1,否则返回expr2
   select nvl('','b') from dual;
   -- nvl2(expr1,expr2,expr3) 当expr1不为null切不为空字符串，返回expr2,否则返回expr3
   select nvl2(null,'a',123) from dual;
   --
   select comm,sal*12+comm,sal*12+nvl2(comm,comm,0) from emp;
   -- nullif(a,b) 当a=b时，返回null否则返回a,a与b要是同数据类型
   select nullif(34,34) from dual;
   -- coalesce(expr1,expr2,...,exprn) 从左往右，找到第一个不为null的值
   select comm,sal,coalesce(comm,sal) from emp;
--oracle中，经常会遇到带2的，有2的是没有2的增强
   --nvl() nvl2()
   --varchar() varchar2()

--6.条件表达式
   --两种：
   --case表达式：sql99的语法，类似basic，比较繁琐
   /*
   写法一
   case 要判断的项
     when 可能性1 then 结果1
     when 可能性2 then 结果2
     when 可能性3 then 结果3
     ...
     else 其他结果
   end
   写法二
   case
     when sal<1000 then ***
     when sal>=4000 then ***
     else ***   
   */ 
  --decode函数：oracle自己的语法，类似java，比较简洁
  /*
  decode(col|expression,
    search1,result1,
    search2,result2,
    search3,result3,
    ...
    default
  )
  col|expression 判断的项可以是一个值，也可以是一个表达式
  */
  --涨工资，总裁涨1000，经理800，其他400
  select 
    e.ename,
    e.job,
    e.sal 前,
    case e.job 
      when 'PRESIDENT' then e.sal+1000 
      when 'MANAGER' then e.sal+800
      else e.sal+400
    end 后1, --case
    decode(e.job,
     'PRESIDENT',e.sal+1000,
     'MANAGER',e.sal+800,
     e.sal+400
    ) 后2 --decode
  from emp e;
  --根据10好部门的员工工资，显示税率
  select e.*,
  decode(trunc(e.sal/2000,0),
    0,0.00,
    1,0.09,
    2,0.20,
    3,0.30,
    4,0.40,
    5,0.42,
    6,0.44,
    0.45  
  ) tax_rate
  from emp e
  where deptno=10
  
  