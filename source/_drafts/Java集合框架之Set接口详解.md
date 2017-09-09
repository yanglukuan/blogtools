---
title: Java集合框架之Set接口详解
date: 2017-09-9 21:22:09 
tags: [Java,集合,HashSet,LinkedHashSet,TreeSet]
categories: java
---


本文基于`jdk1.8`介绍`Set`接口下的常用实现类。
## java 集合框架
在前两篇文章中， 我们介绍了Java集合框架下`List`接口下的`ArrayList`和`LinkedList`两个实现类，今天我们来看一下`Set`接口下的几个实现类`HashSet`、`LinkedHashSet`和`TreeSet`。下面还是先来看一下`Collection`接口的类图：
<center>![Collection接口类图](/images/arrayList/Collections.png)</center><center>***Collection接口类图***</center>

由类图我们可以看到，set接口继承自Collection接口且有四个实现类，分别为AbstractSet、HashSet、LinkedHashSet和TreeSet，其中AbstractSet为抽象类，继承自AbstractCollection，实现了最基本的Collection骨架。下面我们分别来看一下这个三个实现类的实现原理。

## HashSet
<center>![HashSet类图](/images/set/hashset.png)</center><center>***HashSet类图***</center>

对于HashSet而言，它是基于HashMap实现的，可以看作是对HashMap的封装，HashSet底层使用HashMap来保存所有元素，因此HashSet的实现比较简单，相关HashSet的操作，基本上都是直接调用底层HashMap的相关方法来完成， 如果看过了HashMap的源码之后，再来看HashSet会比较好理解一些，如果对HashMap的原理不熟悉的话，可以先回顾一下我们前几天对HashMap分析的博文{% post_link  java/HashMap详解 %}。下面我们结合源码来具体分析一下HashSet的具体实现。

### 成员变量
首先看一下两个成员变量
```java
  private transient HashMap<E,Object> map;//存储元素的map

    // Dummy value to associate with an Object in the backing Map
    private static final Object PRESENT = new Object(); //元素的默认vlaue
```
通过这两个成员变量我们可以看到，在HashSet的内部维护着一个HashMap类型的变量map，这个map就是用来存储元素的容器。那我们知道，HashMap存储的是key-value形式的简直对，而set是一个单值对象，这要怎么存储呢？那就要看第二个成员变量PRESENT，PRESENT是一个Object对象，这个对象就是充当键值对的值的，也就是说，我们只会把需要存储的元素当作map的key，而value则默认为这个Object对象，这就是HashSet内部实现存储元素的数据结构。所以由HashMap的特性我们可以知道，HashSet存储的元素是无序的，元素不是不可重复的并且可以为null，基于这个元素不允许重复的特性，HashSet经常被用来做元素的去重。

### 构造方法
下面我们看一下HashSet提供的构造方法。

```java
  
   //构造一个使用HashMap的默认容量大小16和默认加载因子0.75初始化map的HashSet
    public HashSet() {
        map = new HashMap<>();
    }


   //根据 Collection 接口构造一个HashSet
    public HashSet(Collection<? extends E> c) {
        map = new HashMap<>(Math.max((int) (c.size()/.75f) + 1, 16));
        addAll(c);
    }

    //使用指定的初始容量大小和加载因子初始化map，构造一个HashSet
    public HashSet(int initialCapacity, float loadFactor) {
        map = new HashMap<>(initialCapacity, loadFactor);
    }

   //使用指定的初始容量大小初始化map，构造一个HashSet
    public HashSet(int initialCapacity) {
        map = new HashMap<>(initialCapacity);
    }

    //构造一个LinkedHashMap，不对外公开 
    HashSet(int initialCapacity, float loadFactor, boolean dummy) {
        map = new LinkedHashMap<>(initialCapacity, loadFactor);
    }
```

HashSet一共提供了5个构造方法，由构造方法也可以看到，底层是用了HashMap的数据结构实现，构造方法也跟HashMap比较类似，这里重点要说一下` HashSet(int initialCapacity, float loadFactor, boolean dummy)`，这个构造方式是不对外部公开的，其实放在这里实现是为了给`LinkedHashSet`使用，下文我们会讲到这一点。

### 存取实现

添加元素
由于底层使用了HashMap作存储结构，这里直接调用了HashMap的put方法插入元素，元素被作为key插入的map中，而value则是使用的默认值Object对象。
```java
   public boolean add(E e) {
        return map.put(e, PRESENT)==null;//直接将元素作为map的key插入
    }
```
遍历
HashSet支持两种遍历方式，`Iterator`方式，`foreach`方式，不支持随机访问方式遍历。

```java

  Set<String> set=new HashSet<>();
  hashset.add("1");
  hashset.add("2");

 //Iterator遍历  
 for(Iterator iterator = set.iterator();
       iterator.hasNext(); ) { 
    iterator.next();
 }

 //foreach遍历
  for (String str:set){
     System.out.println(str);
  }

```

### 特性总结
1、由于底层基于HashMap实现，内部使用哈希表实现，所以元素不是有序存储。
2、基于key的hash存储，同样的对象hash相同，所以元素不可重复，但是可以为null，可以快速查找是否包含某个元素。   


## LinkedHashSet
继承自HashMap 调用HashMap的构造 实现一个LinkedHashMap

## TreeSet

基于treemap实现

## 参考
http://www.jianshu.com/p/1f7a8dda341b
http://www.cnblogs.com/leesf456/p/5309809.html
http://blog.csdn.net/canot/article/details/51246944