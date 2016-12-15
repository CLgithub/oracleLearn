--多表查询
  --1.等值连接
    --查询员工信息：员工号 姓名 月薪 部门名称
    select e.empno,e.ename,e.sal,d.dname
    from emp e,dept d
    where e.deptno=d.deptno;

  --2.不等值连接
    --查询员工信息：员工号 姓名 月薪 工资级别
    select e.empno,e.ename,e.sal,s.grade
    from emp e,salgrade s
    where e.sal between s.losal and s.hisal

  --3.外连接：对于某些不成立的记录，通过外连接依然可以包含在最后的结果集中
    --按部门统计员工人数：部门好 部门名称 人数
    select d.deptno,d.dname,count(1)
    from emp e,dept d
    where e.deptno=d.deptno
    group by d.deptno,d.dname
      --但是上面的不对，因为部门没有完全显示   
      --所有要使用外连接，
      --左外连接：左边为主，右边加
      --写法：where e.depton=d.depton(+)
      --右外连接：右边为主，左边加
      --写法：where e.depton(+)=d.depton
      select d.deptno,d.dname,count(e.empno)
      from emp e,dept d
      where e.deptno(+)=d.deptno
      group by d.deptno,d.dname

  --4.自连接:通过表的别名，将同一张表视为多张表
    --查询员工信息：员工的名字 老板的名字
    select e.ename,b.ename 
    from emp e,emp b
    where e.mgr=b.empno
  --思考：其实可以加上左外连接，查询出谁没有老板，右外连接，查询出谁没有员工
  --自连接，不适合操作大表，所产生的结果至少是原表的2次方条
    
    --如果有一张大表，要查询老板和员工
      --5.层次查询（其实是单表查询）
        --层次查询只有一张表，只有在一张表的时候才不会产生笛卡尔积
        select e.*,level
        from emp e
        connect by prior e.empno=e.mgr
        start with e.mgr is null
        order by level;
        select e.* from emp e
        -- connect by 表示以树的形式遍历，
        --prior（先） 
        --e.empno=e.mgr 当前层的员工号等于下一层的老板号
        --start with e.mgr is null; 从没有老板的那个节点开始查
        -- level表示第几层
        --只要满足一棵树，都可以用层次查询