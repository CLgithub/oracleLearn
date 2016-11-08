--条件查询
/*
在where里可以写数字，字符串和日期
  字符和日期要包含在单引号中
  字符大小写敏感，日期格式敏感
  默认的日期格式是 DD-MON-RR

*/
Select * from Catalog c
Where c.creator='XDB'
--更改默认日期格式
Select * from V$nls_Parameters;
--V$nls_Parameters是一个数据字典，存放了一些参数
-- Alter system|session
Alter Session set NLS_DATE_FORMAT='DD-MON-RR'

/*
比较运算
  =  等于    赋值使用:=符号
  > 大于 
  >= 大于、等于
  <  小于
  <  小于、等于
  <> 不等于
其他比较运算
  between...and...在两个值之间（包含边界）
    1.含有边界
    2.小值在前，大值在后，不能交换
  in(set)  等于值列表中的一个
  like     模糊查询
  is null  空值
*/
Select * from Catalog c
where c.creator not in('OUTLN','DBSNMP',null)
--查询有下划线的记录,需要用到转意字符,用转意字符需要声明
select * from Catalog c
       where c.tname like '%\_%' escape '\'

/*
where条件优先级
1.算数运算符
2.连接符
3.比较符
4.IS [NOT] NULL,LIKE,[NOT] IN
5.[NOT] BETWEEN
6.NOT
7.AND
8.OR
*/

-------------------------------------------------
--order by 后面可以跟 列   表达式   别名    列的序号（第几列，不能超）

--按照年薪降序排列
select e.Ename,e.sal,e.Sal*12 年薪
from emp e
order by 年薪 desc;
--
select e.Ename,e.sal,e.Sal*12 年薪
from emp e
order by 3 desc;

--order by 后也可以有多个列  
select * 
from emp e
order by e.Deptno desc,e.Sal asc        --先安装部门降序，如果部门相同再按照薪水升序

--查询员工信息，按照奖金降序排序
select e.Empno,e.Ename,e.Sal 月薪,e.comm 奖金,e.Sal*12+nvl(e.comm,0) 年薪
from emp e
order by e.Comm desc
--null的排序， 
select e.Empno,e.Ename,e.Sal 月薪,e.comm 奖金,e.Sal*12+nvl(e.comm,0) 年薪
from emp e
order by e.Comm desc
nulls last
--oracle中null最大