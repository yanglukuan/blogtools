---
title: SonarQube 服务搭建与配置
date: 2017-08-17 17:07:49
tags: SonarQube
categories: 代码质量
---
    
## SonarQube是神马
   1.`SonarQube（又叫Sonar）`是对代码进行静态检测的开源平台,利用这个工具可以发现我们代码里各种隐藏的Bug和潜在的问     题，在团队协作的开发模式中可以更好的控制代码质量。
   2.支持多种平台`（Windows、Linux）`和多种开发语言`(java、C#、JavaScript、PHP等)`,并可以和`Jekins、JIRA`等多种外部工具和`IntelliJ IDEA`等开发工具无缝集成。
   3.可视化界面，提供各种维度的质量查询和分析。
## 如何使用
  ### **准备工作**
   - 下载软件
   `SonarQube` [https://www.sonarqube.org/downloads/](https://www.sonarqube.org/downloads/)
   规则插件 `checkstyle`  [https://github.com/checkstyle/sonar-checkstyle](https://github.com/checkstyle/sonar-checkstyle) 
   `pmd` [https://github.com/SonarQubeCommunity/sonar-pmd](https://github.com/SonarQubeCommunity/sonar-pmd)
   `findbugs` [https://github.com/SonarQubeCommunity/sonar-findbugs](https://github.com/SonarQubeCommunity/sonar-findbugs)
   汉化插件 `sonar-l10n-zh-master` [https://github.com/SonarQubeCommunity/sonar-l10n-zh](https://github.com/SonarQubeCommunity/sonar-l10n-zh)
   本地扫描插件 `sonar-runner-dist-2.4` [http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/](http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/)   
   **以上插件均是源码 需要下载后自行编译**
   - 所需环境
   `JDK1.7`或以上
   `Maven`
   `Mysql`
   - 配置
    a.`sonarqube\conf` 配置     
    `sonar.properties`内容
   ```xml
   sonar.jdbc.username=sonar
   sonar.jdbc.password=sonar
   sonar.jdbc.url=jdbc:mysql://127.0.0.1:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance
   ```
    b.mysql 配置
      - 在mysql管理器中执行如下脚本创建数据库及mysql用户  
   ```sql
   CREATE DATABASE sonar CHARACTER SET utf8 COLLATE utf8_general_ci;  
   CREATE USER 'sonar' IDENTIFIED BY 'sonar';
   GRANT ALL ON sonar.* TO 'sonar'@'%' IDENTIFIED BY 'sonar';
   GRANT ALL ON sonar.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar';
   FLUSH PRIVILEGES;
   ```
      - `mysql max_allowed_packet`配置
   路径 `C:\ProgramData\MySQL\MySQL Server 5.6\my.ini `  
   设置 `max_allowed_packet=101943040`
   - 插件编译 安装
   分别编译下载的插件,去掉`snapshort`标记,放入插件目录下`sonarqube-6.4\extensions\plugins`
   - 启动
   至此,启动mysql,启动`sonarqube`,本地访问 `http://localhost:9000/ `
   可看到管理界面
   登录名\密码   `admin\admin`

### **扫描配置**

 - `maven`扫描 配置
   `maven`配置文件添加节点
```xml
  <profile>
   <id>sonar</id>
   <activation>
       <activeByDefault>true</activeByDefault>
   </activation>
   <properties>
        <sonar.jdbc.url>
		<![CDATA[jdbc:mysql://127.0.0.1:3306/sonar]]>
        </sonar.jdbc.url>
        <sonar.jdbc.driver>com.mysql.jdbc.Driver</sonar.jdbc.driver>
        <sonar.jdbc.username>sonar</sonar.jdbc.username>
        <sonar.jdbc.password>sonar</sonar.jdbc.password>
		<sonar.jdbc.maxWait>50000</sonar.jdbc.maxWait>
		<sonar.jdbc.minEvictableIdleTimeMillis>600000</sonar.jdbc.minEvictableIdleTimeMillis>
        <sonar.jdbc.timeBetweenEvictionRunsMillis>30000</sonar.jdbc.timeBetweenEvictionRunsMillis>
        <sonar.host.url>http://localhost:9000</sonar.host.url>
   </properties>
  </profile>
```
   执行maven命令`mvn sonar:sonar` 可扫描项目并上传质量报告

 - `sonar-runner` 扫描配置  
  a.环境变量配置
   系统环境变量
   ``` 
   SONAR_RUNNER_HOME  D:\Java\sonar-runner-2.4
   Path 追加 ;%SONAR_RUNNER_HOME%\bin;
   ```
   b.sonar-runner.properties配置文件

   ```xml
   #Configure here general information about the environment, such as SonarQube DB details for example
   #No information about specific project should appear here
  
   #----- Default SonarQube server
   sonar.host.url=http://localhost:9000
  
   #----- PostgreSQL
   #sonar.jdbc.url=jdbc:postgresql://localhost/sonar
  
   #----- MySQL
   sonar.jdbc.url=jdbc:mysql://127.0.0.1:3306/sonar?useUnicode=true&amp;characterEncoding=utf8
  
   #----- Oracle
   #sonar.jdbc.url=jdbc:oracle:thin:@localhost/XE
  
   #----- Microsoft SQLServer
   #sonar.jdbc.url=jdbc:jtds:sqlserver://localhost/sonar;SelectMethod=Cursor
  
   #----- Global database settings
   sonar.jdbc.username=sonar
   sonar.jdbc.password=sonar
  
   #----- Default source code encoding
   sonar.sourceEncoding=UTF-8
  
   #----- Security (when 'sonar.forceAuthentication' is set to 'true')
   sonar.login=admin
   sonar.password=admin
   ```
  c、本地项目配置文件  项目根目录
   sonar-project.properties配置文件

   ```xml
   sonar.projectKey=projectKey 
   sonar.projectName=projectName
   sonar.projectVersion=1.0
   # Set modules IDs
   sonar.modules=projectmodules

   # Modules inherit properties set at parent level
   sonar.sources=src
   sonar.sourceEncoding=UTF-8
   sonar.language=java
   sonar.java.binaries=target
   # By default, the base directory for a module is <current_dir>/<module_ID>.
   ```
  至此  使用命令行进入到项目根目录
  输入命令 `sonar-runner` 可以完成项目的扫描和上传报告  

## 参考
https://zhuanlan.zhihu.com/p/22926742
http://blog.csdn.net/xiajian2010/article/details/22983825
http://www.cnblogs.com/parryyang/p/6270402.html
