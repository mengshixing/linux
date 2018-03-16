

### 安装nginx(参考http://www.runoob.com/linux/nginx-install-setup.html) ###

系统平台：CentOS 6.5 64位。可以切换到目录/tmp下开始

#### 一、安装编译工具及库文件 ####

yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel

#### 二、首先要安装 PCRE ####

PCRE 作用是让 Nginx 支持 Rewrite 功能。

1、下载 PCRE 安装包

[root@bogon tmp]# wget http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz

2、解压安装包:

[root@bogon tmp]# tar zxvf pcre-8.35.tar.gz

3、进入安装包目录

[root@bogon tmp]# cd pcre-8.35

4、编译安装 

[root@bogon pcre-8.35]# ./configure
[root@bogon pcre-8.35]# make && make install

5、查看pcre版本

[root@bogon pcre-8.35]# pcre-config --version

### 三 .安装 Nginx ####

1、下载 Nginx，下载地址：http://nginx.org/download/nginx-1.6.2.tar.gz

[root@bogon tmp]# wget http://nginx.org/download/nginx-1.6.2.tar.gz

2、解压安装包

[root@bogon tmp]# tar zxvf nginx-1.6.2.tar.gz

3、进入安装包目录

[root@bogon tmp]# cd nginx-1.6.2

4、编译安装(--with-pcre=/tmp/pcre-8.35这个地址是之前安装pcre-8.35的地址)

[root@bogon nginx-1.6.2]# ./configure --prefix=/usr/local/webserver/nginx --with-http_stub_status_module 
--with-http_ssl_module --with-pcre=/tmp/pcre-8.35
[root@bogon nginx-1.6.2]# make
[root@bogon nginx-1.6.2]# make install

5、查看nginx版本

[root@bogon nginx-1.6.2]# /usr/local/webserver/nginx/sbin/nginx -v
到此，nginx安装完成。

### 四. Nginx 配置 ####
创建 Nginx 运行使用的用户 www：

[root@bogon conf]# /usr/sbin/groupadd www 
[root@bogon conf]# /usr/sbin/useradd -g www www

配置nginx.conf ，可以通过编辑/usr/local/webserver/nginx/conf/nginx.conf文件

检查配置文件ngnix.conf的正确性命令：

[root@bogon conf]# /usr/local/webserver/nginx/sbin/nginx -t

启动 Nginx.Nginx 启动命令如下：

[root@bogon conf]# /usr/local/webserver/nginx/sbin/nginx
