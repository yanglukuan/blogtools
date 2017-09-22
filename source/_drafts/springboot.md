---
title: springboot初探
date: 2017-09-22 16:45:03 
tags: [springboot,spring,java]
categories: springboot
---

## spring boot是什么
说起`spring`我们都知道，现在spring的家族体系很庞大，也可帮助我们方便快捷的开发自己的应用。今天我们要介绍的就是`spring`众多体系的一员，也是近一两年比较流行的一个成员`spring boot`。见名知意，`boot`是引导的意思，`spring boot`就是引导我们快速的开发一个基于`spring`的应用的一个框架。
>Spring Boot makes it easy to create stand-alone, production-grade Spring based Applications that you can "just run". We take an opinionated view of the Spring platform and third-party libraries so you can get started with minimum fuss. Most Spring Boot applications need very little Spring configuration.

这是`spring`官网对`spring boot`的说明，意思就是说`Spring Boot`可以轻松创建可以独立“运行”的、可用于生产的基于`Spring`的应用程序，并且不需要太多的配置，也就是我们所说的开箱即用。我们可以利用`spring`官网提供的[`SPRING INITIALIZR`](https://start.spring.io/)工具，快速的创建一个属于我们自己的`spring boot`的应用。

其实`spring boot`并没有引进新的技术单元，本质还是利用`spring4.x`的特性将众多的框架(包括`spring`系列的和一些第三方的)集成在一起，省去了我们手动整合的步骤。`spring boot`通过自动配置、快速开始、内置容器等，极大简化了`spring`应用的开发步骤，它更像一种粘合剂，按照约定大于配置的原则将各种框架和配置都集中的管理起来，当然这种粘合不是强制的，我们可以根据自己的需要增删一些框架和配置，也可以加入自己的配置。

## 解决什么问题
通过上文的分析，我们大概了解了一下`spring boot`，每种技术的出现总是有其特定的技术背景。我们知道整个`spring`框架比较庞大，一般我们常用的比如`spring mvc`、`spring aop`等，当我们基于这些框架开始我们的项目的时候，这将是一个无比痛苦的过程。如果是最开始的`spring 1.x`的时代，我们要写一大堆的配置文件，如果没有`Maven`的帮助，我们还要手动管理无数个框架的`jar`包，即便是现在的`spring 4.x`的时代，我们有了`Maven`可以帮助我们管理各种`jar`包，包括打包、部署等，我们有了基于`javaconfig`和各种注解的配置，省去了写一堆配置文件的麻烦，但是如果我们的项目比较大，使用了各种不同的框架，这个时候要将这些不同的框架整合在一起，也将会面临诸多的问题，比如`jar`包之间的冲突、各种框架的配置规范等。这个时候就需要有一个统一的框架去做一个整合，一站式的解决各种框架的整合问题，快速的开始一个项目，`spring boot`就应运而生了。

## 如何开始
上面介绍了这么多，就是为了让我们对`spring boot`有一个感性的认识，有了感性的认识，才能更进一步的理解和运用。任何的技术都不会凭空产生，了解一项技术、一个框架最好还是了解一下它的技术背景，这样能更好的帮助我们理解作者的一些设计思路，从而更好的学习和利用这项技术。下面我们就通过一个列子来看一下，如何开始一个`spring boot`应用。利用`spring`官网提供的[`SPRING INITIALIZR`](https://start.spring.io/)工具，可以快速的创建一个`spring boot`的应用。我们还可以根据`spring`官网的一个指南[Building an Application with Spring Boot](https://spring.io/guides/gs/spring-boot/)，一步步构建应用。



## 正确踩坑

## 我有一个应用 怎么才能转换成spring boot

## 学习建议
这种情况下新手很容易写得云里雾里的，因为完全不知道背后的原理是什么，相对比在学习spring时需要深刻理解ioc、搞一堆繁琐的配置来说，的确缺少了被迫跳出舒适区去学习一些原理的过程，那么今天就讲讲，为什么spring boot能够如此简单的让我们迅速上手。

建议先熟悉spring体系的应用和原理，再通过官网示例和各种资料去学习spring boot 


## 参考

spring boot 项目搭建

引入方式 
1、parent 方式
```java
<parent>
		<!-- Your own application should inherit from spring-boot-starter-parent -->
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>1.4.3.RELEASE</version>
	</parent>
```
适用于单模块的项目 
2、<dependency> 方式

```java

       <dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-dependencies</artifactId>
			<version>1.4.3.RELEASE</version>
			<type>pom</type>
			<scope>import</scope>
       </dependency>

```
适用于多模块
一般公司都会有自己的pom管理规范 必须继承公司统一的顶层pom 也就是说所有项目会统一使用一个parent 
这个时候 就需要使用这种方式引入 

3、改变tomcat版本 
```java
	<properties>
		<tomcat.version>7.0.73</tomcat.version>
	</properties>
```



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


## 问题与解决
出现各种错误时的解决方法
可以启动 内置tomcat 404 运行目录设置
各种 无法启动  pom依赖配置 
https://my.oschina.net/wenjinglian/blog/1506808

## 实例




http://www.scienjus.com/spring-boot-summary/