---
title: springboot原理
tags:
---



https://www.ibm.com/developerworks/cn/java/j-spring-boot-basics-perry/index.html

http://www.cnblogs.com/xinzhao/p/5551828.html



## 正确踩坑
1、内置tomcat版本与外置tomcat版本
2、打包运行方式

出现各种错误时的解决方法
可以启动 内置tomcat 404 运行目录设置
各种 无法启动  pom依赖配置 



运行方式
1、内置tomcat
2、外置tomcat
springboot最方便的地方就在于他的开箱即用的特性，就是说不需要做任何的配置，仅仅用几行代码你就可以使用springboot构建一个自己的应用。支持这样的特性的关键在于两个地方，第一是自动配置 想想一直被人诟病的一堆配置文件，这是何等的便捷  第二就是支持内置tomcat，这样就统一了开发了部署环境，特别是团队开发，如果使用外置tomcat，每个人的环境可能会不太一样，而且测试、生产的环境也是开发期间不可控制的因素，使用内置tomcat就比较容易管理，而且启动调试比较方便。
打包方式
springboot可以利用内置tomcat将应用与容器一起打成jar包运行，真正做到将环境和应用绑定，不会出现环境不一致的情况，打包部署比使用外置tomcat更加方便，同时也支持原始的war包的形式部署在外部tomcat
jar
war


JSP
其实springboot官方是不建议使用jsp来构建应用的，因为jsp特有的目录结构webapp/web-inf/在打包为jar的时候不会被打包进目录，虽然可以通过pom配置的方式复制文件到resources目录下来打包，但是测试下来发现只有在1.4.2.RELEASE及以前的版本有效，所以如果应用打算使用jar包的方式打包部署，还是尽量不要使用jsp。
不过一般都是在开发阶段使用SpringApplication.run()的方式运行，这种方式使用内置的tomcat来运行程序，打包部署的时候打成war包，使用外部tomcat来运行，但是这里有一点需要注意，内置tomcat的版本一定要与外部的tomcat版本一致，如果不一致会导致上线运行时出现开发时未出现的问题，可以使用`tomcat.version`来指定内置tomcat的版本。
        


外置tomcat + jsp + jar 实例

外置tomcat+jsp+war

内置tomcat+JSP+war
使用内嵌tomcat运行时如果出现404 则配置运行目录为 $MODULE_DIR$


## 使用
pom依赖配置 两种引入方式

不同引入方式下 tomcat版本替换 

内置tomcat调试时设置目录

打包时 内置tomcat与目标tomcat版本一致

与springmvc集成时的javaconfig 启动类放最外层 可以自动扫描所有bean 不用再显示指定扫描
各种web的配置 继承自WebMvcConfigurerAdapter配置类 实体解析器和静态资源设置  拦截器和过滤器配置 


#### springboot实战
http://www.cnblogs.com/yjmyzz/archive/2017/06.html

