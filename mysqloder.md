1 替换表中某个字段的值

- update 表名 set 字段=replace(字段，‘替换的部分’，‘替换后的字符串’)；
- update 表名 set A=replace( A, '海淀', '朝阳') where A like '海淀';  （将A字段中的“海淀”替换成“朝阳”）；

2 一对多关联数据库查询的问题，查询关联表a,b。b表按照ID进行分组
SELECT hj_activity.*, temp.activity_id,temp.order_money,temp.parent_money,temp.platform_money from hj_activity LEFT JOIN 
(SELECT activity_id,sum(hj_order.order_money) as order_money,sum(hj_order.parent_money) as parent_money,sum(hj_order.platform_money) 
as platform_money FROM hj_order WHERE hj_order.order_status>2 GROUP BY activity_id) temp on hj_activity.id=temp.activity_id 
WHERE hj_activity.`status`=1;
