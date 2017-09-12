---
title: Java集合框架总结
date: 2017-09-12 13:30:47 
tags: [Java,集合框架]
categories: java
---

## 集合框架

### 系列文章
 - {% post_link  java/HashMap详解 %}
 - {% post_link  java/Java集合框架之LinkedHashMap详解 %}
 - {% post_link  java/Java集合框架之TreeMap详解 %}
 - {% post_link  java/Java集合框架之ArrayList详解 %}
 - {% post_link  java/Java集合框架之LinkedList详解 %}
 - {% post_link  java/Java集合框架之Set接口详解 %}

### 类图结构
在前面的系列文章中，我们主要分析了java的集合框架。Java集合框架位于Java.util包下，包含了很多常用的数据结构，如数组、链表、栈、队列、集合、哈希表等，下面我们结合类图再来回顾一下。

<center>![Map接口类图](/images/hashmap/javacollections.png)</center><center>***Map接口类图***</center>
<center>![Collection接口类图](/images/arrayList/Collections.png)</center><center>***Collection接口类图***</center>

`Java`的集合类主要由两个接口派生而出：`Collection`和`Map`，`Collection`和`Map`是`Java`集合框架的根接口，这两个接口又包含了一些接口或实现类。`Set`和`List`接口是`Collection`接口派生的两个子接口，`Queue`是`Java`提供的队列实现，类似于`List`。`Map`是一个映射接口，其中的每个元素都是一个`key-value`键值对，抽象类`AbstractMap`通过适配器模式实现了`Map`接口中的大部分函数，`TreeMap`、`HashMap`、`WeakHashMap`等实现类都通过继承`AbstractMap`来实现。另外，不常用的`HashTable`直接实现了`Map`接口。对于`Set`、`List`和`Map`三种集合，最常用的实现类分别是`HashSet`、`ArrayList`和`HashMap`三个实现类。

## 总结

### Map 接口

`Map`是一个映射接口，其中的每个元素都是一个`key-value`键值对，抽象类`AbstractMap`通过适配器模式实现了`Map`接口中的大部分函数，`HashMap`、`LinkedHashMap`、 `TreeMap`等实现类都通过继承`AbstractMap`实现。

#### HashMap

`HashMap`采用了`hash`表数据结构来实现，其内部维护的数组+单链表+红黑树的结构实现了基于哈希表的存储结构。在`key`未发生冲突的情况下，搜索时间复杂度为`O(1)`，可以快速定位元素。存储时，根据`key`的哈希值决定元素存放的位置，采用链地址法解决`hash`冲突，当单链表长度超过`8`时，单链表转为红黑树。
1.`HashMap`是不保证存取的顺序性的，也就是说遍历`HashMap`的时候，得到的元素的顺序与添加元素的顺序是不同的。
2.`HashMap`的`key`不允许重复，至多允许一个`key`为`null`，任意`key`对应的`vlue`都可以为`null`。
3.`HashMap`不是线程安全的。
4.`HashMap`常被用作映射存储容器、简单缓存对象等。

#### LinkedHashMap

`LinkedHashMap`直接继承自`HashMap`，大部分常用的方法都是复用的`HashMap`的方法，重写了其中的某些方法，与`HashMap`最大的不同是`LinkedHashMap`保证了元素的顺序性，其内部使用双向链表结构实现。基于双向链表的数据结构使`LinkedHashMap`拥有了顺序访问元素的能力，但是由于维护了元素的顺序性，在插入元素时速度要比`HashMap`慢一些。
1.`LinkedHashMap`保证元素顺序性。
2.`LinkedHashMap`的`key`不允许重复，至多允许一个`key`为`null`，任意`key`对应的`vlue`都可以为`null`。
3.`LinkedHashMap`不是线程安全的。

#### TreeMap

`TreeMap`继承自`AbstractMap`，并实现了`NavigableMap`接口，`AbstractMap`完成了大部分`map`接口所支持的方法，而`NavigableMap`接口继承自`SortedMap`接口，`SortedMap`存储的是有序的键值对。`TreeMap`内部使用红黑树结构实现元素存储，红黑树属于二叉排序树的一种，所以保证了`TreeMap`的有序性。红黑树三个重要的操作，左旋、右旋和着色，当`TreeMap`的元素发生变化时，为了维持红黑树的特性，需要针对性的对元素进行左旋、右旋和重新着色。
1.`TreeMap`保证元素顺序性。
2.不允许插入值为`null`的`key`。
3.可以插入值为`null`的`value`。
4.若`key`重复，则后面插入的直接覆盖原来的`value`。
5.非线程安全。

### Collection 接口

`Collection`接口是`List`、`Set`等集合高度抽象出来的接口，它包含了这些集合的基本操作，主要又分为两大部分：`List`和`Set`。`List`接口通常表示一个列表（数组、队列、链表、栈等），其中的元素可以重复，常用实现类为`ArrayList`和`LinkedList`。

#### ArrayList

`ArrayList`实现了 `List` 接口，其内部基于数组的数据结构实现，维护了一个`object`类型的动态数组。`object`数组长度默认`10`，超过这个长度就需要扩容。扩容机制是根据计算出来的新的容量重新实例化一个数组，并将原来数组的内容拷贝至新的数组。如果频繁扩容的话，比较浪费空间且容易引发性能问题。
1.基于数组实现，元素有序，元素可为`null`、可重复。
2.动态数组，容量不够时需要扩容，扩容基于数组拷贝，不适合用于频繁增删的场景，如果可以确定数据量大小，推荐使用固定的容量实例化。
3.非线程安全。

#### LinkedList

`LinkedList`实现了`List`接口，并直接继承自`AbstractSequentialList`，`AbstractSequentialList`继承自`AbstractList`。`LinkedList`内部维护了一个双向链表的数据结构，`LinkedList`正是利用这个双向链表的数据结构实现了内部的元素存储，并通过维护一个头指针和尾指针，进行元素的增加和删除。
1.`LinkedList`基于双向链表结构实现存储，元素是有序的，并且元素可以为`null`、可以重复。
2.由于基于双向链表实现存储，增删比较快速，适用于频繁增删的场景。
3.查找比较耗时，遍历是需要注意，使用随机访问方式查找效率比较低下，需使用`Iterator`方式或者`foreach`方式遍历。
4.非线程安全，多线程环境慎用。

#### Set接口

Set接口通常表示一个集合，其中的元素不允许重复，常用实现类有HashSet、LinkedHashSet和TreeSet。
1.对于`HashSet`而言，它是基于`HashMap`实现的，可以看作是对`HashMap`的封装，`HashSet`底层使用`HashMap`来保存所有元素，因此`HashSet`的实现比较简单，相关`HashSet`的操作，基本上都是直接调用底层`HashMap`的相关方法来完成。由于底层基于`HashMap`实现，内部使用基于哈希表的数组+链表方式存储，所以不保证元素的存取顺序。基于`key`的`hash`值存储，同样的对象`hash`值相同，所以元素不可重复，但是可以为`null`，可以快速查找是否包含某个元素。 
2.`LinkedHashSet`继承自`HashSet`，内部是基于`LinkedHashMap`来实现的。`LinkedHashSet`底层使用`LinkedHashMap`来保存所有元素，其所有的方法操作上又与`HashSet`相同。底层存储基于`LinkedHashMap`实现，内部使用双向链表存储元素，所以保证了元素的顺序性。基于`key`的`hash`值存储，同样的对象`hash`值相同，所以元素不可重复，但是可以为`null`，可以快速查找是否包含某个元素。 
3.`TreeSet`是基于`TreeMap`实现的有序集合，`TreeSet`中含有一个`NavigableMap`类型的成员变量`m`，而`m`实际上是`TreeMap`的实例。我们知道`TreeMap`内部是用红黑树实现元素存储从而保证元素的顺序性的，那么同理`TreeSet`同样也是一个有序的集合。底层存储基于`TreeMap`实现，内部使用红黑树结构表存储元素，所以保证了元素的顺序性。元素不可以为`null`。遍历时不支持随机访问，只能通过迭代器和`for-each`遍进行遍历。