---
title: Java集合框架之HashMap详解
date: 2017-08-31 13:21:13
tags: [HashMap,集合]
categories: java
---

## 基础扫盲

### java 集合框架
---
`Java`的集合类主要由两个接口派生而出：`Collection`和`Map`，`Collection`和`Map`是`Java`集合框架的根接口，这两个接口又包含了一些接口或实现类。`Set`和`List`接口是`Collection`接口派生的两个子接口，`Queue`是`Java`提供的队列实现，类似于`List`。`Map`是一个映射接口，其中的每个元素都是一个`key-value`键值对，抽象类`AbstractMap`通过适配器模式实现了`Map`接口中的大部分函数，`TreeMap`、`HashMap`、`WeakHashMap`等实现类都通过继承`AbstractMap`来实现，另外，不常用的`HashTable`直接实现了Map接口。对于`Set`、`List`和`Map`三种集合，最常用的实现类分别是`HashSet`、`ArrayList`和`HashMap`三个实现类。

<center>![Map接口类图](/images/hashmap/javacollections.png)</center><center>***Map接口类图***</center>

(1) HashMap：它根据键的`hashCode`值存储数据，大多数情况下可以直接定位到它的值，因而具有很快的访问速度，但遍历顺序却是不确定的。 `HashMap`最多只允许一条记录的键为`null`，允许多条记录的值为`null`。`HashMap`非线程安全，即任一时刻可以有多个线程同时写`HashMap`，可能会导致数据的不一致。如果需要满足线程安全，可以用 `Collections`的`synchronizedMap`方法使`HashMap`具有线程安全的能力，或者使用`ConcurrentHashMap`。
(2) Hashtable：`Hashtable`是遗留类，很多映射的常用功能与`HashMap`类似，不同的是它承自`Dictionary`类，并且是线程安全的，任一时间只有一个线程能写Hashtable，并发性不如`ConcurrentHashMap`，因为`ConcurrentHashMap`引入了分段锁。`Hashtable`不建议在新代码中使用，不需要线程安全的场合可以用`HashMap`替换，需要线程安全的场合可以用`ConcurrentHashMap`替换。
(3) LinkedHashMap：`LinkedHashMap是HashMap`的一个子类，保存了记录的插入顺序，在用`Iterator`遍历`LinkedHashMap`时，先得到的记录肯定是先插入的，也可以在构造时带参数，按照访问次序排序。
(4) TreeMap：`TreeMap`实现`SortedMap`接口，能够把它保存的记录根据键排序，默认是按键值的升序排序，也可以指定排序的比较器，当用`Iterator`遍历`TreeMap`时，得到的记录是排过序的。如果使用排序的映射，建议使用`TreeMap`。在使用`TreeMap`时，`key`必须实现`Comparable`接口或者在构造`TreeMap`传入自定义的`Comparator`，否则会在运行时抛出`java.lang.ClassCastException`类型的异常。

对于上述四种`Map`类型的类，要求映射中的key是不可变对象。不可变对象是该对象在创建后它的哈希值不会被改变。如果对象的哈希值发生变化，`Map`对象很可能就定位不到映射的位置了。

### Hash 知识
---
维基百科的定义
>散列（英语：`Hashing`）是电脑科学中一种对资料的处理方法，通过某种特定的函数/算法（称为散列函数/算法）将要检索的项与用来检索的索引（称为散列，或者散列值）关联起来，生成一种便于搜索的数据结构（称为散列表）。也译为散列。旧译哈希（误以为是人名而采用了音译）。它也常用作一种资讯安全的实作方法，由一串资料中经过散列算法（`Hashing algorithms`）计算出来的资料指纹（`data fingerprint`），经常用来识别档案与资料是否有被窜改，以保证档案与资料确实是由原创者所提供。

### Hash 函数
---  
>散列函数（或散列算法，又称哈希函数，英语：`Hash Function`）是一种从任何一种数据中创建小的数字“指纹”的方法。散列函数把消息或数据压缩成摘要，使得数据量变小，将数据的格式固定下来。该函数将数据打乱混合，重新创建一个叫做散列值（`hash values`，`hash codes`，`hash sums`，或`hashes`）的指纹。散列值通常用一个短的随机字母和数字组成的字符串来代表。好的散列函数在输入域中很少出现散列冲突。在散列表和数据处理中，不抑制冲突来区别数据，会使得数据库记录更难找到。

上面是维基百科给出的定义，通俗点来讲，一般情况下，需要在关键字与它在表中的存储位置之间建立一个函数关系，以`f(key)`作为关键字为`key`的记录在表中的位置，通常称这个函数`f(key)`为哈希函数。
### 哈希表和查找
---
哈希表是哈希函数的一个主要应用，使用哈希表能够快速的按照关键字查找数据记录。（注意：关键字不是像在加密中所使用的那样是秘密的，但它们都是用来“解锁”或者访问数据的。）例如，在英语字典中的关键字是英文单词，和它们相关的记录包含这些单词的定义。在这种情况下，哈希函数必须把按照字母顺序排列的字符串映射到为哈希表的内部数组所创建的索引上。哈希表是一个在时间和空间上做出权衡的经典例子,在没有碰撞的情况下，检索时间复杂度为O(1)。
### Hash 冲突
---
对不同的关键字可能得到同一散列地址，即 `k1!=k2`，而`f(k1)==f(k2)`，这种现象称为冲突（英语：Collision）。具有相同函数值的关键字对该散列函数来说称做同义词。综上所述，根据散列函数f(k)和处理冲突的方法将一组关键字映射到一个有限的连续的地址集（区间）上，并以关键字在地址集中的“像”作为记录在表中的存储位置，这种表便称为散列表，这一映射过程称为散列造表或散列，所得的存储位置称散列地址。解决碰撞有很多方法可以使用，最常用的包括链地址法和开地址法。`HashMap`就是用的链地址的方法解决冲突。
## HashMap
---
`HashMap`是我们经常使用一个映射容器，通过牺牲存储空间来换取检索时间，`HashMap`是采用了hash表数据结构思想来实现。在`key`未发生冲突的情况下，搜索时间复杂度为O(1),可以快速定位元素。因此在日常开发中也被程序员广泛使用，例如作为关系映射容器、简单缓存、提高检索速度等。`HashMap`最多只允许一个键值为`null`(保存在数据列表中的第0个元素的链表上)，允许`value`为`null`值。
### 数据结构
---
`HashMap`实现了`Map`接口，继承`AbstractMap`。其中`Map`接口定义了键映射到值的规则，而`AbstractMap`类提供 `Map` 接口的骨干实现。`java`的`HashMap`结构上采用了数组链表方式，即数组+链表的数据结构，采用这种结构的原因是采用了链地址的方法解决哈希冲突。但是这样带来了一个问题，当某个链表达到一定的长度时，对于链表元素的查找会变成线性搜索，比较耗时。所以在`JDK1.8`的实现中做了优化，当链表的长度达到一定数量（`TREEIFY_THRESHOLD`默认值为8）时，会把链表转为红黑树，所以在`JDK1.8`的版本`HashMap`的数据结构为数组+链表+红黑树。
在`HashMap`中，通过`Node[] table`，(`jdk 1.7`叫做`Entry`，`jdk 1.8`加入红黑树后改为`Node`,原因是和红黑树的实现`TreeNode`相关联)来实现该结构，该数组可以看做是一个哈希桶数组，每个桶中存放着一个链表，Node是链表节点,并实现了`Map.Entry`。`Node`节点存放一个键值对，同时存放一个指向下一个节点的引用。`Node`是键值对存储单元，通过`hash`值来确定该元素在数组链表中的位置。基于这个存储结构，我们也可以看出，`HashMap`是不保证存取的顺序性的，也就是说遍历`HashMap`的时候，得到的元素的顺序与添加元素的顺序是不同的。
```java
  Node结构源码
  static class Node<K,V> implements Map.Entry<K,V> {
        final int hash; //用来定位数组索引位置，hash值不允许修改。
        final K key; //key, 都是常数不允许修改。同时key是一个不可变对象。
        V value;//对应value
        Node<K,V> next;//下一个节点

        Node(int hash, K key, V value, Node<K,V> next) {
            this.hash = hash;
            this.key = key;
            this.value = value;
            this.next = next;
        }
        后面代码省略。。。。。。。。。。
}
```
<center>![存储结构](/images/hashmap/hashmapstructure.png)</center><center>***存储结构***</center>

### 存取原理
---
**1.构造函数**
HashMap提供了四个构造函数：
```java
HashMap();//构造一个具有默认初始容量 (16) 和默认加载因子 (0.75) 的空 HashMap。
HashMap(int initialCapacity);//构造一个带指定初始容量和默认加载因子 (0.75) 的空 HashMap。
HashMap(int initialCapacity, float loadFactor);//构造一个带指定初始容量和加载因子的空 HashMap。
HashMap(Map<? extendsK,? extendsV> m); //构造一个映射关系与指定 Map 相同的 HashMap。
```
在这里出现了两个参数：初始容量，加载因子。这两个参数是影响HashMap性能的重要参数，其中初始容量表示哈希表中桶的数量，也就是上一节提到的Node数组table[]的初始长度，初始容量是创建哈希表时的容量，加载因子是哈希表在其容量自动增加之前可以达到多满的一种尺度，它衡量的是一个散列表的空间的使用程度，负载因子越大表示散列表的装填程度越高，反之愈小。对于使用链地址法的散列表来说，查找一个元素的平均时间是`O(1+a)`，因此如果负载因子越大，对空间的利用更充分，然而后果是查找效率的降低；如果负载因子太小，那么散列表的数据将过于稀疏，对空间造成严重浪费。系统默认负载因子为0.75，一般情况下我们是无需修改的。
**2.几个重要的属性**
```java 
1. int threshold; // 所能容纳的key-value对极限
2. int modCount; // 修改次数
3. int size; // 元素数量
4. final float loadFactor; // 负载因子
```
 **threshold**
`threshold`是`HashMap`所能容纳的最大数据量的`Node`(键值对)个数。`threshold = length * Load factor`。也就是说，在数组定义好长度之后，负载因子越大，所能容纳的键值对个数越多。如果容器中的元素数量超过这个值，那么`HashMap`就会进行扩容，重新调整元素位置。扩容后的容量是之前容量的2倍。在HashMap中容器的长度必须是2的倍数，这种设计主要是为了在取模和扩容时做优化，同时为了减少冲突，`HashMap`定位哈希桶索引位置时，也加入了高位参与运算的过程。
 **size**
这个字段其实很好理解，就是HashMap中实际存在的键值对数量。注意和table的长度`length`、容纳最大键值对数量`threshold`的区别。
 **modCount**
字段主要用来记录HashMap内部结构发生变化的次数，主要用于迭代的快速失败。强调一点，内部结构发生变化指的是结构发生变化，例如put新键值对，但是某个key对应的value值被覆盖不属于结构变化。
 **TREEIFY_THRESHOLD**
`static final int TREEIFY_THRESHOLD = 8;`
在J`DK1.8`版本中，对数据结构做了进一步的优化，引入了红黑树。这是一个常数，表示链表长度的一个阈值。如果链表长度大于这个值(默认为8)时，就转为红黑树。利用红黑树提高增删改查的性能，避免之前因为某个链上积累太多元素而影响HashMap性能，使用红黑树使得增删改查等操作复杂度变为`O(logN)`。
**3.存取过程**
`put`是`HashMap`的核心方法之一，用于存入数据，下面来分析下put方法的执行流程。
<center>![put方法执行顺序](/images/hashmap/hashmapput.png)</center><center>***put方法执行顺序***</center>
根据分析，`put`方法的执行步骤如下：
1.首先判断`table`是否为null或者`length==0`,如果是则先做扩容
2.计算索引
根据键值`key`计算`hash`值在数组链表中的索引位置i。如果`key`为`null`,则默认保存到0位置的哈希桶，保证了一个`hashMap`中只有一个值为`null`的`key`。判断`table[i]`是否为空，如果为空则直接插入，执行。否则执行3。
3.判断`table[i]`的首个元素是否和key一样（通过`hashCode`以及`equals`判断），如果相同直接覆盖`value`，否则转向4。 
4.判断`table[i]` 是否为treeNode(是否是红黑树)，如果是红黑树，则直接在树中插入键值对，否则转向5。
5.遍历`table[i]`，判断链表中是否存在相同的key,如果存在则直接覆盖。否则在链表尾部插入新节点（`JDK1.7`是在头部插入）。插入完成后判断链表长度是否大于8，大于8的话把链表转换为红黑树，在红黑树中执行插入操作，否则进行链表的插入操作，遍历过程中若发现key已经存在直接覆盖value即可。 
6.插入成功后，判断实际存在的键值对数量`size`是否超多了最大容量`threshold`，如果超过，进行扩容。

具体来看源码：
```java
    final V putVal(int hash, K key, V value, boolean onlyIfAbsent,
                   boolean evict) {
        Node<K,V>[] tab; Node<K,V> p; int n, i;
        if ((tab = table) == null || (n = tab.length) == 0)//1.判断是否table为空
            n = (tab = resize()).length;//扩容
        if ((p = tab[i = (n - 1) & hash]) == null)//2.根据hash值计算索引，(n - 1) & hash。判断该位置是否为空
            tab[i] = newNode(hash, key, value, null);//为空 插入新节点
        else {//该位置不为空
            Node<K,V> e; K k;
            if (p.hash == hash &&  //3.判断该节点key是否存在 存在直接覆盖value
                ((k = p.key) == key || (key != null && key.equals(k))))
                e = p; //存在直接覆盖value
            else if (p instanceof TreeNode) //4.判断是否为红黑树
                e = ((TreeNode<K,V>)p).putTreeVal(this, tab, hash, key, value);//红黑树 直接插入
            else { //5.链表操作
                for (int binCount = 0; ; ++binCount) {
                    if ((e = p.next) == null) { //判断链表该节点是否有子节点
                        //插入新节点（尾部插入）
                        p.next = newNode(hash, key, value, null);
                        if (binCount >= TREEIFY_THRESHOLD - 1) // -1 for 1st
                            treeifyBin(tab, hash);
                        break;
                    }
                    //判断是否存在相同的key 如果存在直接覆盖
                    if (e.hash == hash &&
                        ((k = e.key) == key || (key != null && key.equals(k))))
                        break;
                    p = e;
                }
            }
            if (e != null) { // existing mapping for key
                V oldValue = e.value;
                if (!onlyIfAbsent || oldValue == null)
                    e.value = value;
                afterNodeAccess(e);
                return oldValue;
            }
        }  //6.如果超过最大容量  扩容
        ++modCount;
        if (++size > threshold)
            resize();
        afterNodeInsertion(evict);
        return null;
    }
```
**4.HashCode的计算和元素定位**
`HashMap`的数据结构决定了在整个使用过程包括增加、删除和查找元素时，定位到哈希桶数组的位置都是很关键的第一步。`hashMap`采用数组链表结构，我们希望插入的元素在表中尽可能的均匀分布，这样能够提高操作效率。而元素的分布情况与`hashCode`计算算法有关，直接影响`hash`离散性能。
```java
// 计算hash值
static final int hash(Object key) {   //jdk1.8 
     int h;
     /**
    可以看作两步：
    1.   h = key.hashCode() 为第一步 取hashCode值
    2.   h ^ (h >>> 16)  为第二步 高位参与运算
     **/
     return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
// 锁定数组下标位置(锁定hash桶)
static int indexFor(int h, int length) {  //jdk1.7的源码，jdk1.8没有这个方法，直接在代码中用(n - 1) & hash替代，实现原理一样的
     return h & (length-1);  //第三步 取模运算
}
```
定位哈希桶数组分为两个大步骤： 
1. 计算`hash`值(取`key`的`hashCode`值、高位运算) 
2. 根据`hash`值定位哈希数组位置
在数据结构学习中，计算哈希桶数组位置的常用方式就是取模运算，即`index = hash% length`。通过这种方式可以使得每个元素能够相对均匀的分布在哈希桶数组中，`java`中的`hash`也采用了类似的方式。为了提高计算性能，`java`采用了&计算代替取模。前面我们提到哈希桶数组的长度是2倍数，这个设置是为了对`hashMap`中的操作进行优化。 
比如4的二进制是100， 对`4`取模操作`5%4 = 1 `相当于 `101 & 011 = 001 等于1`。在《剑指offer》中“二进制中的1的个数”也巧妙运用了`n&(n-1)`计算整数中出现1的个数。
一个`hashCode`是32位，而如果哈希桶数组长度比较小时，直接对hashCode进行取模运算只考虑了hashCode的低位字节。Java中同时考虑了高位和低位在计算索引位置的作用，保证高地位Bit都能参与到Hash的计算中。在`JDK1.8`的实现中，优化了高位运算的算法，通过`hashCode()`的高16位异或低16位实现的：`(h = k.hashCode()) ^ (h >>> 16)`，主要是从速度、功效、质量来考虑的，也保证数组`table`的`length`比较小的时候，高低`Bit`都能参与进来，使得元素更加均匀分散。
<center>![Hash计算方式](/images/hashmap/hashmaphash.png)</center><center>***Hash计算方式***</center>
**5.插入元素**
当元素定位的哈希桶是一个链表时，则采用尾插入法。首先从头遍历链表，根据`equals`和`hashCode`来比较`key`是否相同。因此作为`hashMap`的`key`必须同时重载`equals`方法和`hashCode`方法。
`JDK 1.7`的链表操作采用了头插入法，即新的元素插入到链表头部。在`JDK1.8`中采用了尾插入法。插入以后如果链表长度大于8，那么就会将链表转换为红黑树。因为如果链表长度过长会导致元素的增删改查效率低下，呈现线性搜索时间。`JDK1.8`采用采用红黑树进行优化，进而提高`HashMap`性能。如果哈希桶是一个红黑树，则直接使用红黑树插入方式直接插入到红黑树中。
**6.扩容**
`JDK1.8`是在插入元素后判断是否进行扩容，而且扩容条件相对于`JDK1.7`有所变化。`JDK1.7`是在插入元素前判断是否需要扩容，不仅要求`size`大于等于`threshold`，同时需要`table[bucketIndex]`不为空时才进行扩容。扩容时新的容器容量是原来的两倍。`JDK1.8`对于扩容过程进行了优化，提高扩容性能。
`JDK 1.7`是通过创建一个容量为原来两倍的新容器，然后遍历原来容器的所有元素并对每个元素重新计算一次在新容器的索引位置，然后插入到新容器中。

## 参考

http://blog.csdn.net/qq_27093465/article/details/52209789
http://blog.csdn.net/qq_27093465/article/details/52207152
http://www.importnew.com/16599.html
https://tech.meituan.com/java-hashmap.html