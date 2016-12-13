--多行函数
--作用于一组数据，返回一个结果
/*
常用的多行函数
  avg
  count
  max
  min
  sum
*/

  --求工资的总额
  select sum(e.sal) from emp e;
  --求员工的人数
  select count(1) from emp;
  --评价工资
  select sum(e.sal)/count(1),avg(e.sal) from emp e;
  --平均奖金
  select sum(e.comm)/count(1),sum(e.comm)/count(e.comm),avg(e.comm) from emp e;
  select count(1),count(comm),count(nvl(comm,0)) from emp;

--分组数据
  --求员工表中各部门的评价工资
  select e.deptno,avg(e.sal) from emp e group by e.deptno;
  --抽象
  -- select a,b,分组函数(x) from table group by a,b,c,d;
  --在select列表中所有未包含在组函数中的列都应该包含在group by子句中,包含在group by语句后的不一定要在列中
  select count(ename) from emp;
  
  --多个列的分组
    select 
    e.deptno,
    e.job,
    sum(sal),
    sum()
    from 
    emp e
    group by e.deptno,e.job;
      --做个转置
        select 
        e.deptno,
        sum(case when e.job='CLERK' then e.sal end) clerk,
        sum(case when e.job='SALESMAN' then e.sal end) SALESMAN,
        sum(case when e.job='MANAGER' then e.sal end) MANAGER,
        sum(case when e.job='PRESIDENT' then e.sal end) PRESIDENT,
        sum(case when e.job='ANALYST' then e.sal end) ANALYST,
        sum(e.sal) "总计"
        from 
        emp e
        group by e.deptno;
        --
          select 
          e.job,
          sum(case when e.deptno=10 then e.sal end) "10",
          sum(case when e.deptno=20 then e.sal end) "20",
          sum(case when e.deptno=30 then e.sal end) "30",
          sum(e.sal) "总计"
          from 
          emp e
          group by e.job;
  --多个列分组，先按照第一个列分组，如果相同，在按照第二个列分组，以此类推
  
  --部门平均工资，大于2000的部门，分组后再加条件，用having，
    select 
    e.deptno,
    avg(e.sal)  
    from emp e group by e.deptno
    having  avg(e.sal)>2000
      --case来判断，不是很好做
        select 
        e.deptno,
        (case when avg(e.sal)>2000 then avg(e.sal) end)
        from emp e group by e.deptno
    --where和having最大的区别：where后面不能使用组函数，where不能放在group by后面
    --查询10号部门的平均工资
    select e.deptno,avg(e.sal) from emp e where e.deptno=10 group by e.deptno;
    select e.deptno,avg(e.sal) from emp e group by e.deptno having e.deptno=10;
    --sql优化3：having和where都能用时，尽量使用where，因为where是先过滤，再分组，而having是先分组，后过滤
    
    --group 增强
    select e.deptno,e.job,sum(e.sal) 
    from emp e
    group by
    rollup(e.deptno,e.job)
        --做个转置
          select 
          e.deptno,
          sum(case when e.job='CLERK' then e.sal end) clerk,
          sum(case when e.job='SALESMAN' then e.sal end) SALESMAN,
          sum(case when e.job='MANAGER' then e.sal end) MANAGER,
          sum(case when e.job='PRESIDENT' then e.sal end) PRESIDENT,
          sum(case when e.job='ANALYST' then e.sal end) ANALYST,
          sum(e.sal) "总计"
          from 
          emp e
          group by rollup(e.deptno);
        --          
          select 
          nvl(e.job,'总计'),
          sum(case when e.deptno=10 then e.sal end) "10",
          sum(case when e.deptno=20 then e.sal end) "20",
          sum(case when e.deptno=30 then e.sal end) "30",
          sum(e.sal) "总计"
          from 
          emp e
          group by rollup(e.job);
    /*
    group by roll(a,b)
    =
    group by a,b
    +
    group by a
    +
    group by null
    */
    
  

