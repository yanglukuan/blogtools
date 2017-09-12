---
title: Java集合框架之ArrayList详解
date: 2017-09-07 14:24:49 
tags: [Java,集合,ArrayList]
categories: java
---

本文基于`jdk1.8`介绍`ArrayList`。
## java 集合框架
`Java`的集合类主要由两个接口派生而出：`Collection`和`Map`，在前几篇文章中，我们介绍了`map`接口的几个常用实现类。在接下来的文章中，我们将介绍另一个接口`Collection`的常用实现类。这些类包括`List`接口下的`ArrayList`和`LinkedList`，`Set`接口下的`HashSet`和`LinkedHashSet`。下面给出`Collection`接口的类图：
<center>![Collection接口类图](/images/arrayList/Collections.png)</center><center>***Collection接口类图***</center>

## ArrayList
<center>![ArrayList类图](/images/arrayList/arrayList.png)</center><center>***ArrayList类图***</center>

结合`Collection`接口类图和`ArrayList`类图我们可以看到，`ArrayList`直接继承自`AbstractList`，并实现了`List`接口。`AbstractList`是一个继承于`AbstractCollection`并且实现`List`接口的抽象类。它实现了`List`中大部分的方法，从而方便其它类继承`List`。下面我们来看一下它的数据结构。

### 数据结构

`ArrayList`实现了 `List` 接口，它是基于数组的一个实现，意味着可以插入空值，也可以插入重复的值，并且是非线程安全的。结合源码我们可以看到，在`ArrayList`内部维护着一个`Object`类型的数组`elementData`，这个数组就是存放数据元素的结构，所以`ArrayList`所使用的数据结构为数组，就像它的名字一样。但是我们知道，数组的长度是固定的，而`ArrayList`的长度却是可变的，这是因为`ArrayList`内部是以动态数组的形式来存储数据的，这里的动态数组不是意味着去改变原有内部生成的数组的长度，而是保留原有数组的引用，将其指向新生成的数组对象，这样会造成数组的长度可变的假象。`DEFAULT_CAPACITY`表示数组默认的元素个数，超过这个个数就会触发扩容机制，扩容会设置新的存储能力为原来的1.5倍。`Size`表示数组`elementData`元素的个数。

```java
  //存储元素的数组
  transient Object[] elementData; // non-private to simplify nested class access
  //默认数组长度
  private static final int DEFAULT_CAPACITY = 10;
  //当前元素个数
  private int size;
```
由于使用了数组的方式存储数据，`ArrayList`具有数组所具有的特性，元素顺序性、元素可重复等，通过索引支持随机访问，所以通过随机访问`ArrayList`中的元素效率非常高。

### 构造方法
`ArrayList`提供了以下三个构造方法:
```java

// 默认构造函数 ArrayList的默认容量大小是10
ArrayList()

// capacity是ArrayList初始化容量的大小。当由于增加数据导致容量不足时，容量会添加上一次容量大小的一半。
ArrayList(int capacity)

// 创建一个包含collection的ArrayList
ArrayList(Collection<? extends E> collection)

```
由于使用了数组的实现方式，容量不足时需要扩容，在使用时如果能确定容量大小，最好使用带容量大小的构造方法去使用，可以免去动态扩容带来的性能开销。
### 存取实现
下面我们结合源码来看一下存取的实现过程。
#### 元素添加 add
首先看一下添加元素的`add`方法，`add`方法只有寥寥几行，它内部调用了一个`ensureCapacityInternal`方法，然后紧跟着就是执行对数组`elementData`元素的赋值。通过上面的分析和查看源代码，我们可以知道，这个`ensureCapacityInternal`是用来实现数组扩容的功能，扩容结束，又可以继续嗨了，下面我们重点来看一下这个方法。
```java
    //添加方法
    public boolean add(E e) {
        //检查数组容量 容量不够时扩容
        ensureCapacityInternal(size + 1);  // Increments modCount!!
        elementData[size++] = e;//元素保存
        return true;
    }
```
`ensureCapacityInternal`方法及内部方法

```java

 //检查数组容量  minCapacity为当前数组元素数+1 
 private void ensureCapacityInternal(int minCapacity) {
        //先判断数组 是否为空
        if (elementData == DEFAULTCAPACITY_EMPTY_ELEMENTDATA) {
            minCapacity = Math.max(DEFAULT_CAPACITY, minCapacity);//如果数组为空 minCapacity取较大值
        }

        ensureExplicitCapacity(minCapacity);
    }


    //扩容
    private void ensureExplicitCapacity(int minCapacity) {
        modCount++;//结构性修改+1

        // overflow-conscious code
        // 如果数组容量不够 就执行扩容
        if (minCapacity - elementData.length > 0)
            grow(minCapacity); //执行扩容
    }
    
    //扩容
    private void grow(int minCapacity) {
        // overflow-conscious code

        //这里有三个变量 我们先来看一下
        //oldCapacity：数组当前的长度 
        //minCapacity: 存储数据至少需要多长 
        //newCapacity：数组将来的长度 
        int oldCapacity = elementData.length;//保存原来的数组长度
        int newCapacity = oldCapacity + (oldCapacity >> 1);//先将数组大小扩展至原来的1.5倍
        if (newCapacity - minCapacity < 0)//如果新的容量小于所需容量 将所需容量赋值给新的容量
            newCapacity = minCapacity;
        if (newCapacity - MAX_ARRAY_SIZE > 0)//如果新的数组长度大于数组的最大长度
            newCapacity = hugeCapacity(minCapacity);//计算新的容量
        // minCapacity is usually close to size, so this is a win:
        elementData = Arrays.copyOf(elementData, newCapacity);//将数组拷贝到已扩容的新数组中
    }

     //如果所需长度大于数组的最大长度  重新计算数组长度  最大的数组长度可以为 Integer.MAX_VALUE
      private static int hugeCapacity(int minCapacity) {
        if (minCapacity < 0) // overflow
            throw new OutOfMemoryError();
        return (minCapacity > MAX_ARRAY_SIZE) ?
            Integer.MAX_VALUE :
            MAX_ARRAY_SIZE;
    }

```
上面三个方法完成了对数组`elementData`的容量检查和扩容，保证了数组在保存元素时有足够的容量。整个检查和扩容的流程如下
>1、获取数组当前元素数`size`，将`size+1`代表数组所需要的长度。
2、校验数组是否为空，为空则需要进行扩容，扩容的长度就是`DEFAULT_CAPACITY与minCapacity`的较大值。如果使用默认的无参构造方法，实例化的`ArrayList`的数组则为空，如果使用带数组长度的构造方法，实例化的`ArrayList`的数组长度则为构造的长度。
3、执行扩容前的计算，决定扩容的长度。这里利用三个变量完成计算，说明一下。
`oldCapacity`：数组当前的长度，`minCapacity`: 存储数据至少需要的长度 ，`newCapacity`：数组新的长度 
首先保存当前数组的长度，然后将数组大小扩展1.5倍赋值给数组新的长度（`newCapacity = oldCapacity + (oldCapacity >> 1)`），这里使用了位运算符，右移一位相当于除2，右移n位相当于除以2的n次方。如果新的长度小于所需容量，将所需容量赋值给新的数组长度，这种情况会在数组为空的时候发生。然后如果新的数组长度大于数组的最大长度`MAX_ARRAY_SIZE`，就重新计算数组长度，最大的数组长度可以为 `Integer.MAX_VALUE`。
4、扩容长度计算完毕，执行扩容，将数组内容拷贝到新的数组，并将新的数组赋值给`elementData`，完成扩容。
5、扩容完成，执行添加元素操作。

从这个过程可以看出，如果频繁的对`ArrayList`进行插入操作而同时又不指定集合的长度的话，就会频繁的引起数组动态扩容，由于扩容是使用的数组的拷贝方法，这种方式不仅牺牲了性能而且也对内存空间造成了浪费，如果数据量比较大的话可能会带来比较严重的性能问题，所以如果我们提前能清楚的知道所处理数据的大小，就可以构造一个固定长度的`ArrayList`，也就省去了动态扩容的开销。

#### 遍历和查找
说完了添加，下面再说说查找。数组的优势就在于查找了，数组可以使用索引访问任意的元素，实现高效的查找和遍历。查找就是根据下边找到数组元素，比较简单，这里就不再说了，下面来看一下遍历。对`ArrayList`遍历有以下几种方法：
`Iterator`方式，`for`循环索引随机访问方式，`foreach`方式，对于这几种方式来说，使用随机访问的方式遍历是效率最高的。因为`ArrayList`实现了`RandomAccess`接口，此接口的主要目的是允许一般的算法更改其行为，从而在将其应用到随机或连续访问列表时能提供良好的性能。 

### 总结
基于以上的分析，我们来总结以下`ArrayList`的特性和注意点。
1、`ArrayList`是基于数组的数据结构实现，拥有数组的一般特性，有序性，元素可重复、可为空以及高效的随机访问能力，比较适用于频繁读取数据的场景。
2、由于是动态数组，容量不够时需要扩容，扩容带来性能问题，不适合用于频繁增删的场景，如果可以确定数据量大小，推荐使用固定的容量实例化。
3、非线程安全，多线程环境谨慎使用。

## 参考
http://blog.csdn.net/yang1464657625/article/details/59109133
http://www.cnblogs.com/leesf456/p/5308358.html