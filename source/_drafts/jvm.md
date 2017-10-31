---
title: jvm
tags:
---

## java技术体系
jvm jdk jre
java语言
java规范

## jvm体系
jvm java虚拟机
虚拟机规范、虚拟机实现
sun/oracle hotspot
ibm j9
BEA JRocki
核心
类加载+内存管理+垃圾收集+执行引擎
多语言 java、Groovy、JRuby、Scala
### 内存模型
内存运行时数据区
线程共享 堆区、方法区
线程私有 虚拟机栈、本地方法栈、程序计数器
堆区：
方法区：
虚拟栈：
本地方法栈：
程序计数器：
垃圾收集主要的区：堆区
### 垃圾收集
jvm 自动内存管理 
gc堆
分代收集 
可达性分析
新生代 Eden区、Survivor0、Survivor1 区
新对象分配在eden区,大对象分配在老年代。第一次younggc，清空eden区死亡对象，将eden区存活对象复制到Survivor0区，
再发生younggc，清空eden区和Survivor0区已经死亡的对象，将两个区存活的对象复制到Survivor1,始终保持有一个Survivor区是空的。
老年代
younggc fullgc
gc算法 新生代复制算法，对象较小,且收集效果较理想，存活对象比较少，所以可以复制。老年代标记清除或者标记整理，对象较大且收集效果不理想。

### 内存监控
各种工具
内存溢出、泄露

### 类加载
加载 初始化  执行
编译执行（jit）、解释执行
装载--链接（加载--验证--准备--解析）--初始化--执行

双亲委派
自底向上校验类是否加载
自顶像下尝试加载
加载器
bootstrap classloader
extention classloader
app classloader
custom classloader

类执行
JVM通过栈来执行加载到内存中的class字节码。
线程创建后产生程序计数器和栈帧，每个栈帧
对应每个方法的每次调用。
栈帧由局部变量区和操作数栈组成，局部变量
区存放方法中的局部变量和参数；操作数栈存
放方法执行过程的中间结果。
本地方法栈
栈帧 方法执行  出栈入栈