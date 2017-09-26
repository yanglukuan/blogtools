---
title: Spring Boot初探
date: 2017-09-22 16:45:03 
tags: [spring boot,spring,java]
categories: spring boot
---

## Spring Boot是什么
在说`Spring Boot`之前，我们先来说一下`Spring`，简单回顾一下`Spring`的发展。说起`Spring`我们都知道，它是一套非常优秀的开发框架，现在的`Spring`家族体系很庞大，利用`Spring`提供的各种模块，我们可以方便快捷的开发自己的应用。`Spring`从出到现在可以总结为以下几个发展阶段，每个阶段都会有新的特性加入，从而给我们带来更多的惊喜和便捷。
### Spring1.X
`Spring 1.0`的出现彻底改变了我们开发企业级`Java`应用程序的方式。`Spring`的依赖注入与声明式事务意味着组件之间再也不存在紧耦合，再也不用重量级的`EJB`了。
### Spring 2.X
到了`Spring 2.0`，我们可以在配置里使用自定义的`XML`命名空间，更小、更简单易懂的配置文件让`Spring`本身更便于使用。`Spring 2.5`让我们有了更优雅的面向注解的依赖注入模型（即`@Component`和`@Autowired`注解），以及面向注解的`Spring MVC`编程模型。不用再去显式地声明应用程序组件了，也不再需要去继承某个基础的控制器类了。
### Spring 3.X
到了`Spring 3.0`，我们有了一套基于`Java`的全新配置，它能够取代`XML`。在`Spring 3.1`里，一系列以`@Enable`开头的注解进一步完善了这一特性。终于，我们第一次可以写出一个没有任何`XML`配置的`Spring`应用程序了。
### Spring 4.X 
`Spring 4.0`对条件化配置提供了支持，根据应用程序的`Classpath`、环境和其他因素，运行时决策将决定使用哪些配置，忽略哪些配置。那些决策不需要在构建时通过编写脚本确定了，以前会把选好的配置放在部署的包里，现在情况不同了。
### Spring Boot
今天我们要介绍的是`Spring`众多体系的一员，也是近一两年比较流行的一个框架`Spring Boot`。见名知意，`Boot`是引导的意思，`Spring Boot`就是引导我们快速开发一个基于`Spring`应用的一个框架。
>Spring Boot makes it easy to create stand-alone, production-grade Spring based Applications that you can "just run". We take an opinionated view of the Spring platform and third-party libraries so you can get started with minimum fuss. Most Spring Boot applications need very little Spring configuration.

这是`Spring`官网对`Spring Boot`的说明，意思就是说`Spring Boot`可以轻松创建可以独立“运行”的、可用于生产的基于`Spring`的应用程序，由于它整合了`Spring platform`和一些三方库的配置，使我们可以做到真正的开箱即用并且不需要太多的配置。我们可以利用`Spring`官网提供的[`SPRING INITIALIZR`](https://start.spring.io/)工具，快速的创建一个属于我们自己的`Spring Boot`的应用。

其实`Spring Boot`并没有引进太多新的技术单元，本质还是利用`Spring4.x`的特性将众多的框架(包括`Spring`系列的和一些第三方的)集成在一起，省去了我们手动整合的步骤。`Spring Boot`通过自动配置、快速开始、内置容器等，极大简化了`Spring`应用的开发步骤，它更像一种粘合剂，按照约定大于配置的原则将各种框架和配置都集中的管理起来，当然这种粘合不是强制的，我们可以根据自己的需要增删一些框架和配置，也可以加入自己的配置。

## 解决什么问题
通过上文的分析，我们大概了解了一下`Spring Boot`，每种技术的出现总是有其特定的技术背景。我们知道整个`Spring`框架比较庞大，一般我们常用的比如`Spring mvc`、`Spring aop`等，当我们基于这些框架开始我们的项目的时候，这将是一个无比痛苦的过程。如果是最开始的`Spring 1.x`的时代，我们要写一大堆的配置文件，如果没有`Maven`的帮助，我们还要手动管理无数个框架的`jar`包，即便是现在的`Spring 4.x`的时代，我们有了`Maven`可以帮助我们管理各种`jar`包，包括打包、部署等，我们有了基于`javaconfig`和各种注解的配置，省去了写一堆配置文件的麻烦，但是如果我们的项目比较大，使用了各种不同的框架，这个时候要将这些不同的框架整合在一起，也将会面临诸多的问题，比如`jar`包之间的冲突、各种框架的配置规范等。这个时候就需要有一个统一的框架去做一个整合，一站式的解决各种框架的整合问题，快速的开始一个项目，`Spring Boot`就应运而生了。

## 如何开始
上面介绍了这么多，就是为了让我们对`Spring Boot`有一个感性的认识，有了感性的认识，才能更进一步的理解和运用。任何的技术都不会凭空产生，了解一项技术、一个框架最好还是了解一下它的技术背景，这样能更好的帮助我们理解作者的一些设计思路，从而更好的学习和利用这项技术。下面我们就通过一个列子来看一下，如何开始一个`Spring Boot`应用。利用`Spring`官网提供的[`SPRING INITIALIZR`](https://start.spring.io/)工具，可以快速的创建一个`Spring Boot`的应用。我们还可以根据`Spring`官网的一个指南[Building an Application with Spring Boot](https://spring.io/guides/gs/spring-boot/)，一步步构建应用。以上两种方式都可以帮助我们快速的开始构建一个`Spring Boot`的应用，除了这两种方式外，我们还可以使用`Maven`来手动创建一个`Spring Boot`的应用，这样更有利于我们对它的了解。
1、工具准备
`IntelliJ IDEA` 、`Maven`、 `JDK1.8`
2、使用`IntelliJ IDEA`创建一个空的`Maven`项目，修改项目的`POM`文件，加入`Spring Boot`的依赖项。这里说明一下，`Spring Boot`有两种引入方式，一种是`parent`的方式，另一种是`dependency`方式。对于这两种方式，一般在公司的项目中，我们选用后者，因为大部分公司都使用自己公司的`Maven`私有仓库，也制定了一些`POM`文件的规范，规定了项目中只允许依赖一个规定的`parent`，(比如我厂)。这个时候我们只能使用`dependency`的方式引入。这里我们选用`parent`的方式引入，使用这种方式有一个很方便的地方，就是你可以很方便的更改内置容器`Tomcat`的版本，至于为什么要改，我们下面一部分再说。
3、引入支持`Web`项目的`Starter pom`，这个`Starter pom`用来快速引入一些`Maven`的依赖项，比如我们要构建一个`Web`的项目，现在只需要添加一个`spring-boot-starter-web`的一个依赖，这个依赖会自动添加我们构建`Web`应用所需要的其他依赖项，省去了我们依次添加各种`Web`依赖的步骤，非常的方便。最后再加入一个`Spring Boot`的编译插件，我们这里使用的`Spring Boot`版本为`1.4.3.RELEASE`，因为公司项目目前使用这个版本，最终的`POM`文件如下：
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
    <packaging>war</packaging>

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
5、最后，也是最关键的一个步骤，我们需要一个启动类，也就是一个程序的入口。前面我们提到，`Spring Boot`支持内嵌容器启动，不需要外部容器的支持，能做到这一点，靠的就是这个入口点。我们在`controller`包的外层，也就是`com.kevin.hello`包下面，创建一个`ApplicationStart`的类，这个类只有一个`main`方法，就是整个程序的入口。这里有两个地方需要说明一下，第一个，`@SpringBootApplication`注解是整个`Spring Boot`项目的核心注解，它的主要作用是开启自动配置，告诉`Spring`框架这是一个`Spring Boot`的应用。这个是一个组合注解，包含`ComponentScan`注解，默认只会扫描类所在包以及其子包，所以，启动类最好放在最外层的包下面。第二个，`main`方法，这个方法其实就是一个标准的`Java`应用的入口方法，在这里启动了一个`SpringApplication`，启动方法是`run`方法，这里完成`Spring`容器的启动和初始化，这个过程比较复杂也比较核心，本文不侧重讲解原理，后续文章会结合源码分析，有兴趣的同学可以自行研究下。
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
1、上面只是一个特别简单的例子，只输出了一段字符串，并没有引入视图，旨在让大家感受一下`Spring Boot`项目创建的过程和使用方式的便捷，下面我们来创建一个带有视图的控制器，在上面的项目中添加一个控制器`helloViewController`，这里我们返回一个视图。下面这段代码的意思是当请求指向`index`时，返回一个`index`的视图，并向视图中输出了一个为`hi`的字符串对象，这里模板引擎选择`Thymeleaf`，也是`Spring Boot`官方推荐使用的模板引擎。
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
        ModelAndView mv=new ModelAndView("index");
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
4、在`resources`文件夹下新建配置文件，`application.properties`，设置配置项，`spring.thymeleaf.mode=LEGACYHTML5`。`Spring Boot`允许我们自定义一个`application.properties`文件，来修改`Spring Boot`的环境变量。
5、这样我们就完成了一个返回视图的控制器，现在启动应用，用浏览器访问`http://localhost:8080/index`，就会看到输出`hello World`。

### JSP 视图
看到这里，有很多老铁要问了，"能不能使用`JSP`当作模板引擎"。这个问题怎么回答呢，其实`Spring Boot`官方是不推荐在`Spring Boot`的应用中使用`JSP`的，原因当然有很多，不过其中最主要的原因是当使用`JSP`模板引擎时，会有一个特殊的目录结构，`webapp/WEB-INF`，相信这个目录结构大家肯定不陌生。上文我们说到，`Spring Boot`支持内嵌容器并且可以以`Jar`包的方式运行，那么在打包为`Jar`包时，其实这个目录是不会被打包的，所以，官方不推荐使用`JSP`。当然，这里只是不推荐，也不是说不可以用，我们可以使用修改`POM`文件的方式，在打包时，将`webapp/WEB-INF`目录复制到`resources`目录，这样就可以正常使用了。不过就目前的状况来看，如果是之前的项目，改造的话可能成本会比较高，可以继续使用`JSP`，新做的项目就不推荐再使用`JSP`了，现在`Spring Boot`支持的模板引擎有很多，包括`FreeMarker`、`Groovy`、`Thymeleaf(官方推荐)`、`Mustache`等，这些我们都可以自由选择，适合自己的才是最好的。下面我们就来看看`JSP`模板引擎的创建。
1、`POM`文件修改，注释掉`thymeleaf`的相关依赖项，然后添加`JSP`相关依赖，由于我们改变了默认的`Tomcat`版本，变成了`7.0.73`，所以需要再添加一个`tomcat-juli`的依赖。
```xml

        <!--Spring Boot thymeleaf-->
        <!--<dependency>-->
            <!--<groupId>org.springframework.boot</groupId>-->
            <!--<artifactId>spring-boot-starter-thymeleaf</artifactId>-->
        <!--</dependency>-->


        
        <!--tomcat 日志组件-->
        <dependency>
            <groupId>org.apache.tomcat</groupId>
            <artifactId>tomcat-juli</artifactId>
            <version>${tomcat.version}</version>
        </dependency>

        <!-- jasp 解析-->
        <dependency>
            <groupId>org.apache.tomcat.embed</groupId>
            <artifactId>tomcat-embed-jasper</artifactId>
        </dependency>

        <!-- jstl 解析-->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jstl</artifactId>
        </dependency>

```
2、添加控制器，添加一个`helloJSPController`的控制器，当请求指向`/indexjsp`时，返回一个`JSP`的视图，并包含一个`hijsp`的对象，代码如下：
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
public class helloJSPController {

    @RequestMapping(value="/indexjsp",method = RequestMethod.GET)
    public ModelAndView indexView(){
        ModelAndView mv=new ModelAndView("/indexjsp");
        mv.addObject("hijsp","hello World JSP");
        return mv;
    }

}

```
3、添加`JSP`页面，在`src/main`下创建`webapp/WEB-INF/jsp`目录，并添加`indexjsp.jsp`文件。
```xml

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
${hijsp}
</body>
</html>

```
4、配置视图解析前缀后缀
这里需要注意，原来我们在写`Spring MVC`项目时，需要配置一个`dispatcherservlet`作为`MVC`项目的前端控制器，所有的请求都要经过这个控制器，还需要配置一个视图解析器的解析规则。其实，在`Spring Boot`中，这些都已经自动配置了，我们这里需要根据自己的需要来做一些更改，需要在`application.properties`中增加视图解析器的解析规则：
```xml
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```
5、这样，所有的配置和准备工作都已经就绪，启动应用，浏览器访问`http://localhost:8080/indexjsp`，就会看到输出`hello World JSP`。

### 打包部署
#### war
1、到目前为止，我们都是使用`Spring Boot`内置的`Tomcat`来运行，这样确实方便了不少，不需要配置外部`Tomcat`，特别是团队开发的时候，避免了多人使用的`Tomcat`版本不一致的情况。但是项目终究要完成开发到部署的阶段，在部署的时候，我们有两种选择，一个是使用`jar`包方式，一个是使用`war`包方式。不过有时候受限于公司规定，只能使用某种特定的格式部署，比如我厂规定，只能使用`war`包方式部署应用。下面我们就来看看怎样将应用部署在外部`Tomcat`。
2、首先我们使用外部`Tomcat`来运行一下，确保应用是正确的，在`IntelliJ IDEA`的`run/debug`工具中配置`Tomcat`，这里我们选用的版本是`7.0.73`，与我们项目中内置的版本一致，这里说一下，最好保持内置和外置的`Tomcat`版本一致，不然可能会发生一些未知的错误，这里我们需要将`Spring Boot`的内置`Tomcat`版本替换为`7.0.73`，替换方式为在`POM`文件增加如下配置，我们上面说到使用`parent`的方式引入方便更改`Tomcat`的版本，就在这里，如果使用`dependency`引入，就比较复杂一点，有兴趣的同学可以研究一下。另外我厂的做法是，直接改写`spring-boot-starter-tomcat`组件，在这个`POM`文件中修改`Tomcat`的版本，这样就可以统一管理所有应用的`Tomcat`版本，无需手动指定了。
```xml

    <properties>
    <tomcat.version>7.0.73</tomcat.version>
    </properties>

```

3、修改`POM`文件项目属性，`<packaging>war</packaging>`，将打包方式设置为`war`，然后启动项目，浏览器访问`http://localhost:8080/indexjsp`，就会看到输出`hello World JSP`。
4、使用`Maven`打包命令`mvn package`进行打包，可以看到输出目录`target`下面会生成一个`war`文件，拷贝文件至`Tomcat`的`webapps`目录下，启动`Tomcat`，浏览器访问`http://localhost:8080/yourproject/indexjsp`，就会看到输出`hello World JSP`。
#### jar
1、看到这里，有老铁又要问了，"那我想使用jar包部署怎么办呢"。其实如果是`Tomcat+JSP`的应用，是不建议使用`Jar`包的方式部署的，原因上文已经说过了，但是也不是不可以用，只不过要稍微做一些另外的配置，而且对`Spring Boot`的版本有要求，我的测试结果是版本需要低于`1.4.3.RELEASE`，下面我们使用`1.4.2.RELEASE`版本来试验一下。
2、使用`JSP`模板
修改`POM`文件，`<packaging>jar</packaging>`，将打包方式设置为`jar`，添加资源处理工具和入口类，使用`Maven`打包命令`mvn package`进行打包。然后使用命令行运行`java -jar yourproject.jar`，就可以启动应用了。其实这里`<packaging>war</packaging>`也是一样的，执行命令`java -jar yourproject.war`也可以启动应用，也就是说在这种配置下，打包出的`war`包既可以部署在外置的`Tomcat`中，也可以直接使用`java`的命令运行。
```xml
            
            <!-- maven打包插件 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <configuration>
                    <archive>
                        <!-- 生成MANIFEST.MF的设置 -->
                        <manifest>
                            <!-- jar启动入口类-->
                            <mainClass>com.kevin.hello.ApplicationStar</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
            <!-- spring boot打包插件 -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>1.4.2.RELEASE</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>repackage</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

         <resources>
            <!-- 打包时将jsp文件拷贝到META-INF目录下-->
            <resource>
                <!-- 指定resources插件处理哪个目录下的资源文件 -->
                <directory>src/main/webapp</directory>
                <!--注意此次必须要放在此目录下才能被访问到-->
                <targetPath>META-INF/resources</targetPath>
                <includes>
                    <include>**/**</include>
                </includes>
            </resource>
            <resource>
                <directory>src/main/resources</directory>
                <includes>
                    <include>**/**</include>
                </includes>
                <filtering>false</filtering>
            </resource>
        </resources>

```
3、使用`thymeleaf`模板就比较简单了，修改`POM`文件，添加`spring-boot-starter-thymeleaf`依赖，并注释掉`spring-boot-starter-tomcat`，然后执行`Maven`打包命令即可打包，仍然使用命令行`java -jar yourproject.war`来启动应用。
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


        <!--Spring Boot tomcat-->
        <!--<dependency>-->
            <!--<groupId>org.springframework.boot</groupId>-->
            <!--<artifactId>spring-boot-starter-tomcat</artifactId>-->
            <!--<scope>provided</scope>-->
        <!--</dependency>-->

```

## 如何将普通Spring项目升级为Spring Boot项目
老铁，我有一个`Spring`的项目，怎么才能升级为`Spring Boot`。既然`Spring Boot`这么好，那自然是要升级滴，不过面对一个庞大的项目，从哪里入手呢。
### 升级哪些模块
一般我们项目都是由很多模块构成的，比如数据访问、业务逻辑处理、前端表现等，在互不影响的前提下，可以先升级部分模块。比如，我们可以先升级前端表现模块，一般是基于`Spring MVC`构建，也比较容易切换，如果条件允许，当然最好整体升级。
### 从哪里入手
首先，`Spring Boot`建议使用的配置方式是`JavaConfig`的方式，这种方式更有利于我们理解自己的配置，相对于`XML`的方式书写起来也比较方便，使我们更能集中精力在代码上，而不是在代码和`XML`文件之间来回切换。如果你原来的应用是基于`JavaConfig`的配置，那么恭喜你，已经完成了`50%`的工作，剩下的就是引入`Spring Boot`依赖和配置启动相关的工作了。如果你依然使用`XML`方式的配置你的应用，请首先考虑将`XML`配置转换为`javaconfig`的配置，转换好之后，在项目中引入`Spring Boot`依赖，配置相应的启动方式，就可以完成转换了。当然也可以选择不转换，`Spring Boot`也提供导入`XML`配置的方法，只是这样略显麻烦一些。
经过以上步骤，参照`Spring Boot`官方手册和本例程，相信你也可以构建自己的`Spring Boot`应用了。

## 学习建议
`Spring Boot`确实给我们带来了极大的便利性，从开发到部署都为我们提供了很好的支持。正如`Spring`的出现让我们开发企业级`Java`应用变的更加方便了一样，`Spring Boot`的出现让我们开发`Spring`应用变的方便了。但是，在我们享受这方便的同时，也要去探究这方便的背后，`Spring`都为我们做了哪些事情。最典型的就是自动配置了，都包含哪些自动配置，自动配置是如何实现，如何不使用自动配置，如何添加自定义配置等，这些问题，我们都要去探究和学习，这样才能更加自如的运用。还有一点，在学习`Spring Boot`之前，一定要有足够的基础知识储备，也就是说，要熟悉`Spring`的架构体系的一些应用和原理，这样学习`Spring Boot`才不会感到吃力。另外一点就是立足官网，`Spring Boot`的官方网站给出了详尽的指导手册和示例，可以说是学习的第一手资料，如果阅读困难的话可以借助翻译软件等,也可以参照书籍和网上的其他资料。对于`Spring Boot`的初探，我们就介绍到这里，后续文章会继续分析`Spring Boot`的一些原理，欢迎持续关注。

[**示例代码**](https://github.com/yanglukuan/SpringBoot)


## 参考
https://spring.io/guides/gs/spring-boot/
http://tengj.top/2017/02/26/springboot1/
http://www.scienjus.com/spring-boot-summary/
https://my.oschina.net/wenjinglian/blog/1506808



 