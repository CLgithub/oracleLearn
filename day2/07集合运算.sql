-- 集合运算
  -- 查询10号部门和20号部门的员工
  select * from emp where deptno in(10,20);
  select * from emp where deptno =10 or deptno=20;
  select * from emp where deptno = any(10,20);
  --使用集合运算
    select * from emp where deptno =10
    --加上
    union
    select * from emp where deptno =20;
    
    --集合运算符
      -- 并集 union 取交集公共的部分支取一份，union all 取交集公共的部分各取一次 
      -- 交集 intersect 公共部分
      -- 差集 minus A-B 只属于A但不属于B
      
      /*
      集合运算要注意：
         1.参与运算的各个集合必须列数相同，并且类型一致
         2.采用第一个集合作为最后的表头
         3.order by 永远在最后
         4.可以使用括号来改变执行顺序
      */
      
      --按照部门和职位统计工资
        --增强 group by
        select e.deptno,e.job,sum(e.sal) 
        from emp e
        group by
        rollup(e.deptno,e.job);
        --用 union来实现
        select e.deptno,e.job,sum(e.sal) from emp e group by e.deptno,e.job
        union
        select e.deptno,to_char(null),sum(e.sal) from emp e group by e.deptno
        union
        select to_number(null),to_char(null),sum(e.sal) from emp e
        
      --sql 优化原则5：尽量不要使用集合运算
        
        --交集
        --查询薪水同时位于级别1(700~1300)和级别2(1201~1400)的员工信息
        select * 
        from emp e
        where
        e.sal between 700 and 1300
        intersect
--        minus
        select * 
        from emp e
        where
        e.sal between 1201 and 1400