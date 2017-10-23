###centos 安装java
1  yum -y list java* 查看相关的包    
2  yum -y install java-1.8.0-openjdk* 把相关的都安装了   
之后控制台输入java -version 查看版本  javac 查看命令   

>环境变量配置：   
修改/etc/profile文件,在profile文件末尾加入   
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk.x86_64     
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar     
export PATH=$PATH:$JAVA_HOME/bin
