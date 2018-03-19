
#### 一.nginx查看安装模块 ####

/usr/local/webserver/nginx/sbin/nginx -V  
(大写V,小写是查看版本号)

nginx version: nginx/1.6.2
built by gcc 4.4.7 20120313 (Red Hat 4.4.7-18) (GCC) 
TLS SNI support enabled
configure arguments: --prefix=/usr/local/webserver/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/tmp/pcre-8.35

#### 二.nginx添加(http_flv_module: 支持flv)(http_mp4_module: 支持mp4)内置模块 ####

切换到nginx目录,cd /tmp/nginx-1.6.2 执行
./configure --prefix=/usr/local/webserver/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/tmp/pcre-8.35 --with-http_mp4_module --with-http_flv_module

make 
make install
完成模块添加

#### 安装nginx_mod_h264_streaming: 使nginx支持h264编码的视频 ####

Download the source of the H264 Streaming Module for Nginx.

wget http://h264.code-shop.com/download/nginx_mod_h264_streaming-2.2.7.tar.gz
tar -zxvf nginx_mod_h264_streaming-2.2.7.tar.gz

切换到nginx目录
./configure --prefix=/usr/local/webserver/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/tmp/pcre-8.35 --with-http_mp4_module --with-http_flv_module --add-module=/tmp/nginx_mod_h264_streaming-2.2.7


make


报错 
/tmp/nginx_mod_h264_streaming-2.2.7/src/ngx_http_streaming_module.c:158: error: ‘ngx_http_request_t’ has no member named ‘zero_in_uri’
make[1]: *** [objs/addon/src/ngx_http_h264_streaming_module.o] Error 1

解决错误：

因为在新版本的nginx中废弃了zero_in_uri这个flag，稍微修改一下nginx_mod_h264_streaming的源代码

vim /usr/local/src/nginx_mod_h264_streaming-2.2.7/src/ngx_http_streaming_module.c 

把158到161行注释掉

157   /* todo: win32 */
158   //if (r->zero_in_uri)
159   //{
160   //  return ngx_declined;
161   //}

 

然后再make就正常了，make install 完成安装 配置nginx使之支持mp4 在nginx配置文件中加入

location ~ \.mp4$ {
                mp4;
        } 

重启nginx
/etc/init.d/nginx restart


配置
Edit the configuration file (in /usr/local/nginx/conf/nginx.conf) so that file requests ending 
in ".mp4" are handled by the 'mp4' command. Add the following lines (around line 43).

location ~ \.mp4$ {
  mp4;
}

Start Nginx.
sudo /usr/local/sbin/nginx


#### 四，查看视频信息 ####
ffmpeg -i /tmp/test.flv 
ffmpeg version 3.1 Copyright (c) 2000-2016 the FFmpeg developers
  built with gcc 4.4.7 (GCC) 20120313 (Red Hat 4.4.7-18)
  configuration: --enable-libass
  libavutil      55. 27.100 / 55. 27.100
  libavcodec     57. 48.101 / 57. 48.101
  libavformat    57. 40.101 / 57. 40.101
  libavdevice    57.  0.101 / 57.  0.101
  libavfilter     6. 46.102 /  6. 46.102
  libswscale      4.  1.100 /  4.  1.100
  libswresample   2.  1.100 /  2.  1.100
[flv @ 0x2bc7240] video stream discovered after head already parsed
[flv @ 0x2bc7240] audio stream discovered after head already parsed
Input #0, flv, from '/tmp/test.flv':
  Metadata:
    server          : SMS Server
    creationdate    : Wed Nov 29 14:27:23 CST 2017
    canSeekToEnd    : true
    length          : 14
  Duration: 00:25:50.23, start: 0.000000, bitrate: 3523 kb/s
    Stream #0:0: Video: h264 (Baseline), yuv420p, 1280x720, 30.30 fps, 29.92 tbr, 1k tbn, 60 tbc
    Stream #0:1: Audio: aac (LC), 48000 Hz, mono, fltp
At least one output file must be specified


"canSeekToEnd"为true 表示可以拖动，之前已经安装过ffmpeg，在ffmpeg.md文件夹中可以参考

#### 五，配置nginx配置文件 ####

第一个错误,
nginx报错zero size shared memory zone "one"  
注释掉这行不支持该模块#   limit_conn one 20;#限制客户端并发连接数

第二个错误,端口占用
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] still could not bind()

查看端口占用
列出所有端口
netstat -ntlp 关掉占用

重启
/usr/local/webserver/nginx/sbin/nginx -s reload 

第三个错误
视频加载不出来。niginx net::ERR_CONNECTION_REFUSED
在服务器上的index.html 文件中视频url设置的是localhost
修改为具体是服务器ip即可（url: 'http://192.168.0.115/test.flv'）

