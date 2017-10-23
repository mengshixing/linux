1    显示当前目录文件列表及文件大小ls -lht

2    查看一个文件夹的大小:跳转到此文件夹上级目录,du -sh 加上文件夹名字     
     du -sh * 查看当前文件夹下所有目录的大小(以列表形式)      
     df -ah列出磁盘总容量,可用容量,使用   
     fdisk -l显示各个分区信息  

3    nginx常规重启命令 service nginx restart     

4    crontab -l显示定时任务,crontab -e编辑定时任务

5    常规查询,例如查询nginx配置文件find /|grep nginx.conf     

6    lsof查询应用程序占用文件列表,        
     lsof | grep delete获取一个已经被删除但仍然被应用程序占用的文件列表        
     http://blog.csdn.net/guoguo1980/article/details/2324454     

7   crontab 设置按秒来执行脚本可以使用sleep指令  
    */1 * * * * sleep 5;        
    */1 * * * * sleep 10;     
    */1 * * * * sleep 15;      

8   xargs用来支持|管道来传递参数    
    find / -name 'super*.md' |xargs rm -rf查询出super*.md的文件并删除
    
9   cd 提示权限不够,加上sudo之后提示命令不存在   
    因为/root及其下面的文件权限通常为rwx --- --- 所以其他用户是没办法cd进入里面的目录的。       
    在sudo 后面接上 系统内置的命令 比如cd  他就会提示没这个命令。       
    你可以 sudo  su 或者 sudo -i 切换成root用户之后再进行操作
    
10  清空文件内容指令 > filename

11  常规安装包流程:一般下载源码包得到文件：xxxx.tgz 
        1、解包软件 tar zxf xxxx.tgz    
        2、配置 cd xxxx    
                ./configure ....    
        3、编译 make     
        4、安装 make install       
        5、卸载 make uninstall
        
12  tar -zxvf /opt/soft/test/log.tar.gz解压   
    创建tar.xz文件：只要先 tar cvf xxx.tar xxx/ 这样创建xxx.tar文件先，然后使用 xz -z xxx.tar 来将 xxx.tar压缩成为 xxx.tar.xz     
    解压tar.xz文件：先 xz -d xxx.tar.xz 将 xxx.tar.xz解压成 xxx.tar 然后，再用 tar xvf xxx.tar来解包。
    
13  hg错误(mercurial一种分布式仓管,类似git) 无法识别python    
    hg -v   
    /usr/bin/hg: line 11: try:: command not found     
    解决办法 vi /usr/bin/hg  第一行#!/usr/bin/python可以改为其他地址测试  #!/usr/bin/pythonbak
    
14  which    
    which命令的作用是，在PATH变量指定的路径中，搜索某个系统命令的位置，并且返回第一个搜索结果。    
    也就是说，使用which命令，就可以看到某个系统命令是否存在，以及执行的到底是哪一个位置的命令。

15  file+文件名查看文件属性
   
16  改变文件权限 chmod 777 文件名  可以快速赋文件所以权限

17  update-alternatives --config java可以选择当前使用的版本软连接,带*号为当前使用       
    
       Selection    Command     
     -----------------------------------------------       
        1           /usr/lib/jvm/jre-1.8.0-openjdk.x86_64-debug/bin/java          
     *+ 2           /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
    
    
    