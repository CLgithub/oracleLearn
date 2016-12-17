--子查询

--查询工资比scott高的员工信息
--1
  select e.* 
  from emp s,emp e
  where s.ename='SCOTT'
  and e.sal>s.sal
--2
  select * from emp where sal>(
  select e.sal 
  from emp e
  where e.ename='SCOTT')

--子查询要注意的问题
--1.括号
--2.合理的书写风格
--3.可以在主查询的where select having from后面都可以放置子查询
--4.不可以在group by后面放置子查询
--5.强调from后面的子查询
--6.主查询和子查询可以不是同一张表，只要子查询返回的结果主查询可以使用即可
--7.一般不在子查询中排序，但在top-n分析问题中，必须对子查询排序
--8.一般先执行子查询，在执行主查询，但相关子查询例外
--9.单行子查询只能使用单行操作符，多行子查询只能使用多行操作符
--10.子查询中的null问题，集合当中如果含有null，不能使用not in

  --3.可以在主查询的where select having from后面都可以放置子查询
    --select后放，相当于增加一列，所有这列必须只能有一个结果，即单行子查询
      select empno,ename,sal,(select job from emp where empno=7839) j from emp; 
    --having后放
      --查询各个部门最低工资，筛选出比30号部门最低工资低的
      select deptno,min(sal) minsal from emp group by deptno
      having min(sal)>(select min(sal) from emp where deptno=30)
    --from后放（非常重要）
      --查询员工信息：员工号 姓名 月薪
      select * 
      from (select empno,ename,sal from emp)
      --查询员工信息：员工号 姓名 月薪 年薪
      select * 
      from (select empno,ename,sal,sal*12 annsal from emp)
  --6.主查询和子查询可以不是同一张表，只要子查询返回的结果主查询可以使用即可
     --查询部门名称是sales的员工信息
     select * from emp 
     where deptno in (select deptno from dept where dname='SALES');
     --或 连接查询
     select e.* 
     from emp e,dept d
     where e.deptno=d.deptno
     and d.dname='SALES';
     --sql优化　４：理论上，尽量使用多表查询
  --9.单行子查询只能使用单行操作符，多行子查询只能使用多行操作符
   --重点看多行
   --多行比较符　
     -- in 等于列表中的任何一个        = any
     -- any 和子查询返回的任意一个值比较
     -- all 和子查询返回的所有值比较
     
     --in 等于列表中的任何一个
       --查询部门名称是sales和accounting的员工
       select * from emp
       where deptno in (
         select deptno from dept where dname in('SALES','ACCOUNTING')
       );
       select * from emp
       where deptno = any (
         select deptno from dept where dname in('SALES','ACCOUNTING')
       );
       --或　多表查询
       select e.*
       from emp e,dept d 
       where e.deptno=d.deptno
       and dname in('SALES','ACCOUNTING')
     --any 和任意一个比较
       --查询工资比３０号部门任意一个员工高的员工信息
       select * from emp where sal > any(
         select sal from emp where deptno=30);
       -- 或
       select * from emp where sal >(
         select min(sal) from emp where deptno=30)
     --all　和所有比较
       --查询工资比３０号部门所有一个员工高的员工信息
       select * from emp where sal > all(
         select sal from emp where deptno=30);
       -- 或
       select * from emp where sal >(
         select max(sal) from emp where deptno=30)
         
       --查询工资比３０号部门任意一个员工低的员工信息
       select * from emp where sal< any(
         select sal from emp where deptno=30
       );
       --或
       select * from emp where sal< (
         select max(sal) from emp where deptno=30
       );
       
       --查询工资比３０号部门所有一个员工低的员工信息
       select * from emp where sal<all(
         select sal from emp where deptno=30
       );
       --或
       select * from emp where sal< (
         select min(sal) from emp where deptno=30
       );
     --多行子查询中的null问题
     　　--集合中有null的时候，可以使用in　不能使用not in
     　　-- 因为in是等于集合中的任意一个，
     　　-- 而not in是不能等于集合中的所有，就不能等于null，而所有与null 比较的结果都是false,
         -- a not in (10,20,null)     a!=10 and a!=20 and a!<>null
         -- 所以，返回０条记录
       --查询没有手下的员工
       select * from(
         select e.ename en,b.*
         from emp e,emp b
         where e.mgr(+)=b.empno
       )t1 where t1.en is null;
       --或
       select * 
       from emp e
       where e.empno not in (
         select mgr from emp where mgr is not null
       );