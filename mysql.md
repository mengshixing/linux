1,mysql查看日志状态:

    mysql>show variables like 'log_%';  输出
    
    +---------------------------------+--------------------------+
    | Variable_name                   | Value                    |
    +---------------------------------+--------------------------+
    | log_bin                         | ON                       |
    | log_bin_trust_function_creators | OFF                      |
    | log_error                       | /var/log/mysql/error.log | 错误日志(默认启用)
    | log_output                      | FILE                     | 日志的输出格式,文件
    | log_queries_not_using_indexes   | OFF                      |
    | log_slave_updates               | OFF                      |
    | log_slow_queries                | OFF                      |
    | log_warnings                    | 1                        | 启用警告信息log_warnings(默认启用)
    
    其中log_bin为最重要的二进制日志
    二进制日志用于记录所有更改数据的语句，主要用于复制和即时点恢复。
    二进制日志的主要目的是在数据库存在故障时，恢复时能够最大可能地更新数据库(即时点恢复),
    因为二进制日志包含备份后进行的所有更新,二进制日志还用于在主复制服务器上记录所有将发送给从服务器的语句。
    查看二进制日志的工具为：mysqlbinlog
    
    show variables like '%binlog%';  以下为binary log相关参数  
    show variables like '%datadir%';  当前mysql服务器数据文件的缺省位置:  
    | datadir       | /var/lib/mysql/ |
    
2,启动二进制日志,
    
    要找到mysql配置文件my.cnf,来配置    
    Linux的配置文件为my.cnf,一般在/etc下.如果不在的话,查找一下 sudo find / -name my.cnf
    
    打开之后添加log-bin=/var/lib/mysql/mysql-bin或者去掉这行的注释(参见上文的缺省位置);
    或者添加log-bin=mysql-bin.
    注意！此行语句需要放在[mysqld]索引下
    重启服务 service mysqld restart 
    
    如果是window环境的话,打开my.ini文件,去掉log-bin=mysql-bin行注释 ,server-id  = 1默认master服务器,否则添加 
    
3,显示二进制日志数目

    mysql> show master logs; 
    
    +------------------+-----------+
    | Log_name         | File_size |
    +------------------+-----------+
    | mysql-bin.000001 |    397951 |
    | mysql-bin.000002 |    695493 |
    | mysql-bin.000003 |    542381 |
    | mysql-bin.000004 |    793486 |
    | mysql-bin.000005 |    525069 |
    +------------------+-----------+ 
    打印当前有5个日志文件
    
4,显示当前的日志 
    flush logs; 会多一个最新的bin-log日志
    reset master; 清空所有的bin-log日志

    mysql> show master status; 
    +------------------+----------+--------------+------------------+
    | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
    +------------------+----------+--------------+------------------+
    | mysql-bin.000005 |   525069 |              |                  |
    +------------------+----------+--------------+------------------+
    
5,打开日志文件查看
    
    切换到日志所在目录
    mysqlbinlog --no-defaults mysql-bin.000002即可打开
    也可以直接 mysqlbinlog filename 打开
    
6,数据恢复http://www.cnblogs.com/it-cen/p/5234345.html
    
    1)最长用的就是恢复指定数据端的数据了，可以直接恢复到数据库中：
        mysqlbinlog --start-date="2014-02-18 16:30:00" 
        --stop-date="2014-02-18 17:00:00" mysql_bin.000001 |mysql -uroot -p123456
        亦可导出为sql文件，再导入至数据库中：
        mysqlbinlog --start-date="2014-02-18 16:30:00" 
        --stop-date="2014-02-18 17:00:00" mysql_bin.000001 >d:\1.sql

    2).指定开始\结束位置，从上面的查看产生的binary log我们可以知道某个log的开始到结束的位置，
        我们可以在恢复的过程中指定回复从A位置到B位置的log.需要用下面两个参数来指定：
        --start-positon="50" //指定从50位置开始
        --stop-postion="100"//指定到100位置结束 
        
        示例:
        mysqlbinlog mysql-bin.000001 --start-position=106 --stop-position=209 | mysql -uroot -p123456
		mysqlbinlog mysql-bin.000032 --database=lms --start-position=619405 --stop-position=619505
    
7,清空现有的所用bin-log: reset master;
    	启用新的日志文件，一般备份完数据库后执行,show master status;
    
8,日志文件转换为sql:
    	//mysqlbinlog  /usr/local/mysql/var/mysql-bin.000012 --database=money_a --start-datetime='2016-07-20 00:00:01' 
    	//--stop-datetime='2016-07-24 23:59:59'   > 26-day.sql
    
   	 mysqlbinlog mysql-bin.000033 --database=lms >/home/lms/s33.sql
	
	
10 mysql初次安装之后登陆会提示Access denied for user 'root'@'localhost' (using password: NO)   
   	 配置root密码安全模式启动mysql：  
	 mysqld_safe --user=mysql --skip-grant-tables --skip-networking &    
	 然后use mysql;  
	 UPDATE user SET PASSWORD=PASSWORD('123456') where USER='root';重启即可
	 
11 mysql 5.7版本group分组查询error,需要关闭only_full_group_by模式
         Expression #1 of SELECT list is not in GROUP BY ...with sql_mode=only_full_group_by
         解决方法:
         选择文件/etc/mysql/conf.d/mysql.cnf
         末尾添加以下代码,重启mysql即可
         [mysqld]          sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
	 
12 windows端mysql报错(Fatal error: Can't open and lock privilege tables: Table 'mysql.user' doesn't exist)
          切换到mysql/bin目录下面 mysql_install_db --datadir ../data 重新初始化一下即可.
	  另外添加一下root密码
	  update mysql.user set authentication_string=password('Woniu123@') where user='root' and Host ='localhost';
          然后flush privileges;
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
