---
title: rabbitmq
tags:
---

### 消息队列
消息队列（英语：Message queue）是一种进程间通信或同一进程的不同线程间的通信方式，软件的贮列用来处理一系列的输入，通常是来自用户。消息队列提供了异步的通信协议，每一个贮列中的纪录包含详细说明的数据，包含发生的时间，输入设备的种类，以及特定的输入参数，也就是说：消息的发送者和接收者不需要同时与消息队列交互。消息会保存在队列中，直到接收者取回它。
“消息队列”是在消息的传输过程中保存消息的容器。消息队列管理器在将消息从它的源中继到它的目标时充当中间人。队列的主要目的是提供路由并保证消息的传递；如果发送消息时接收者不可用，消息队列会保留消息，直到可以成功地传递它。
消息队列中间件是分布式系统中重要的组件，主要解决应用耦合、异步消息、流量削锋等问题。实现高性能、高可用、可伸缩和最终一致性架构。
### 使用场景
异步处理
系统间解耦
流量削峰
日志处理
应用通信

### 常用消息队列
ActiveMQ，RabbitMQ，ZeroMQ，Kafka，MetaMQ，RocketMQ

### JMS
JMS（JAVA Message Service,java消息服务）API是一个消息服务的标准/规范，允许应用程序组件基于JavaEE平台创建、发送、接收和读取消息。它使分布式通信耦合度更低，消息服务更加可靠以及异步性。

JMS由以下元素组成。
JMS提供者
连接面向消息中间件的，JMS接口的一个实现。提供者可以是Java平台的JMS实现，也可以是非Java平台的面向消息中间件的适配器。
JMS客户
生产或消费消息的基于Java的应用程序或对象。
JMS生产者
创建并发送消息的JMS客户。
JMS消费者
接收消息的JMS客户。
JMS消息
包括可以在JMS客户之间传递的数据的对象
JMS队列
一个容纳那些被发送的等待阅读的消息的区域。队列暗示，这些消息将按照顺序发送。一旦一个消息被阅读，该消息将被从队列中移走。
JMS主题
一种支持发送消息给多个订阅者的机制。

消息模型
Point-to-Point(P2P)
Publish/Subscribe(Pub/Sub)

实现
要使用Java消息服务，必须要有一个JMS提供者，管理会话和队列
Apache ActiveMQ
Kafka

### AMQP
AMQP（Advanced Message Queuing Protocol 高级消息队列协议）是一个网络协议。它支持符合要求的客户端应用（application）和消息中间件代理（messaging middleware broker）之间进行通信。


### rabbit
AMQP信道
AMQP消息路由：交换器、队列、绑定
生产者把消息发送到交换器，消息最终达到队列，，并被消费者接收。

#### 集群
http://www.cnblogs.com/knowledgesea/p/6535766.html
http://chyufly.github.io/blog/2016/04/10/rabbitmq-cluster/


### 参考
https://tech.meituan.com/mq-design.html
http://www.cnblogs.com/itfly8/p/5156155.html
http://huangxubo.me/blog/jms/jms-jms/#4-p2p
http://www.cnblogs.com/chenpi/p/5559349.html