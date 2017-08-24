
1,apache支持ssi的配置:(Server Side Include是一种类似于ASP的基于服务器的网页制作技术,
将文本内容直接插入到文档中<#include>,可以用来插入页眉页脚的html页).

    一,找到apache配置文件去掉下面2行的注释
        # AddType text/html .shtml
        # AddOutputFilter INCLUDES .shtml
    二,找到对应的<VirtualHost *:82>添加下面三行
        Options Indexes FollowSymLinks Includes
        AddType text/html .shtml .html
        AddOutputFilter INCLUDES .shtml .html

2,apache启动后访问网页发现提示Access forbidden! 
    
    一,找到apache配置文件下面内容,改成下面的内容即可
    <Directory />
        # AllowOverride none
        # Require all denied
        Allow from all 
    </Directory>
    二,Order Deny,Allow和Allow from All的解释:
    注意"Deny,Allow"中间只有一个逗号，也只能有一个逗号，有空格都会出错；单词的大小写不限。
    上面设定的含义是先设定“先检查禁止设定，没有禁止的全部允许”，而第二句没有Deny，
    也就是没有禁止访问的设定，直接就是允许所有访问了。可以用来限制访问的ip
    这个主要是用来确保或者覆盖上级目录的设置，开放所有内容的访问权。
    
3,apache监测启用和加载的模块:apache2ctl
	
	apache2ctl -t -D DUMP_MODULES 显示所有启用的模块	
	apache2ctl status 检测apache状态

4,apache安装完模块后要在配置文件加LoadModule +模块索引并重启