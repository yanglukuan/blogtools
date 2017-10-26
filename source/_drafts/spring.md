---
title: spring
tags:
---


## 概述
Spring的目标在于让Java EE的开发变得更容易，这就意味着Spring框架的使用也应该是容易的。对于开发人员而言，易用性是第一位的。EJB模型为Java EE开发引入了过度的复杂性，这个开发模型对Java EE的开发并不友好。在EJB模式中，应用开发人员需要编写EJB组件，而这种组件需要满足EJB容器的规范，才能够运行在EJB容器中，从而获取事务管理、生命周期管理这些组件开发的基本服务。
在Spring中，Spring IoC提供了一个基本的JavaBean容器，通过IoC模式管理依赖关系，并通过依赖注入和AOP切面增强了为JavaBean这样的POJO对象赋予事务管理、生命周期管理等基本功能。也就是说Spring把EJB组件还原成了POJO对象或者JavaBean对象，降低了应用开发对传统J2EE技术规范的依赖。


降低侵入性 解耦
核心
IOC、AOP

## ioc
inversion of control  依赖反转               
Dependency Injection  依赖注入
在面向对象编程领域中，依赖反转原则（Dependency inversion principle，DIP）是指一种特定的解耦（传统的依赖关系创建在高层次上，而具体的策略设置则应用在低层次的模块上）形式，使得高层次的模块不依赖于低层次的模块的实现细节，依赖关系被颠倒（反转），从而使得低层次模块依赖于高层次模块的需求抽象。
该原则规定：
高层次的模块不应该依赖于低层次的模块，两者都应该依赖于抽象接口。
抽象接口不应该依赖于具体实现。而具体实现则应该依赖于抽象接口。
该原则颠倒了一部分人对于面向对象设计的认识方式。如高层次和低层次对象都应该依赖于相同的抽象接口

如果合作对象的引用或依赖关系的管理由具体对象来完成，会导致代码的高度耦合和可测试性的降低，这对复杂的面向对象系统的设计是非常不利的。

IoC不是一种技术，只是一种思想，一个重要的面向对象编程的法则，它能指导我们如何设计出松耦合、更优良的程
序。传统应用程序都是由我们在类内部主动创建依赖对象，从而导致类与类之间高耦合，难于测试；有了IoC容器后，
把创建和查找依赖对象的控制权交给了容器，由容器进行注入组合对象，所以对象与对象之间是松散耦合，这样也方便
测试，利于功能复用，更重要的是使得程序的整个体系结构变得非常灵活。


IoC容器就是具有依赖注入功能的容器，IoC容器负责实例化、定位、配置应用程序中的对象及建立这些对象间的依赖。
应用程序无需直接在代码中new相关的对象，应用程序由IoC容器进行组装。在Spring中BeanFactory是IoC容器的实际
代表者。


Spring IoC容器通过读取配置文件中的配置元数
据，通过元数据对应用中的各个对象进行实例化及装配。一般使用基于xml配置文件进行配置元数据，而且Spring与配
置文件完全解耦的，可以使用其他任何可能的方式进行配置元数据，比如注解、基于java文件的、基于属性文件的配置
都可以。

### IOC初始化

第一：Resource读取配置，第二：将配置文件的内容转换为BeanDefinition，BeanDefinition实际上就是POJO对象在IoC容器中的抽象，通过这个BeanDefinition定义的数据结构，使IoC容器能够方便地对POJO对象也就是Bean进行管理。第三：向IoC容器注册这些BeanDefinition，在IoC容器内部将BeanDefinition注入到一个HashMap中去，IoC容器就是通过这个HashMap来持有这些BeanDefinition数据的。

由前面介绍的refresh（）方法来启动的，这个方法标志着IoC容器的正式启动。具体来说，这个启动包括BeanDefinition的Resouce定位、载入和注册三个基本过程。

IoC容器的Bean Reader读取并解析配置文件，根据定义生成BeanDefinition配置元
数据对象，IoC容器根据BeanDefinition进行实例化、配置及组装Bean。

### 依赖注入

依赖注入一般发生在应用第一次通过getBean向容器索取Bean的时候

### IOC工作方式

## aop
Aspect Oriented Programming
可以通过在编译期间、装载期间或运行期间实现在不修改源代码的情况下给程序动态添加功能的一种技术

## spring mvc
DispatcherServlet通过继承FrameworkServlet和HttpServletBean而继承了HttpServlet，通过使用Servlet API来对HTTP请求进行响应，成为Spring MVC的前端处理器，同时成为MVC模块与Web容器集成的处理前端。

### 初始化
在web容器中初始化IOC容器
contextConfigLocation配置文件路径，根据配置文件创建IOC容器。
ContextLoaderListener建立根IOC容器-->建立web环境的IOC容器，双亲为根容器，(DispatcherServlet持有)-->初始化spring mvc框架(initHandlerMappings、initHandlerAdapters等)-->处理请求

### 处理请求
请求到达web容器 根据路径映射到DispatcherServlet
前端控制器分发请求 DispatcherServlet
HandlerMapping 进行请求处理映射 映射为对应的Controller HandlerMapping将其包装为HandlerExecutionChain
HandlerAdapter，HandlerAdapter将HandlerExecutionChain中的处理器（Controller）适配为HandlerAdapter
Controller处理器功能处理方法的调用，HandlerAdapter将会调用处理器的handleRequest方法进行功能处理，该处理方法返回一个ModelAndView给DispatcherServlet
ViewResolver，InternalResourceViewResolver使用JstlView，具体视图页面在/WEB-INF/jsp/hello.jsp
JstlView（/WEB-INF/jsp/hello.jsp）——>渲染，将在处理器传入的模型数据(message=HelloWorld！)在视图
中展示出来；
返回控制权给DispatcherServlet，由DispatcherServlet返回响应给用户，到此一个流程结束。


#### mvc处理核心 
DispatcherServlet.doDispatch
ha.handle
invocableMethod.invokeAndHandle()
Controller中业务逻辑代码。。。
if (asyncManager.isConcurrentHandlingStarted()) {}


### spring2.5之前  
实现Controller接口 手动配置HandlerMapping和HandlerAdapter

### spring2.5 
注解支持 @Controller等

### spring3.0 
RESTful架构风格支持  通过@PathVariable注解和一些其他特性支持
<mvc:annotation-driven>：
自动注册基于注解风格的处理器需要的DefaultAnnotationHandlerMapping、
AnnotationMethodHandlerAdapter
支持Spring3的ConversionService自动注册
支持JSR-303验证框架的自动探测并注册（只需把JSR-303实现放置到classpath）
自动注册相应的HttpMessageConverter（用于支持@RequestBody 和 @ResponseBody）（如XML输入输出转
换器（只需将JAXP实现放置到classpath）、JSON输入输出转换器（只需将Jackson实现放置到classpath））等。


### spring3.1
@EnableWebMvc：用于在基于Java类定义Bean配置中开启MVC支持，和XML中的<mvc:annotation-driven>功能一
样；
新的@Contoller和@RequestMapping注解支持类：处理器映射RequestMappingHandlerMapping 和 处理器适配器
RequestMappingHandlerAdapter组合来代替Spring2.5开始的处理器映射DefaultAnnotationHandlerMapping和处
理器适配器AnnotationMethodHandlerAdapter