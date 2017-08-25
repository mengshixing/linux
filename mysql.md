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
	
	打开之后添加log-bin=/var/lib/mysql/mysql-bin或者去掉这行的注释(参见上文的缺省位置)	
	重启服务 service mysqld restart	
	
	如果是window环境的话,打开my.ini文件,去掉log-bin=mysql-bin行注释 ,server-id	= 1默认存在,否则添加	
    
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
	
6,数据恢复http://www.cnblogs.com/it-cen/p/5234345.html
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    