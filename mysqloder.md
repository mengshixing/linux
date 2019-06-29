1 替换表中某个字段的值

update 表名 set 字段=replace(字段，‘替换的部分’，‘替换后的字符串’)；
update 表名 set A=replace( A, '海淀', '朝阳') where A like '海淀';  （将A字段中的“海淀”替换成“朝阳”）；
