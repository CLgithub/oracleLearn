----------------------------------------------基本查询
--当前用户
show user;
--当前用户下的表
select * from tab;

--select nvl2('12','a','b') from dual; 如果第一个参数不为null，就显示a，否则就显示b

select concat('aa','bb') 字符串
from dual;