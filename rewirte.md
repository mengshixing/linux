处理vue-router history模式时需要服务器做一些rewirte配置 
# apache
+ apache rewirte 启用 可以用于/防盗链/网址规范化/临时错误页面/重定向等
## 1  
+ ubuntu 环境下 sudo a2enmod rewrite
+ windows 环境下 去除LoadModule rewrite_module modules/mod_rewrite.so  注释
## 2 
+ 配置目录内设置为
+ AllowOverride All 
## 3 
+ 在指定文件夹添加文件.htaccess
+ 例如vue build的路径为/admin/,那么在网站的/admin下创建文件,内容如下
+ <IfModule mod_rewrite.c>
+   RewriteEngine On
+   RewriteBase /
+   RewriteRule ^index\.html$ - [L]
+   RewriteCond %{REQUEST_FILENAME} !-f
+   RewriteCond %{REQUEST_FILENAME} !-d
+   RewriteRule . /admin/index.html [L]
+ </IfModule>
## 4 
+ rewrite 语法解析
+ RewriteEngine 用于开启或停用rewrite功能。
+ RewriteBase url-path #设定基准目录，例如希望对根目录下的文件rewrtie，就是”/”
+ RewriteRule [L]立即停止重写操作，并不再应用其他重写规则
+ RewriteCond %{REQUEST_FILENAME} !-f
+ RewriteCond %{REQUEST_FILENAME} !-d
+ RewriteCond 匹配,-f文件-d目录,!表示这个文件/目录不存在,就会执行下面的RewriteRule
+ 参考http://www.cnphp.info/htaccess-rewrite.html
+ https://blog.csdn.net/cmzhuang/article/details/53537591

# nginx
## location
	location /admin {	  
		index  index.html index.htm;
		#error_page 404 /admin/index.html;
		if (!-e $request_filename) {
			rewrite ^/(.*) /admin/index.html last;
			break;
		}
	}
+ 参考https://www.cnblogs.com/brianzhu/p/8624703.html
