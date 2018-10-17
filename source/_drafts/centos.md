VirtualBox 安装linux虚拟机

远程连接  MobaXterm_Personal_9.4

1、安装虚拟机

2、设置网络 固定IP

3、安装JDK
yum update

wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-i586.rpm"

rpm -ivh jdk-8u102-linux-i586.rpm

export JAVA_HOME=/usr/share/jdk1.6.0_14
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar


source /etc/profile 

4、安装mysql

安装

https://www.cnblogs.com/starof/p/4680083.html

启动
 service mysqld restart

本地连接
 mysql -u root -p  -P 3306

设置编码

远程连接设置
https://www.cnblogs.com/cnblogsfans/archive/2009/09/21/1570942.html

root使用123456从任何主机连接到mysql服务器。
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;


防火墙设置
开放端口 firewall-cmd --zone=public --add-port=3306/tcp --permanent
 firewall-cmd --reload #重启firewall
https://www.cnblogs.com/eaglezb/p/6073739.html


 开机自启动。
https://www.cnblogs.com/zzsdream/p/7390289.html
1 vim /etc/rc.local
2 添加service mysqld start





5、安装tomcat

https://my.oschina.net/gugudu/blog/1538484

启动
systemctl start tomcat.service
开机启动
运行命令 systemctl enable tomcat.service
1 vim /etc/rc.local
2 添加service tomcat start

https://www.jianshu.com/p/f0f8458e1631



配置文件/usr/lib/systemd/system/tomcat.service

[Unit]
Description=Tomcat
After=syslog.targetnetwork.target remote-fs.target nss-lookup.target

[Service]
Type=forking
# PIDFile=/root/opt/tomcat/apache-tomcat-7.0.78/tomcat.pid
ExecStart=/root/opt/tomcat/apache-tomcat-7.0.78/bin/startup.sh
ExecReload=/bin/kill-s HUP $MAINPID
ExecStop=/bin/kill-s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target





6、zk
开机启动
配置文件/usr/lib/systemd/system/zookeeper.service
[Unit]
Description=zookeeper.service
After=network.target
[Service]
Type=forking
Environment=/root/opt/zookeeper-3.3.6/
ExecStart=/root/opt/zookeeper-3.3.6/bin/zkServer.sh start
ExecStop=/root/opt/zookeeper-3.3.6/bin/zkServer.sh stop
ExecReload=/root/opt/zookeeper-3.3.6/bin/zkServer.sh restart
[Install]
WantedBy=multi-user.target



http://www.voidcn.com/article/p-zlkubgge-zq.html








开机启动

systemctl daemon-reload




关机命令：shutdown -h now（立刻进行关机）

                  halt（立刻进行关机）

                  poweroff（立刻进行关机）

重启命令：shutdown -r now（现在重新启动计算机）

                  reboot（现在重新启动计算机）



移动文件 mv  源文件  目标地址


https://blog.csdn.net/lzw5210/article/details/60142319
https://my.oschina.net/u/1428349/blog/288708
https://www.cnblogs.com/franknihao/p/7153748.html
https://blog.csdn.net/yxc135/article/details/8458939

https://blog.csdn.net/u013703963/article/details/69948694