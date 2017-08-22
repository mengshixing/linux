1    apache支持ssi(Server Side Include是一种类似于ASP的基于服务器的网页制作技术,将文本内容直接插入到文档中<#include>,可以用来插入页眉页脚的html页)

一,找到apache配置文件去掉下面2行的注释
# AddType text/html .shtml
# AddOutputFilter INCLUDES .shtml
二,找到对应的<VirtualHost *:82>添加下面三行
Options Indexes FollowSymLinks Includes
AddType text/html .shtml .html
AddOutputFilter INCLUDES .shtml .html



2  Access forbidden! 

<Directory />
    # AllowOverride none
    # Require all denied
	Allow from all 
</Directory>
