---
title: servlet和JSP
date: 2017/8/22 13:07:52 
tags: servlet
categories: java
---

servlet && JSP

JSP本质上就是servlet,因为在执行的时候最终会被编译成servlet。JSP加入了各种Web标签，使其能更加方便的编写动态Web应用程序。JSP 由 HTML 代码和 JSP 标签构成，可以方便地编写动态网页,Servlet 完全是 JAVA 程序代码构成擅长于流程控制和事务处理.因此在实际应用中采用 Servlet 来控制业务流程,而采用 JSP 来生成动态网页.Servlet和JSP两者分工协作，Servlet侧重于解决运算和业务逻辑问题，JSP则侧重于解决展示问题。

---

转译和编译
tomcat 启动时 
由JSP生成java文件
jsp==>servlet.java
将生成的java文件编译为class文件
servlet.java==>servlet.class

SPCompilationContext：一种是预编译，也就是当Tomcat启动的时候，所有部署的应用中的jsp都会进行编译，另外一种是当第一次访问的时候对该jsp进行编译；无论是哪一种，JSPCompilationContext都是编译的上下文，JSPServletWrapper通过JSPCompilationContext进行加载jsp源文件，然后调用对应的Compiler进行编译为servlet的class，并通过JasperLoader进行加载；

编译的过程包括三个步骤：
解析JSP文件。
将JSP文件转为servlet。
编译servlet。

当浏览器请求JSP页面时，JSP引擎会首先去检查是否需要编译这个文件。如果这个文件没有被编译过，或者在上次编译后被更改过，则编译这个JSP文件。


servlet只会实例化一次，servlet容器启动时或者第一次处理请求时
之后所有请求都只共享这一个实例，每个请求对应一个线程去处理，线程池方式处理
JSP/Servlet容器默认是采用单实例多线程(这是造成线程安全的主因)方式处理多个请求的


在整个Servlet的生命周期过程中，创建Servlet实例、调用实例的init()和destroy()方法都只进行一次，当初始化完成后，Servlet容器会将该实例保存在内存中，通过调用它的service()方法，为接收到的请求服务。

---
线程安全问题

如果service()方法没有访问Servlet的成员变量也没有访问全局的资源比如静态变量、文件、数据库连接等，而是只使用了当前线程自己的资源，比如非指向全局资源的临时变量、request和response对象等。该方法本身就是线程安全的，不必进行任何的同步控制。

如果service()方法访问了Servlet的成员变量，但是对该变量的操作是只读操作，该方法本身就是线程安全的，不必进行任何的同步控制。

如果service()方法访问了Servlet的成员变量，并且对该变量的操作既有读又有写，通常需要加上同步控制语句。

如果service()方法访问了全局的静态变量，如果同一时刻系统中也可能有其它线程访问该静态变量，如果既有读也有写的操作，通常需要加上同步控制语句。

如果service()方法访问了全局的资源，比如文件、数据库连接等，通常需要加上同步控制语句。

---
ServletContext、HttpSession是线程安全的；ServletRequest是非线程安全的
Servlet的init()方法是工作在单线程的环境下
避免使用实例变量
加锁
使用线程安全的集合类



http://www.hollischuang.com/archives/849

http://developer.51cto.com/art/201012/237827.htm

http://www.10tiao.com/html/308/201609/2650076215/1.html
http://www.10tiao.com/html/308/201609/2650076200/1.html
http://www.10tiao.com/html/308/201609/2650076233/1.html
http://www.10tiao.com/html/308/201609/2650076235/1.html



各种容器和server

Web Server 

Http server  静态内容

Application server  动态生成内容


Application server可以作为servlet容器 
tomcat、jeety等都是Application server都可以作为servlet容器


对于 Tomcat 来说，就是需要提供 JSP/Sevlet 运行需要的标准类库、Interface 等。为了方便，应用服务器往往也会集成 HTTP Server 的功能，但是不如专业的 HTTP Server 那么强大，所以Application Server往往是运行在 HTTP Server 的背后，执行应用，将动态的内容转化为静态的内容之后，通过 HTTP Server 分发到客户端。 


Tomcat属于Servlet容器，其工作模式也分为上述3种，所以Tomcat既可被用作独立运行的Servlet引擎（便于开发和调试），又可作为一个需要增强功能的Web服务器（如当前的Apache、IIS和Netscape服务器）插件。在配置Tomcat之前，就需要确定采用哪种工作模式，工作模式（1）比较简单，直接安装Tomcat即可，工作模式（2）和（3）有些复杂，除了安装Tomcat、Web服务器之外，还需要安装连接两者的中间连接件。



在实际运行的时候Java Servlet与Web服务器会融为一体，如同一个程序一样运行在同一个Java虚拟机（JVM）当中。与CGI不同的是，Servlet对每个请求都是单独启动一个线程，而不是进程。这种处理方式大幅度地降低了系统里的进程数量，提高了系统的并发处理能力。另外因为Java Servlet是运行在虚拟机之上的，也就解决了跨平台问题。如果没有Servlet的出现，也就没有互联网的今天。

https://my.oschina.net/xianggao/blog/670681