---
title: Servlet和JSP
date: 2017/8/22 13:07:52 
tags: [servlet,jsp]
categories: java
---

在我们面试的时候一般会被问到，"Servlet和JSP有什么区别和联系？"。那么今天我们就来回答一下这个问题，顺便复习一下Servlet和JSP的一些相关知识。

---

## JSP
### 出现
>JSP（全称JavaServer Pages）是由Sun Microsystems公司倡导和许多公司参与共同创建的一种使软件开发者可以响应客户端请求，而动态生成HTML、XML或其他格式文档的Web网页的技术标准。JSP技术是以Java语言作为脚本语言的，JSP网页为整个服务器端的Java库单元提供了一个接口来服务于HTTP的应用程序。从架构上说，JSP可以被看作是从Servlets高级提炼而作为JAVA Servlet 2.1 API的扩展而应用。Servlets和JSP最早都是由Sun Microsystems（太阳公司）开发的。

随着大量的B/S架构程序开发出来以后，人们发现Servlet类的编写是非常繁琐的，主要集中在几个问题上：首先有大量冗余代码，这些代码在每个servlet类中都是一模一样或者基本近似的，其次是开发Servlet的程序员很少有精通美工的，导致使用Servlet开发无法方便的做到各种页面效果和丰富多彩的风格，这个时候sun借鉴了微软的ASP方式，正式提出JSP（也就是Servlet 1.1），JSP推出后，JAVA程序员也能象ASP的程序员那样将服务端代码添加在已经由美工设计好的静态页面上，经过一个JSP容器对JSP文件进行自动解析并转换成Servlet类来交给WEB服务器运行。这么一来，极大的提高了工作效率。
### 工作方式

当客户端浏览器向服务器请求一个 JSP 页面时，服务器收到该请求后，首先检查所请求的这个JSP 文件内容 ( 代码 ) 是否已经被更新，或者是否是 JSP 文件创建后的第一次被访问，如果是，那么，这个 JSP 文件就会在服务器端的 JSP 引擎作用下转化为一个 Servlet 类的 Java 源代码文件。紧接着，这个 Servlet 类会在 Java 编译器的作用下被编译成一个字节码文件，并装载到 jvm 解释执行。剩下的就等同于 Servlet 的处理过程了。如果被请求的 JSP 文件内容 ( 代码 ) 没有被修改，那么它的处理过程也等同于一个 Servlet 的处理过程。即直接由服务器检索出与之对应的Servlet 实例来处理。一种是预编译，也就是当Tomcat启动的时候，所有部署的应用中的jsp都会进行编译，另外一种是当第一次访问的时候对该jsp进行编译；无论是哪一种，JSPCompilationContext都是编译的上下文，JSPServletWrapper通过JSPCompilationContext进行加载jsp源文件，然后调用对应的Compiler进行编译为servlet的class，并通过JasperLoader进行加载。

## Servlet
### 定义
Servlet（Server Applet），全称Java Servlet，未有中文译文。是用Java编写的服务器端程序。其主要功能在于交互式地浏览和修改数据，生成动态Web内容。狭义的Servlet是指Java语言实现的一个接口，广义的Servlet是指任何实现了这个Servlet接口的类，一般情况下，人们将Servlet理解为后者。Servlet运行于支持Java的应用服务器中。从实现上讲，Servlet可以响应任何类型的请求，但绝大多数情况下Servlet只用来扩展基于HTTP协议的Web服务器。最早支持Servlet标准的是JavaSoft的Java Web Server。此后，一些其它的基于Java的Web服务器开始支持标准的Servlet。

### Servlet规范
[Servlet规范](http://ognvcf5x6.bkt.clouddn.com/bbs_image/Servlet3.1%E8%A7%84%E8%8C%83.pdf)

### Servlet容器
Servlet容器是web server或application server的一部分，提供基于请求/响应发送模型的网络服务，解码基于MIME的请求，并且格式化基于MIME的响应。Servlet 容器也包含了管理Servlet生命周期。Servlet容器可以嵌入到宿主的web server中，或者通过Web Server的本地扩展API单独作为附加组件安装。Servelt容器也可能内嵌或安装到包含web功能的application server中。所有Servlet容器必须支持基于HTTP协议的请求/响应模型，比如像基于HTTPS（HTTP over SSL）协议的请求/应答模型可以选择性的支持。容器必须实现的HTTP协议版本包含HTTP/1.0 和 HTTP/1.1。因为容器或许支持RFC2616 (HTTP/1.1)描述的缓存机制，缓存机制可能在将客户端请求交给Servlet处理之前修改它们，也可能在将Servlet生成的响应发送给客户端之前修改它们，或者可能根据RFC2616规范直接对请求作出响应而不交给Servlet进行处理。Servlet容器应该使Servlet执行在一个安全限制的环境中。在Java平台标准版（J2SE, v.1.3 或更高） 或者 Java平台企业版(Java EE, v.1.3 或更高) 的环境下，这些限制应该被放置在Java平台定义的安全许可架构中。比如，高端的application server为了保证容器的其他组件不受到负面影响可能会限制Thread对象的创建。Java SE 6是构建Servlet容器最低的Java平台版本。

### Servlet生命周期
1、在servlet容器或web server启动时，对servlet进行实例化，此时调用servlet的构造方法；servlet实例化后，调用该servlet实例的init方法，对servlet进行一些初始化处理，处理完成后，将该servlet注入到servlet容器中;
2、当client向web server或servlet容器请求servlet时，web server或servlet容器首先会根据请求的servlet名称去servlet容器中找对应的servlet，如果servlet不存在该名称对应的servlet，则向client响应请求不存在等信息，否则进行步骤3；
3、如果请求的servlet存在于servlet容器，则调用servlet的service方法，生成动态资源，响应给client; （记住，整个过程该servlet只有一个实例，即单例）；
4、当web server退出或servlet容器销毁时，调用servlet的destroy方法，最后唯一的sevlet实例将会被GC。
在整个Servlet的生命周期过程中，创建Servlet实例、调用实例的init()和destroy()方法都只进行一次，当初始化完成后，Servlet容器会将该实例保存在内存中，通过调用它的service()方法，为接收到的请求服务。servlet只会实例化一次，servlet容器启动时或者第一次处理请求时之后所有请求都只共享这一个实例，每个请求对应一个线程去处理，线程池方式处理JSP/Servlet容器默认是采用单实例多线程(这是造成线程安全的主因)方式处理多个请求的。

### 线程安全问题
由于servlet只会实例化一次，整个生命周期内所有的请求，都由这一个实例来完成，每个请求对应一个线程去处理，很容易造成线程安全性问题。
如果service()方法没有访问Servlet的成员变量也没有访问全局的资源比如静态变量、文件、数据库连接等，而是只使用了当前线程自己的资源，比如非指向全局资源的临时变量、request和response对象等。该方法本身就是线程安全的，不必进行任何的同步控制。
如果service()方法访问了Servlet的成员变量，但是对该变量的操作是只读操作，该方法本身就是线程安全的，不必进行任何的同步控制。
如果service()方法访问了Servlet的成员变量，并且对该变量的操作既有读又有写，通常需要加上同步控制语句。
如果service()方法访问了全局的静态变量，如果同一时刻系统中也可能有其它线程访问该静态变量，如果既有读也有写的操作，通常需要加上同步控制语句。
如果service()方法访问了全局的资源，比如文件、数据库连接等，通常需要加上同步控制语句。

### JSP本质上就是servlet
Java服务器页面（JSP）是HttpServlet的扩展。由于HttpServlet大多是用来响应HTTP请求，并返回Web页面（例如HTML、XML），所以不可避免地，在编写servlet时会涉及大量的HTML内容，这给servlet的书写效率和可读性带来很大障碍，JSP便是在这个基础上产生的。其功能是使用HTML的书写格式，在适当的地方加入Java代码片段，将程序员从复杂的HTML中解放出来，更专注于servlet本身的内容。JSP在首次被访问的时候被应用服务器转换为servlet，在以后的运行中，容器直接调用这个servlet，而不再访问JSP页面。
所以说JSP本质上就是servlet,在执行的时候最终会被编译成servlet。JSP加入了各种Web标签，使其能更加方便的编写动态Web应用程序。JSP 由 HTML 代码和 JSP 标签构成，可以方便地编写动态网页,Servlet完全是JAVA程序代码构成擅长于流程控制和事务处理.因此在实际应用中采用 Servlet 来控制业务流程,而采用 JSP 来生成动态网页.Servlet和JSP两者分工协作，Servlet侧重于解决运算和业务逻辑问题，JSP则侧重于解决展示问题。

## 容器和server
### web server 
只要Web上的Server都叫Web Server，但是大家分工不同，解决的问题也不同，所以根据Web Server提供的功能，每个Web Server的名字也会不一样。按功能分类，Web Server可以分为：Http server和Application server。
### Http server
HTTP Server本质上也是一种应用程序——它通常运行在服务器之上，绑定服务器的IP地址并监听某一个tcp端口来接收并处理HTTP请求，这样客户端（一般来说是IE, Firefox，Chrome这样的浏览器）就能够通过HTTP协议来获取服务器上的网页（HTML格式）、文档（PDF格式）、音频（MP4格式）、视频（MOV格式）等等资源。HTTP Server中经常使用的是Apache、Nginx两种，HTTP Server主要用来做静态内容服务、代理服务器、负载均衡等。直面外来请求转发给后面的应用服务（Tomcat，django什么的）。
### Application Server
Application Server 是一个应用执行的服务器。它首先需要支持开发语言的 Runtime（对于 Tomcat 来说，就是 Java），保证应用能够在应用服务器上正常运行。其次，需要支持应用相关的规范，例如类库、安全方面的特性。与HTTP Server相比，Application Server能够动态的生成资源并返回到客户端。

>Application server可以作为servlet容器，tomcat、jeety等都是Application server都可以作为servlet容器。对于Tomcat来说，就是需要提供 JSP/Sevlet 运行需要的标准类库、Interface 等。为了方便，应用服务器往往也会集成 HTTP Server 的功能，但是不如专业的 HTTP Server 那么强大，所以Application Server往往是运行在 HTTP Server 的背后，执行应用，将动态的内容转化为静态的内容之后，通过 HTTP Server 分发到客户端。
> 
在实际运行的时候Java Servlet与Web服务器会融为一体，如同一个程序一样运行在同一个Java虚拟机（JVM）当中。与CGI不同的是，Servlet对每个请求都是单独启动一个线程，而不是进程。这种处理方式大幅度地降低了系统里的进程数量，提高了系统的并发处理能力。另外因为Java Servlet是运行在虚拟机之上的，也就解决了跨平台问题。如果没有Servlet的出现，也就没有互联网的今天。


## 参考
https://my.oschina.net/xianggao/blog/670681
http://www.hollischuang.com/archives/849
http://developer.51cto.com/art/201012/237827.htm
http://www.10tiao.com/html/308/201609/2650076215/1.html
