---
layout: _drafts
title: Java集合框架之LinkedHashMap详解
date: 2017-09-04 11:27:06
tags: [Java,集合,LinkedHashMap]
categories: java
---

## LinkedHashMap
在上一篇文章{% post_link  java/HashMap详解 %}中,我们介绍了Java集合框架的一个类HashMap。通过源码分析,我们了解了HashMap的存储结构和内部实现,如果还不清楚,那就再回顾下,因为我们今天要介绍的LinkedHashMap是HashMap的子类,很多方法和属性都直接继承于HashMap。
<center>![Map接口类图](/images/hashmap/javacollections.png)</center><center>***Map接口类图***</center>
## 与HashMap异同
从上面的类图中我们可以看到,LinkedHashMap直接继承自HashMap,所以LinkedHashMap拥有HashMap的大部分特性,最多只允许一个key为null,可以有多个value为null。一些主要的方法和属性也直接继承自HashMap,对其中某系方法进行了重写。LinkedHashMap与HashMap最大的不同在于LinkedHashMap保持了元素的有序性,即遍历`LinkedHashMap`的时候，得到的元素的顺序与添加元素的顺序是相同的,可以按照插入序 (insertion-order) 或访问序 (access-order) 来对哈希表中的元素进行遍历。
>所谓插入顺序，就是 Entry 被添加到 Map 中的顺序，更新一个 Key 关联的 Value 并不会对插入顺序造成影响；而访问顺序则是对所有 Entry 按照最近访问 (least-recently) 到最远访问 (most-recently) 进行排序，读写都会影响到访问顺序，但是对迭代器 (entrySet(), keySet(), values()) 的访问不会影响到访问顺序。默认是按插入顺序排序，如果指定按访问顺序排序，那么调用get方法后，会将这次访问的元素移至链表尾部，不断访问可以形成按访问顺序排序的链表。

## 顺序存储原理

### 存储架构
数据结构 循环双向链表

因此LinkedHashMap的Entry节点具有三个指针域，next指针维护Hash桶中冲突key的链表，before和after维护双向循环链表 



### 存储过程
 重写newNode方法


重写父类方法
 Node<K,V> newNode(int hash, K key, V value, Node<K,V> e) {}


## 遍历

## 总结



## 参考

http://blog.jrwang.me/2016/java-collections-linkedhashmap/
http://www.cnblogs.com/chenpi/p/5294077.html
http://blog.csdn.net/qq_24692041/article/details/64904806