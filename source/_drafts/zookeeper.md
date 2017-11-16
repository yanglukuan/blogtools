---
title: zookeeper
tags:
---

### zookeeper

Zookeeper是hadoop的一个子项目，Zookeeper分布式应用程序协调服务，主要用来解决分布式集群中应用系统的一致性问题，它能提供基于类似于文件系统的目录节点树方式的数据存储，但是 Zookeeper 并不是用来专门存储数据的，它的作用主要是用来维护和监控你存储的数据的状态变化。通过监控这些数据状态的变化，从而可以达到基于数据的集群管理.

解决分布式数据一致性问题的开源实现，方便了依赖 Zookeeper 的应用实现 数据发布 / 订阅、负载均衡、服务注册与发现、分布式协调、事件通知、集群管理、Leader 选举、 分布式锁和队列 等功能

Zookeeper 从设计模式角度来看，是一个基于观察者模式设计的分布式服务管理框架，它负责存储和管理大家都关心的数据，然后接受观察者的注册，一旦这些数据的状态发生变化，Zookeeper 就将负责通知已经在 Zookeeper 上注册的那些观察者做出相应的反应，从而实现集群中类似 Master/Slave 管理模式


### 应用场景
统一命名服务（服务化框架中的服务注册、发现机制）
配置管理
集群管理
共享锁
队列管理

### 参考
https://yuzhouwan.com/posts/31915/
https://www.ibm.com/developerworks/cn/opensource/os-cn-zookeeper/
http://blog.csdn.net/caisini_vc/article/details/48368917
《zookeeper分布式过程协同技术详解》
