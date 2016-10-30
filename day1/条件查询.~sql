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
