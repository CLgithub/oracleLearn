--当前用户
show user;
--当前用户下的表
select * from tab;
--基本查询
  --查询所有
select * from catalog;
  --通过列明查询
select tname,creator,tabletype,remarks
from catalog;
/*
sql优化的原则
  1.使用列明代替*
  2.where解析的顺序：oracle中是先右后左
  
sql中的null值问题
  0.空值是无效的，未指定的，未知的或不可预知的值，空值不是空格或0
  1.包含ull的表达式都为null
  2.null永远!=null
  3.如果集合中含有null，使用in,可以正常查出原来数据，使用not in数据就不对
  4.null的排序，oracle中null最大，所以用nulls last
  5.组函数（多行函数）会自动滤空
    
    
*/
--nvl(a,b) 如果a的值位null时返回b，否则返回a
--select nvl2('12','a','b') from dual; 如果第一个参数不为null，就显示a，否则就显示b
select nvl(null,'b') from dual
--判断null is null,is not null
select * 
from catalog
where remarks is not null
--面试题，别名  
select 
  tname as "别名1",creator "别名2"
  ,tabletype 别名3 
from catalog;
/*别名1和2没有区别，当别名中有空格或关键字时要加双引号*/

--distinct去重复,作用后面的组合列，后面的列组合起来不重复
select distinct creator,tabletype from catalog;

/*
连接符：
  把列与列，列与字符连接在一起
  用“||”表示
  可以用来‘合成’列
    相当于mysql中的concat,相当于java中的+
*/
--concat函数
--在oracle中，写select必须要有from,from后可以跟任意表，但是表有多少记录就会打印多少条
--所有oracle提供了一张表dual(伪表)
select concat('aa','bb') 字符串
from dual;
select concat(tname,'aaa')
from catalog;
select 'a'||'b' from dual;
/*
orcle中的字符串
  字符串可以表示select列表中一个字符，数字，日期，
  日期和字符串只能在单引号中出现
  每当返回一行是，字符串都会被输出一次
*/
/*
sql和sql*plus
  sql
    一种语言
    ANSI标准
    关键字不能缩写
    使用语句控制数据库中的表的定义信息和表中的数据
  sql*plus
    一直环境
    oracle的特性之一
    关键字可以缩写
    命令不能改变数据库中的数据的值
    集中运行
  isql*plus(只在9和10中有，网页版sql*plus,http协议不安全)
      描述表结构
      编辑sql语句
      执行sql语句
      将sql保存在文件中并将sql语句执行结果保存在文件中
      在保存的文件中执行语句
      将文本文件装入sql*plus编辑窗口
      以本机为例：http//localhost:5560/isqlplus/
*/

select * from catalog;
desc catalog;
