今天写shell脚本刷数据库造数据遇见了几个常规问题  

1  运行报错syntax error near unexpected token '$'\r'' 
   cat -v test.sh   如果是因为文件换行符是dos格式的"\r\n"的话,展示结尾会是^m
   ed 's/\r//' test.sh > testnew.sh  即可
   
2  插入mysql数据时候字段有关键字的情况
   此时mysql对应字段要用反引号(英文下1的左边按键),`key`, `name`这样
   但是``也是shell 脚本的关键字,需要加\转义
   示例:mysql -uroot -proot test -e "INSERT INTO sku_val(\`key\`, \`name\`, deleted) VALUES (13, '$flag元', 0);"
