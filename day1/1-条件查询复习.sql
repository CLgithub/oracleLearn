--条件查询，
/*
between value1 and value2 再两者之间，包含边界
*/
select * from salgrade t
where t.hisal>=1300 and t.hisal<=2000;
--
select * from salgrade t
where t.hisal between 1300 and 2000
-------------------------------------------优先级
select 3+5||3 from dual    --先运算，后连接
---------------------------------------------------
/**************************************
order by 后可以跟 列    表达式     别名  列的序号（第几列 不能超）
**************************************/
--按照年薪降序排列
select e.Ename,e.sal,e.Sal*12 年薪
from emp e
order by 年薪 desc;  --跟列

select e.Ename,e.sal,e.Sal*12 年薪 from emp e
order by 3 desc    --跟第几列

select e.Empno,e.Ename,e.Sal 月薪,e.comm 奖金,e.Sal*12+nvl(e.comm,0) 年薪   --null值+如何值都为null
from emp e
order by 

--null空值排列
--查询员工信息，按照奖金降序排序            
select e.Empno,e.Ename,e.Sal 月薪,e.comm 奖金,e.Sal*12+nvl(e.comm,0) 年薪
from emp e
order by e.Comm desc
nulls last   -- nulls 放最后
--查询员工信息，按照奖金升序排序
select e.Empno,e.Ename,e.Sal 月薪,e.comm 奖金,e.Sal*12+nvl(e.comm,0) 年薪
from emp e
order by e.Comm asc
nulls first   -- nulls 放最前
--查询员工信息，按照奖金升序排序
select e.Empno,e.Ename,e.Sal 月薪,nvl(e.comm,0) 奖金,e.Sal*12+nvl(e.comm,0) 年薪
from emp e
order by 4 asc
---------------------------------------------------
