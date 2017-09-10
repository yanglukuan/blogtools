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

由类图我们可以看到，`set`接口继承自`Collection`接口且有四个实现类，分别为`AbstractSet`、`HashSet`、`LinkedHashSet`和`TreeSet`，其中`AbstractSet`为抽象类，继承自`AbstractCollection`，实现了最基本的`Collection`骨架。下面我们分别来看一下其余三个实现类的实现原理。

## HashSet
<center>![HashSet类图](/images/set/hashset.png)</center><center>***HashSet类图***</center>

对于`HashSet`而言，它是基于`HashMap`实现的，可以看作是对`HashMap`的封装，`HashSet`底层使用`HashMap`来保存所有元素，因此`HashSet`的实现比较简单，相关`HashSet`的操作，基本上都是直接调用底层`HashMap`的相关方法来完成， 如果看过了`HashMap`的源码之后，再来看`HashSet`会比较好理解一些，如果对`HashMap`的原理不熟悉的话，可以先回顾一下我们前几天对`HashMap`分析的博文{% post_link  java/HashMap详解 %}。下面我们结合源码来具体分析一下`HashSet`的具体实现。

### 成员变量
首先看一下两个成员变量
```java
  private transient HashMap<E,Object> map;//存储元素的map

    // Dummy value to associate with an Object in the backing Map
    private static final Object PRESENT = new Object(); //元素的默认vlaue
```
通过这两个成员变量我们可以看到，在`HashSet`的内部维护着一个`HashMap`类型的变量`map`，这个`map`就是用来存储元素的容器。那我们知道，`HashMap`存储的是`key-value`形式的键值对，而`set`是一个单值对象，这要怎么存储呢？那就要看第二个成员变量`PRESENT`了，`PRESENT`是一个`Object`对象，这个对象就是充当键值对的值的，也就是说，我们只会把需要存储的元素当作`map`的`key`，而对应的`value`则默认为这个`Object`对象，这就是`HashSet`内部实现存储元素的数据结构。所以由`HashMap`的特性我们可以知道，`HashSet`存储的元素是无序的，元素不是不可重复的并且可以为`null`，基于这个元素不允许重复的特性，`HashSet`经常被用来做元素的去重。

### 构造方法
下面我们看一下`HashSet`提供的构造方法。

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

`HashSet`一共提供了5个构造方法，由构造方法也可以看到，底层是用了`HashMap`的数据结构实现，构造方法也跟`HashMap`比较类似，这里重点要说一下` HashSet(int initialCapacity, float loadFactor, boolean dummy)`这个构造方法，这个构造方法是不对外部公开的，其实放在这里实现是为了给`LinkedHashSet`使用，下文我们会讲到这一点。

### 存取实现

添加元素
由于底层使用了`HashMap`作存储结构，这里直接调用了`HashMap`的`put`方法插入元素，元素被作为`key`插入的`map`中，而`value`则是使用的默认值`Object`对象。
```java
   public boolean add(E e) {
        return map.put(e, PRESENT)==null;//直接将元素作为map的key插入
    }
```
遍历
`HashSet`支持两种遍历方式，`Iterator`方式，`foreach`方式，不支持随机访问方式遍历。

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
1、由于底层基于`HashMap`实现，内部使用基于哈希表的数组+链表方式存储，所以保证元素的存取顺序。
2、基于`key`的`hash`值存储，同样的对象`hash`值相同，所以元素不可重复，但是可以为`null`，可以快速查找是否包含某个元素。   


## LinkedHashSet

<center>![LinkedHashSet类图](/images/set/linkedHashSet.png)</center><center>***LinkedHashSet类图***</center>

由类图我们可以看到，`LinkedHashSet`继承自`HashSet`，内部是基于`LinkedHashMap`来实现的。`LinkedHashSet`底层使用`LinkedHashMap`来保存所有元素，其所有的方法操作上又与`HashSet`相同，因此`LinkedHashSet` 的实现上非常简单，只提供了四个构造方法和一个`spliterator`方法，并通过传递一个标识参数，调用父类的构造方法，上文我们说到`HashSet`预留了一个不对外部公开的构造方法，就是用在这里。底层构造一个`LinkedHashMap来实现`，在相关操作上与父类`HashSet`的操作相同，直接调用父类`HashSet`的方法即可。

`LinkedHashSet`源码，由于底层使用`LinkedHashMap`作为存储结构，又继承了`HashSet`的各种方法，所以源码比较简单，这里就不做分析了，具体实现原理，参照{% post_link  java/Java集合框架之LinkedHashMap详解 %}  一文。
```java

    //使用指定的初始容量大小和加载因子初始化map，构造一个LinkedHashSet
    public LinkedHashSet(int initialCapacity, float loadFactor) {
        super(initialCapacity, loadFactor, true);
    }

   //使用指定的初始容量大小初始化map，构造一个LinkedHashSet
    public LinkedHashSet(int initialCapacity) {
        super(initialCapacity, .75f, true);
    }

    // 构造一个使用HashMap的默认容量大小16和默认加载因子0.75初始化map的LinkedHashSet
    public LinkedHashSet() {
        super(16, .75f, true);
    }

     //根据 Collection 接口构造一个inkedHashSet
    public LinkedHashSet(Collection<? extends E> c) {
        super(Math.max(2*c.size(), 11), .75f, true);
        addAll(c);
    }

    // 调用Spliterator接口中的spliterator()方法，将集合分割后遍历
    @Override
    public Spliterator<E> spliterator() {
        return Spliterators.spliterator(this, Spliterator.DISTINCT | Spliterator.ORDERED);
    }
```

### 特性总结
1、底层存储基于`LinkedHashMap`实现，内部使用双向链表存储元素，所以保证了元素的顺序性。
2、基于`key`的`hash`值存储，同样的对象`hash`值相同，所以元素不可重复，但是可以为`null`，可以快速查找是否包含某个元素。 

## TreeSet

<center>![TreeSet类图](/images/set/treeSet.png)</center><center>***TreeSet类图***</center>

还是先看类图，`TreeSet`继承自`AbstractSet`，实现了`NavigableSet`接口，`AbstractSet`为抽象类，继承自`AbstractCollection`，实现了最基本的`Collection`骨架。`TreeSet`是基于`TreeMap`实现的有序集合，`TreeSet`中含有一个`NavigableMap`类型的成员变量`m`，而`m`实际上是`TreeMap`的实例。我们知道`TreeMap`内部是用红黑树实现元素存储从而保证元素的顺序性的，那么同理`TreeSet`同样也是一个有序的集合。通过源码我们知道`TreeSet`继承自`AbstractSet`，实现`NavigableSet`、`Cloneable`、`Serializable`接口。其中`AbstractSet`提供 `Set` 接口的骨干实现，从而最大限度地减少了实现此接口所需的工作。`NavigableSet`是扩展的 `SortedSet`，具有了为给定搜索目标报告最接近匹配项的导航方法，这就意味着它支持一系列的导航方法。比如查找与指定目标最匹配项。`Cloneable`支持克隆，`Serializable`支持序列化。由于TreeSet底层通过调用TreeMap实现，这里不再重复分析了，具体实现原理，参照{% post_link  java/Java集合框架之TreeMap详解 %}  一文。

成员变量
```java

    //NavigableMap 对象
    private transient NavigableMap<E,Object> m;

   //map的value值
    private static final Object PRESENT = new Object();

```

构造方法
```java

    //构造由指定的可导航映射支持的集合。
    TreeSet(NavigableMap<E,Object> m) {
        this.m = m;
    }

    //默认构造方法  根据其元素的自然顺序进行排序 
    public TreeSet() {
        this(new TreeMap<E,Object>());
    }

    //构造一个包含指定 collection 的TreeSet，它按照其元素的顺序进行排序
    public TreeSet(Comparator<? super E> comparator) {
        this(new TreeMap<>(comparator));
    }

    //构造一个指定Collection参数的TreeSet
    public TreeSet(Collection<? extends E> c) {
        this();
        addAll(c);
    }

    //构造一个指定SortedMap的TreeSet，根据SortedMap的比较器来来维持TreeSet的顺序
    public TreeSet(SortedSet<E> s) {
        this(s.comparator());
        addAll(s);
    }

```

### 特性总结
1、底层存储基于`TreeMap`实现，内部使用红黑树结构表存储元素，所以保证了元素的顺序性。
2、遍历时不支持随机访问，只能通过迭代器和`for-each`遍进行遍历。


## 参考
http://www.jianshu.com/p/1f7a8dda341b
http://www.cnblogs.com/leesf456/p/5309809.html
http://blog.csdn.net/canot/article/details/51246944