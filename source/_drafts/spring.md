---
title: spring
tags:
---


## 概述
Spring的目标在于让Java EE的开发变得更容易，这就意味着Spring框架的使用也应该是容易的。对于开发人员而言，易用性是第一位的。EJB模型为Java EE开发引入了过度的复杂性，这个开发模型对Java EE的开发并不友好。在EJB模式中，应用开发人员需要编写EJB组件，而这种组件需要满足EJB容器的规范，才能够运行在EJB容器中，从而获取事务管理、生命周期管理这些组件开发的基本服务。

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
## aop
Aspect Oriented Programming
可以通过在编译期间、装载期间或运行期间实现在不修改源代码的情况下给程序动态添加功能的一种技术

## spring mvc
DispatcherServlet通过继承FrameworkServlet和HttpServletBean而继承了HttpServlet，通过使用Servlet API来对HTTP请求进行响应，成为Spring MVC的前端处理器，同时成为MVC模块与Web容器集成的处理前端。

### 初始化
在web容器中初始化IOC容器

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