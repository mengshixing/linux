### 1.  安装ntpdate工具

yum -y install ntp ntpdate

### 2.  设置系统时间与网络时间同步(日本福冈)

ntpdate 133.100.11.8

### 3.  将系统时间写入硬件时间

hwclock --systohc
