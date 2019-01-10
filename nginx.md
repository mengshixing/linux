  安装阿里云ubuntu 16
  1 wget http://nginx.org/download/nginx-1.9.9.tar.gz  解压 tar -zxvf nginx-1.9.9.tar.gz -C /usr/local/   
  2 下载依赖包     
      apt-get update         
      apt-get install build-essential libtool libpcre3 libpcre3-dev zlib1g-dev openssl      
  3 编译nginx     
  4 启动 /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf    
