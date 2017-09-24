---
title: Spring Boot初探
date: 2017-09-22 16:45:03 
tags: [springboot,spring,java]
categories: springboot
---

## Spring Boot是什么
在说`Spring Boot`之前，我们先来说一下`Spring`，简单回顾一下`Spring`的发展。说起`Spring`我们都知道，它是一套非常优秀的开发框架，现在的`Spring`家族体系很庞大，利用`Spring`提供的各种模块，我们可以方便快捷的开发自己的应用。`Spring`从出到现在可以总结为以下几个发展阶段，每个阶段都会有新的特性加入，从而给我们带来更多的惊喜和便捷。
### Spring1.X
`Spring 1.0`的出现彻底改变了我们开发企业级`Java`应用程序的方式。`Spring`的依赖注入与声明式事务意味着组件之间再也不存在紧耦合，再也不用重量级的`EJB`了。
### Spring 2.X
到了`Spring 2.0`，我们可以在配置里使用自定义的XML命名空间，更小、更简单易懂的配置文件让`Spring`本身更便于使用。`Spring 2.5`让我们有了更优雅的面向注解的依赖注入模型（即`@Component`和`@Autowired`注解），以及面向注解的`Spring MVC`编程模型。不用再去显式地声明应用程序组件了，也不再需要去继承某个基础的控制器类了。
### Spring 3.X
到了`Spring 3.0`，我们有了一套基于`Java`的全新配置，它能够取代`XML`。在`Spring 3.1`里，一系列以`@Enable`开头的注解进一步完善了这一特性。终于，我们第一次可以写出一个没有任何`XML`配置的`Spring`应用程序了。
### Spring 4.X 
`Spring 4.0`对条件化配置提供了支持，根据应用程序的`Classpath`、环境和其他因素，运行时决策将决定使用哪些配置，忽略哪些配置。那些决策不需要在构建时通过编写脚本确定了，以前会把选好的配置放在部署的包里，现在情况不同了。
### Spring Boot
今天我们要介绍的是`Spring`众多体系的一员，也是近一两年比较流行的一个框架`Spring Boot`。见名知意，`Boot`是引导的意思，`Spring Boot`就是引导我们快速的开发一个基于`Spring`的应用的一个框架。
>Spring Boot makes it easy to create stand-alone, production-grade Spring based Applications that you can "just run". We take an opinionated view of the Spring platform and third-party libraries so you can get started with minimum fuss. Most Spring Boot applications need very little Spring configuration.

这是`Spring`官网对`Spring Boot`的说明，意思就是说`Spring Boot`可以轻松创建可以独立“运行”的、可用于生产的基于`Spring`的应用程序，由于它整合了`Spring platform`和一些三方库的配置，使我们可以做到真正的开箱即用并且不需要太多的配置。我们可以利用`Spring`官网提供的[`SPRING INITIALIZR`](https://start.spring.io/)工具，快速的创建一个属于我们自己的`Spring Boot`的应用。

其实`Spring Boot`并没有引进新的技术单元，本质还是利用`Spring4.x`的特性将众多的框架(包括`Spring`系列的和一些第三方的)集成在一起，省去了我们手动整合的步骤。`Spring Boot`通过自动配置、快速开始、内置容器等，极大简化了`Spring`应用的开发步骤，它更像一种粘合剂，按照约定大于配置的原则将各种框架和配置都集中的管理起来，当然这种粘合不是强制的，我们可以根据自己的需要增删一些框架和配置，也可以加入自己的配置。

## 解决什么问题
通过上文的分析，我们大概了解了一下`Spring Boot`，每种技术的出现总是有其特定的技术背景。我们知道整个`Spring`框架比较庞大，一般我们常用的比如`Spring mvc`、`Spring aop`等，当我们基于这些框架开始我们的项目的时候，这将是一个无比痛苦的过程。如果是最开始的`Spring 1.x`的时代，我们要写一大堆的配置文件，如果没有`Maven`的帮助，我们还要手动管理无数个框架的`jar`包，即便是现在的`Spring 4.x`的时代，我们有了`Maven`可以帮助我们管理各种`jar`包，包括打包、部署等，我们有了基于`javaconfig`和各种注解的配置，省去了写一堆配置文件的麻烦，但是如果我们的项目比较大，使用了各种不同的框架，这个时候要将这些不同的框架整合在一起，也将会面临诸多的问题，比如`jar`包之间的冲突、各种框架的配置规范等。这个时候就需要有一个统一的框架去做一个整合，一站式的解决各种框架的整合问题，快速的开始一个项目，`Spring Boot`就应运而生了。

## 如何开始
上面介绍了这么多，就是为了让我们对`Spring Boot`有一个感性的认识，有了感性的认识，才能更进一步的理解和运用。任何的技术都不会凭空产生，了解一项技术、一个框架最好还是了解一下它的技术背景，这样能更好的帮助我们理解作者的一些设计思路，从而更好的学习和利用这项技术。下面我们就通过一个列子来看一下，如何开始一个`Spring Boot`应用。利用`Spring`官网提供的[`SPRING INITIALIZR`](https://start.spring.io/)工具，可以快速的创建一个`Spring Boot`的应用。我们还可以根据`Spring`官网的一个指南[Building an Application with Spring Boot](https://spring.io/guides/gs/spring-boot/)，一步步构建应用。以上两种方式都可以帮助我们快速的开始构建一个`Spring Boot`的应用，除了这两种方式外，我们还可以使用`Maven`来手动创建一个`Spring Boot`的应用，这样更有利于我们对它的了解。
1、工具准备
`IntelliJ IDEA` 、`Maven`、 `JDK1.8`
2、使用`IntelliJ IDEA`创建一个空的`Maven`项目，修改项目的`POM`文件，加入`Spring Boot`的依赖项。这里说明一下，`Spring Boot`有两种引入方式，一种是`parent`的方式，另一种是`dependency`方式。对于这两种方式，一般在公司的项目中，我们选用后者，因为大部分公司都使用自己公司的`Maven`私有仓库，也制定了一些`POM`文件的规范，规定了项目中只允许依赖一个规定的`parent`，(比如我厂)。这个时候我们只能使用`dependency`的方式引入。这里我们选用`parent`的方式引入，使用这种方式有一个很方便的地方，就是你可以很方便的更改内置容器`Tomcat`的版本，至于为什么要改，我们下面一部分再说。
3、引入支持`Web`项目的`Starter pom`，这个`Starter pom`用来快速引入一些`Maven`的依赖项，比如我们要构建一个`Web`的项目，现在只需要添加一个`spring-boot-starter-web`的一个依赖，这个依赖会自动添加我们构建`Web`应用所需要的其他依赖项，省去了我们依次添加各种`Web`依赖的步骤，非常的方便。最后再加入一个`Spring Boot`的编译插件，最终的`POM`文件如下：
```xml

<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <!--Spring Boot-->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.4.3.RELEASE</version>
    </parent>

    <!--project info-->
    <groupId>com.kevin.hello</groupId>
    <artifactId>hello</artifactId>
    <version>1.0-SNAPSHOT</version>

    <!--Spring Boot starter-web-->
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <!--Spring Boot plugin-->
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

```
4、创建项目文件，我们首先要创建一个`Spring MVC`项目的控制器，一个`Controller`类。这里有一个注解说明一下，`RestController`，这个注解是一个组合注解，即组合了`@Controller`和`@ResponseBody`这两个注解，这样就相当于在这个`Controller`的每一个方法上都加上一个`ResponseBody`，可以用来向前端输出一个`JSON`对象，如果不加上这个`ResponseBody`，直接使用`Controller`只能向前端输出一个视图，下面这段代码的意思就是，当请求指向应用的根目录`/`时，向前端输出一段字符串`Hello World`。
```java
package com.kevin.hello.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by kevin on 2017/9/24.
 */
@RestController
public class helloController {

    @RequestMapping("/")
    public String index() {
        return "Hello World";
    }

}


```
5、最后，也是最关键的一个步骤，我们需要一个启动类，也就是一个程序的入口。前面我们提到，`Spring Boot`支持内嵌容器启动，不需要外部容器的支持，能做到这一点，靠的就是这个入口点。我们在`controller`包的外层，也就是`com.kevin.hello`包下面，创建一个`ApplicationStart`的类，这个类只有一个mian方法，就是整个程序的入口。这里有两个地方需要说明一下，第一个，`@SpringBootApplication`注解是整个`Spring Boot`项目的核心注解，它的主要作用是开启自动配置，告诉框架这是一个`Spring Boot`的应用。默认只会扫描类所在包以及其子包，所以，启动类最好放在最外层的包下面。第二个，`main`方法，这个方法其实就是一个标准的`Java`应用的入口方法，在这里启动了一个`SpringApplication`，启动方法是`run`方法,这里完成`Spring`容器的启动和初始化，这个过程比较复杂也比较核心，本文不侧重讲解原理，后续文章会结合源码分析，有兴趣的同学可以自行研究下。
```java

package com.kevin.hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Created by kevin on 2017/9/24.
 */
@SpringBootApplication
public class ApplicationStart {
    public static void  main(String[] args){
        SpringApplication.run(Application.class,args);
    }

}

```
好了，到这里，我们的`Spring Boot`项目就建好了，下面就是见证奇迹的时刻了。在上面的`main`方法上右键，`run ApplicationStart.main() `,也可以使用命令行`mvn spring-boot:run`运行，看到控制台输出的日志，如果没有报错，说明已经成功启动，这个时候我们打开浏览器，输入`http://localhost:8080/`，就可以看到一行输出`Hello World`。当控制台出现下面这个标志时，就说明当前应用是通过`Spring Boot`启动。
```text

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v1.4.3.RELEASE)

```
### Thymeleaf 视图
1、上面只是一个特别简单的例子，只输出了一段字符串，并没有引入视图，旨在让大家感受一下`Spring Boot`项目创建的过程和使用方式的便捷，下面我来创建一个带有视图的控制器，在上面的项目中添加一个控制器`helloViewController`，这里我们返回一个视图。下面这段代码的意思是当请求指向`/index`时，返回一个`/index`的视图，并向视图中输出了一个为`hi`的字符串对象，这里模板引擎选择`Thymeleaf`，也是`Spring Boot`官方推荐使用的模板引擎。
```java

package com.kevin.hello.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by kevin on 2017/9/24.
 */
@Controller
public class helloViewController {

    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView indexView(){
        ModelAndView mv=new ModelAndView("/index");
        mv.addObject("hi","hello World");
        return mv;
    }
}


```
2、`POM`文件修改，添加依赖项。
```xml
  <!--Spring Boot thymeleaf-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>

        <!-- Html 解析-->
        <dependency>
            <groupId>net.sourceforge.nekohtml</groupId>
            <artifactId>nekohtml</artifactId>
            <version>1.9.22</version>
        </dependency>

```
3、在`resources/templates`下添加`html`文件，使用`thymeleaf`作为模板引擎，`index.html`，`${hi}`用来输出`ModelAndView`中的对象。

```xml

<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml" >
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<p th:text="${hi}"></p>
</body>
</html>

```
4、在`resources`文件夹下新建配置文件，`application.properties`，设置配置项，`spring.thymeleaf.mode=LEGACYHTML5`。`Spring Boot`允许我们自定义一个`application.properties`文件，来重写`Spring Boot`的环境变量或者定义自己环境变量。
5、这样我们就完成了一个返回视图的控制器，现在启动应用，用浏览器访问`http://localhost:8080/index`，就会看到输出`hello World`。

### JSP 视图
看到这里，有很多老铁要问了，"能不能使用`JSP`当作模板引擎"。这个问题怎么回答呢，其实`Spring Boot`官方是不推荐在`Spring Boot`的应用中使用`JSP`的，原因当然有很多，不过其中最主要的原因是当使用`JSP`模板引擎时，会有一个特殊的目录结构，`webapp/WEB-INF/jsp`,相信这个目录结构大家肯定不陌生。上文我们说到，`Spring Boot`支持内嵌容器并且可以以`Jar`包的方式运行，那么在打包为`Jar`包时，其实这个目录是不会被打包的，所以，官方不推荐使用`JSP`。当然，这里只是不推荐，也不是说不可以用，我们可以使用修改`POM`文件的方式，在打包时，将`webapp/WEB-INF/jsp`目录复制到`resources`目录，这样就可以正常使用了。不过就目前的状况来看，如果是之前的项目，改造的话可能成本会比较高，可以继续使用`JSP`，新做的项目就不推荐再使用`JSP`了，现在`Spring Boot`支持的模板引擎有很多，包括`FreeMarker`、`Groovy`、`Thymeleaf(官方推荐)`、`Mustache`这些我们都可以自由选择，适合自己的才是最好的。下面我们就来看看`JSP`模板引擎的创建。
1、修改pom  
2、添加控制器
3、添加html
4、配置前缀后缀
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
5、运行 出结果
6、使用外置tomcat运行
7、打包为war
8、打包为jar

## 正确踩坑
1、内置tomcat版本与外置tomcat版本
2、打包运行方式

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
http://www.cnblogs.com/davidwang456/p/5846513.html


## spring 
让我们来看看Spring历史中的一些演化历程。

Spring 1.0的出现彻底改变了我们开发企业级Java应用程序的方式。Spring的依赖注入与声明式事务意味着组件之间再也不存在紧耦合，再也不用重量级的EJB了。这玩意儿不能更好了。

到了Spring 2.0，我们可以在配置里使用自定义的XML命名空间，更小、更简单易懂的配置文件让Spring本身更便于使用。这玩意儿不能更好了。

Spring 2.5让我们有了更优雅的面向注解的依赖注入模型（即@Component和@Autowired注解），以及面向注解的Spring MVC编程模型。不用再去显式地声明应用程序组件了，也不再需要去继承某个基础的控制器类了。这玩意儿不能更好了。

到了Spring 3.0，我们有了一套基于Java的全新配置，它能够取代XML。在Spring 3.1里，一系列以@Enable开头的注解进一步完善了这一特性。终于，我们第一次可以写出一个没有任何XML配置的Spring应用程序了。这玩意儿不能更好了。

Spring 4.0对条件化配置提供了支持，根据应用程序的Classpath、环境和其他因素，运行时决策将决定使用哪些配置，忽略哪些配置。那些决策不需要在构建时通过编写脚本确定了；以前会把选好的配置放在部署的包里，现在情况不同了。这玩意儿不能更好了。

现在轮到Spring Boot了。虽然Spring的每个版本都让我们觉得一切都不能更好了，但Spring Boot还是向我们证明了Spring仍然有巨大的潜力。事实上，我相信Spring Boot是长久以来Java开发历程里最意义深刻、激动人心的东西。