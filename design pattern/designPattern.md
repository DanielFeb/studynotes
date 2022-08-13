# 设计模式 Desgin Pattern
## 为什么要学习设计模式？
* 提高复杂代码的设计和开发能力，写出更高质量的代码
  * 你是否有过这种感觉，觉得很多老代码维护起来非常费劲，添加或者修改一个功能，常常会牵一发而动全身，无从下手，恨不得将全部的代码删掉重写。但在吐槽前辈的同时，不得不继续在"Big Ball of Mud" 上贡献自己的一份力量。
  * 在这个时候，设计模式可能可以给我们提供一个代码重构的方向。当然设计模式不是银弹，我们需要充分的了解业务前提下做出合理的设计和安排，然后在条件允许的情况下逐步的重构代码。
* 让读源码、学框架事半功倍

## 代码质量的评判维度
代码质量不仅仅是单元测试覆盖率、sonar issue个数这些静态的定量指标。

我们常常说这个代码写的真好，这段代码太“烂”了。这两个词语又有点匮乏，但是具体什么地方好，什么地方烂也没法说的特别清楚，只是一种感觉。
这里给大家提供几个比较常见评判维度：

* 可维护性
* 可读性
* 可扩展性
* 可测试性
* 灵活性
* 简洁性
* 可复用性
* 鲁棒性
* etc  

引用《设计模式之美》里面的一段话:  

`不同的评价维度也并不是完全独立的，有些是具有包含关系、重叠关系或者可以互相影响的。比如，代码的可读性好、可扩展性好，就意味着代码的可维护性好。`

`而且，各种评价维度也不是非黑即白的。比如，我们不能简单地将代码分为可读与不可读。如果用数字来量化代码的可读性的话，它应该是一个连续的区间值，而非 0、1 这样的离散值。不过，我们真的可以客观地量化一段代码质量的高低吗？答案是否定的。对一段代码的质量评价，常常有很强的主观性。比如，怎么样的代码才算可读性好，每个人的评判标准都不大一样。这就好比我们去评价一本小说写得是否精彩，本身就是一个很难量化的、非常主观的事情。`

`正是因为代码质量评价的主观性，使得这种主观评价的准确度，跟工程师自身经验有极大的关系。越是有经验的工程师，给出的评价也就越准确。`

### 相关阅读
《用DDD（领域驱动设计）和ADT（代数数据类型）提升代码质量》- 携程技术 工业聚  
https://mp.weixin.qq.com/s/VzVcT36jPptpcmS46d22Rw

《设计模式之美-从哪些维度评判代码质量的好坏？如何具备写出高质量代码的能力？》 - 极客时间 王争  
https://time.geekbang.org/column/article/160985

# 复习一下面向对象编程 OOP （Object-Oriented Programming）
因为我们目前使用的大多是面向对象的语言，而一会要介绍的设计模式的示例都是借助面向对象语言的特性实现的。 但是并不代表没有面向对象语言，设计模式就不存在了，其实在软件设计的各个层面都会出现设计模式的影子。

## 什么是面向对象编程？ 什么是面向对象语言？

面向对象编程是一种编程范式或编程风格。它以**类或对象**作为组织代码的基本单元，并将封装、抽象、继承、多态四个特性，作为代码设计和实现的基石。  

面向对象编程语言是支持类或对象的语法机制，并有现成的语法机制，能方便地实现面向对象编程四大特性（封装、抽象、继承、多态）的编程语言。

## 什么是面向过程编程？ 什么是面向过程语言？

面向过程编程也是一种编程范式或编程风格。它以过程（可以理解为**方法、函数、操作**）作为组织代码的基本单元，以数据（可以理解为成员变量、属性）与方法相分离为最主要的特点。面向过程风格是一种流程化的编程风格，通过拼接一组顺序执行的方法来操作数据完成一项功能。 

面向过程编程语言首先是一种编程语言。它最大的特点是不支持类和对象两个语法概念，不支持丰富的面向对象编程特性（比如继承、多态、封装），仅支持面向过程编程。

## 面向对象 VS 面向过程
用面向过程的语言也可以面向对象编程，只是没法借助语言的特性方便的实现。反过来，我们可能在用面向对象的语言，但是大多数时候是在面向过程编程。

面向对象编程并不是摒弃了所有的面向过程编程，比如，类中每个方法的实现逻辑，其实也是面向过程风格的代码。面向对象和面向过程两种编程风格，并不是非黑即白、完全对立的。

面向对象的优点
* OOP 更加能够应对大规模复杂程序的开发
* OOP 风格的代码更易复用、易扩展、易维护
* OOP 更加人性化、更加高级、更加智能
  
但是面向对象在设计上更耗费心力，不能简单地按过程一步步的编码，我们需要考虑合理地把相关的数据（属性）和方法（行为）封装到一个类里面，然后进一步设计类之间的交互关系等等。

### 相关阅读：  
《设计模式之美》（推荐）  
https://time.geekbang.org/column/article/161575  
https://time.geekbang.org/column/article/161114  
https://time.geekbang.org/column/article/161587  
https://time.geekbang.org/column/article/169600 

《设计模式必须通过面向对象来实现吗？》 CSDN博客  
https://blog.csdn.net/ghostyusheng/article/details/50817966

维基百科  
https://en.wikipedia.org/wiki/Object-oriented_programming  


# 基本原则
## SOLID
### 单一职责原则 SRP （Single Responsibility Principle）
原始定义：There should never be more than one reason for a class to change。

官方翻译：应该有且仅有一个原因引起类的变更。简单点说，一个类，最好只负责一件事，只有一个引起它变化的原因。

大多数软件设计的阶段，我们往往没法一步到位，把每个类都严格按照单一职责原则建立好。 

《设计模式之美》
`我们可以先写一个粗粒度的类，满足业务需求。随着业务的发展，如果粗粒度的类越来越庞大，代码越来越多，这个时候，我们就可以将这个粗粒度的类，拆分成几个更细粒度的类。这就是所谓的持续重构`


### 开闭原则 OCP （Open Closed Principle）
原始定义：Software entities (classes, modules, functions) should be open for extension but closed for modification。

字面翻译：软件实体（包括类、模块、功能等）应该对扩展开放，但是对修改关闭。


基本介绍  
* 开闭原则（Open Closed Principle）是编程中**最基础、最重要**的设计原则
* 一个软件实体如类，模块和函数应该对扩展开放（对提供方），对修改关闭（对使用方）。用抽象构建框架，用实现扩展细节。
* 当软件需要变化时，尽量通过扩展软件实体的行为来实现变化，而不是通过修改已有的代码来实现变化。

在 23 种经典设计模式中，大部分设计模式都是为了解决代码的扩展性问题而存在的，主要遵从的设计原则就是开闭原则。

#### 相关阅读
《设计模式之美》  
https://time.geekbang.org/column/article/176075

《重新认识开闭原则 (OCP)》 - 极客时间 许式伟  
https://time.geekbang.org/column/article/175236

### 里氏替换原则 LSP （Liskov Substitution Principle）
里式替换原则的英文翻译是：Liskov Substitution Principle，缩写为 LSP。这个原则最早是在 1986 年由 Barbara Liskov 提出，他是这么描述这条原则的：  
`If S is a subtype of T, then objects of type T may be replaced with objects of type S, without breaking the program。`  
在 1996 年，Robert Martin 在他的 SOLID 原则中，重新描述了这个原则，英文原话是这样的：  
`Functions that use pointers of references to base classes must be able to use objects of derived classes without knowing it。`

我们综合两者的描述，将这条原则用中文描述出来，是这样的：子类对象（object of subtype/derived class）能够替换程序（program）中父类对象（object of base/parent class）出现的任何地方，并且保证原来程序的逻辑行为（behavior）不变及正确性不被破坏。

举个例子：
在父类中，某个函数约定：运行出错的时候返回 null；获取数据为空的时候返回空集合（empty collection）。而子类重载函数之后，实现变了，运行出错返回异常（exception），获取不到数据返回 null。那子类的设计就违背里式替换原则。

#### 相关阅读
《设计模式之美》
https://time.geekbang.org/column/article/177110

### 接口隔离原则 ISP （Interface Segregation Principle）
原始定义：Clients should not be forced to depend upon interfaces that they don't use
还有一种定义是The dependency of one class to another one should depend on the smallest possible interface。

官方翻译：其一是不应该强行要求客户端依赖于它们不用的接口；其二是类之间的依赖应该建立在最小的接口上面。

接口的职责和实现接口的类的职责不一定是完全匹配的，一个类暴露的方法是它所要实现的接口的超集，而一个类本身是可以实现多个接口的。如果我们把一个类的所有方法直接暴露给使用方，对使用方来说是有额外成本的。而从调用方的角度，我们可以合理的去定义出符合单一职责的接口。

循序该原则的好处:
* 将臃肿庞大的接口分解为多个粒度小的接口，可以预防外来变更的扩散，提高系统的灵活性和可维护性。
* 接口隔离降低了系统间的耦合性。


### 依赖倒置原则 DIP （Dependence Inversion Principle）
原始定义：High level modules should not depend upon low level modules. Both should depend upon abstractions. Abstractions should not depend upon details. Details should depend upon abstractions。

官方翻译：高层模块不应该依赖低层模块，两者都应该依赖其抽象；抽象不应该依赖细节，细节应该依赖抽象。

循序该原则可以使高层模块和底层模块解耦，无感知地替换底层实现。

比如：
* List、Map等抽象
* 之前的分布式锁接口抽象的问题

## 其他原则
### 迪米特法则 LoD （Law of Demeter） / 最少知识原则 LKP （LeastKnowledge Principle）
原始定义：  
Each unit should have only limited knowledge about other units: only units “closely” related to the current unit. Or: Each unit should only talk to its friends; Don’t talk to strangers.

不该有直接依赖关系的类之间，不要有依赖；有依赖关系的类之间，尽量只依赖必要的接口（也就是定义中的“有限知识”）


### 从“高内聚”和“松耦合”角度来剖析以下几个原则关注的问题
* 单一职责原则 主要是指导类和模块，避免大而全，提高内聚性。
* 接口隔离和迪米特(最小知识)主要指导“松耦合”，解耦使用方的依赖。
* 基于接口而非实现编程：主要是解耦接口和实现，是指导思想，提高扩展性。

### DRY
Don't repeat yourself.

### KISS
Keep it simple and stupid.
* 尽量不要使用同事可能不懂的技术来实现代码。
* 不要重复造轮子，要善于使用已经有的工具类库。经验证明，自己去实现这些类库，出 bug 的概率会更高，维护的成本也比较高。
* 不要过度优化。不要过度使用一些奇技淫巧（比如，位运算代替算术运算、复杂的条件语句代替 if-else、使用一些过于底层的函数等）来优化代码，牺牲代码的可读性。

### YAGNi
You ain't gonna need it.

KISS 原则讲的是“如何做”的问题（尽量保持简单），而 YAGNI 原则说的是“要不要做”的问题（当前不需要的就不要做）。

# 设计模式
## 概览
设计模式是针对软件开发中经常遇到的一些设计问题，总结出来的一套解决方案或者设计思路。大部分设计模式要解决的都是代码的可扩展性问题。
设计模式只是碰到某类问题的一种参考答案，可以帮助我们更快、更好地解决这类问题， 但千万不要生搬硬套，过度设计。 有些模式其实很简单，有时候不知不觉中，我们在解决某类问题的时候就写出了符合某种设计模式的代码。

经典的设计模式有 23 种。随着编程语言的演进，一些设计模式（比如 Singleton）被认为是过时的，一些则被内置在编程语言中（比如 Iterator），另外还有一些新的模式诞生（比如 Monostate）。
## 创建型
常用的有单例模式、工厂模式（工厂方法和抽象工厂）、建造者模式。 
不常用的有：原型模式。
## 结构型
常用的有：代理模式、桥接模式、装饰者模式、适配器模式。
不常用的有：门面模式、组合模式、享元模式。
## 行为型
常用的有：观察者模式、模板模式、策略模式、职责链模式、迭代器模式、状态模式。
不常用的有：访问者模式、备忘录模式、命令模式、解释器模式、中介模式。

## 单例模式 *
### 使用场景
* 保证全局（进程）内唯一。比如ID生成器
* 节省系统资源。避免可复用对象的重复创建和销毁

### 六种实现方式
* 饿汉模式 
* 懒汉模式-线程不安全
* 懒汉模式-线程安全
* DCL模式
* 内部类 
* 枚举


### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/singleton/App.java

### 拓展阅读-为什么有人说单例模式是反模式
stackoverflow  
https://stackoverflow.com/questions/12755539/why-is-singleton-considered-an-anti-pattern
#### Monostate 单一状态模式
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/monostate/App.java


## 工厂模式 *
### 使用场景
* 封装变化：创建逻辑有可能变化，封装成工厂类之后，创建逻辑的变更对调用者透明。
* 代码复用：创建代码抽离到独立的工厂类之后可以复用。
* 隔离复杂性：封装复杂的创建逻辑，调用者无需了解如何创建对象。
* 控制复杂度：将创建代码抽离出来，让原本的函数或类职责更单一，代码更简洁。

### 分类
#### 简单工厂模式
通过参数来获取一种对象的不同实现。
缺点：
  扩展一种新的实现需要修改原本的代码，违背OCP
##### 代码示例
* [github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/factory/App.java
* [CSDN](https://blog.csdn.net/ShuSheng0007/article/details/86634864) 

#### 工厂方法模式
通过定义一个工厂接口，通过不同的工厂实现来获取一种对象的不同实现。
##### 代码示例
* [github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/factory/method/App.java  
github这个例子不是很好
* [CSDN](https://blog.csdn.net/ShuSheng0007/article/details/86636494)  
  
#### 抽象工厂模式
##### 代码示例
* [github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/abstractfactory/App.java
* [CSDN](https://blog.csdn.net/ShuSheng0007/article/details/86644481)  


## 建造者模式 *
### 使用场景
和工厂模式相似, 隔离对象构建的复杂性。 
* 当一个构造函数的参数比较多，比如大于4个或者更多，且当某些参数是可选的时候，可以考虑使用建造者模式。
* 当构建一个对象的需要多个步骤完成， 比如 StringBuilder。

### 建造者模式 VS 工厂模式
工厂模式是用来创建不同但是相关类型的对象（继承同一父类或者接口的一组子类），由给定的参数来决定创建哪种类型的对象。  
建造者模式是用来创建一种类型的复杂对象，通过设置不同的可选参数，“定制化”地创建不同的对象。

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/builder/App.java   

## 原型模式
高效地克隆一个对象。 java 里面的 clone，分 深拷贝 和 浅拷贝。 

## 代理模式 *

### [wiki](https://en.wikipedia.org/wiki/Proxy_pattern) What problems can the Proxy design pattern solve? 代理模式能解决什么问题？
* `The access to an object should be controlled.`  
* `Additional functionality should be provided when accessing an object.`   
  
`When accessing sensitive objects, for example, it should be possible to check that clients have the needed access rights.`

两层作用，权限控制及附加功能。

### 使用场景
* 缓冲代理：为某一个操作的结果提供临时的缓存存储空间，以便在后续使用中能够共享这些结果，优化系统性能，缩短执行时间。
* 保护代理：可以控制对一个对象的访问权限，为不同用户提供不同级别的使用权限。
* 智能引用：要为一个对象的访问（引用）提供一些额外的操作时可以使用
* 远程代理：为位于两个不同地址空间对象的访问提供了一种实现机制，可以将一些消耗资源较多的对象和操作移至性能更好的计算机上，提高系统的整体运行效率。
  * 比如 java 中的 RMI
* 虚拟代理：通过一个消耗资源较少的对象来代表一个消耗资源较多的对象，可以在一定程度上节省系统的运行开销。

### 静态代理代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/proxy/App.java 

### 动态代理
* java 动态代理
* cglib 等基于字节码织入的动态代理

### AOP 面向切面编程
#### 定义： [wiki](https://en.wikipedia.org/wiki/Aspect-oriented_programming)
`In computing, aspect-oriented programming (AOP) is a programming paradigm that aims to increase modularity by allowing the separation of cross-cutting concerns.`  
AOP是一种编程范式，其目标是通过隔离切面耦合来增加程序的模块化。

像日志打印这种和业务无关的逻辑，然后其处于分散在整个程序当中的各个模块，如果按照我们原始的方法开发，一旦后期需求变动将是及其繁琐的。所以我们就需要将这个切面耦合封装隔离，不要将其混入业务代码当中。

AOP主要可以用于：
* 日志记录
* 性能统计
* 安全控制
* 事务处理
* 异常处理等场景下。


## 装饰者模式 *
### [wiki](https://en.wikipedia.org/wiki/Decorator_pattern)
### 使用场景
* 需要在运行时动态的给一个对象增加额外的职责时候
* 需要给一个现有的类增加职责，但是又不想通过继承的方式来实现的时候（这时候其实应该优先使用组合而非继承），或者通过继承的方式不现实的时候（可能由于排列组合产生类爆炸的问题）。
### 代码示例

[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/decorator/App.java 增加 TrollWarrior

### 装饰者模式与代理模式的区别
从代码结构上看，装饰者模式和代理模式是一样的。我们需要从目的上区分
* 代理模式主要是对非业务功能的增强，而装饰模式主要是针对业务功能。
* 装饰模式一般会有多个Decorator实现，可以静态、动态的组装出不同类型的对象。 而代理往往只关注某一个功能的增强，只有一个Proxy实现。

## 桥接模式 *
### GoF 
`Decouple an abstraction from its implementation so that the two can vary independently.`

### 使用场景
结构两个（多个）维度的功能，使他们可以独立的变化。 通过组合防止类爆炸。

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/bridge/App.java

## 适配器模式 *
适配器模式的英文翻译是 Adapter Design Pattern。
顾名思义，这个模式就是用来做适配的，它将不兼容的接口转换为可兼容的接口，让原本由于接口不兼容而不能一起工作的类可以一起工作。
对于这个模式，有一个经常被拿来解释它的例子，就是 USB 转接头充当适配器，把两种不兼容的接口，通过转接变得可以一起工作。

### 使用场景
* 封装有缺陷的接口设计
* 统一多个类的接口设计
* 替换依赖的外部系统
* 兼容老版本接口

### 代码示例
#### 基于组合
```java
// 对象适配器：基于组合
public interface ITarget {  
  void f1();  
  void f2();  
  void fc();  
}

public class Adaptee {  
  public void fa() { //... }  
  public void fb() { //... }  
  public void fc() { //... }  
}

public class Adaptor implements ITarget {  
  private Adaptee adaptee;  
  
  public Adaptor(Adaptee adaptee) {  
    this.adaptee = adaptee;  
  }  
    
  public void f1() {  
    adaptee.fa(); //委托给Adaptee  
  }  
    
  public void f2() {    
  }  
    
  public void fc() {  
    adaptee.fc();  
  }  
}  
```  

#### 基于继承
```java
// 类适配器: 基于继承  
public interface ITarget {  
  void f1();  
  void f2();  
  void fc();  
}  
  
public class Adaptee {  
  public void fa() { //... }  
  public void fb() { //... }  
  public void fc() { //... }  
}  
  
public class Adaptor extends Adaptee implements ITarget {  
  public void f1() {  
    super.fa();  
  }  
    
  public void f2() {  
    //...重新实现f2()...  
  }
  
  // 这里fc()不需要实现，直接继承自Adaptee，这是跟对象适配器最大的不同点  
}  
```
  
  
## 外观模式 （门面模式）
### GoF 定义
`Provide a unified interface to a set of interfaces in a subsystem. Facade Pattern defines a higher-level interface that makes the subsystem easier to use.`  

门面模式为子系统提供一组统一的接口，定义一组高层接口让子系统更易用。 

#### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/facade/App.java

#### 和适配器模式的区别
* 外观模式： 简化子系统的使用
* 适配器模式： 适配接口，目的是兼容

## 组合模式
### 使用场景
* 当你的程序结构有类似树一样的层级关系时，例如文件系统，视图树，公司组织架构等等
* 当你要以统一的方式操作单个对象和由这些对象组成的组合对象的时候。

#### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/composite/App.java

## 享元模式
享元模式的意图是复用对象，节省内存，前提是享元对象是不可变对象。
比如 java Integer -128 127，java 字符串常量池

#### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/flyweight/App.java

## 观察者模式 *
### 使用场景
在对象之间定义一个一对多的依赖，当一个对象状态改变的时候，所有依赖的对象都会自动收到通知。

在实际的项目开发中，这两种对象的称呼是比较灵活的，有各种不同的叫法，比如：Subject-Observer、Publisher-Subscriber、Producer-Consumer、EventEmitter-EventListener、Dispatcher-Listener
### 比如
qconfig
### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/flyweight/App.java

## 模板模式 *
模板方法模式在一个方法中定义一个算法骨架，并将某些步骤推迟到子类中实现。模板方法模式可以让子类在不改变算法整体结构的情况下，重新定义算法中的某些步骤。
### 使用场景
当你发现你写了两个或者多个几乎一样的类，只是有些方法的实现方式不一致的时候，而且在使用这些类的地方调用方法顺序都一样，这时候就可以用这个方式重构了。
### 经典例子
javax.servlet.http.HttpServlet 还记得 doPost doGet doPut 吗？

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/templatemethod/App.java

## 策略模式 *
策略模式定义了一系列的算法，并将每一个算法封装起来，使他们可以相互替换。

### 使用场景
当你写代码的时候发现一个操作有好多种实现方法，而你需要根据不同的情况使用if-else等分支结构来确定使用哪种实现方式的时候。这时候可以考虑使用策略模式

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/strategy/App.java

## 职责链模式 *
`Avoid coupling the sender of a request to its receiver by giving more than one object a chance to handle the request. Chain the receiving objects and pass the request along the chain until an object handles it.`  
将请求的发送和接收解耦，让多个接收对象都有机会处理这个请求。将这些接收对象串成一条链，并沿着这条链传递这个请求，直到链上的某个接收对象能够处理它为止。

在职责链模式中，多个处理器依次处理同一个请求。一个请求先经过 A 处理器处理，然后再把请求传递给 B 处理器，B 处理器处理完后再传递给 C 处理器，以此类推，形成一个链条。链条上的每个处理器各自承担各自的处理职责，所以叫作职责链模式。

在 GoF 的定义中，一旦某个处理器能处理这个请求，就不会继续将请求传递给后续的处理器了。当然，在实际的开发中，也存在对这个模式的变体，那就是请求不会中途终止传递，而是会被所有的处理器都处理一遍。

所以很多框架都会使用责任链模式做Filter， Intercepter

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/chain/App.java

## 迭代器模式 *
迭代器是用来遍历集合对象里面的元素。迭代器可以将集合遍历和集合本身解耦，比如对一个树的集合，可以实现前序、中序、后续三种iterator。

java的Collection里面广泛用到

### 代码示例
接口定义
```java
// 接口定义方式一  
public interface Iterator<E> {  
  boolean hasNext();  
  void next();  
  E currentItem();  
}  
  
// 接口定义方式二  
public interface Iterator<E> {  
  boolean hasNext();  
  E next();  
}  
```  
调用
```java
Iterator iterator = getIterator(names);  
while (iterator.hasNext()) {  
    System.out.println(iterator.currentItem());  
    iterator.next();  
}  
```

java中的遍历语法糖使用了迭代器模式
```java
List names = new ArrayList<>();  
names.add("a");  
names.add("b");  
names.add("c");  
  
for (String name : names) {   
  System.out.print(name + ",");  
}  
```

## 状态模式
[geektime](https://time.geekbang.org/column/article/218375)

## 备忘录模式
保存对象的状态到一个快照对象中，等需要的时候可以从备份对象中恢复。

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/memento/App.java

## 命令模式
The command pattern encapsulates a request as an object, thereby letting us parameterize other objects with different requests, queue or log requests, and support undoable operations.

命令模式将请求（命令）封装为一个对象，这样可以使用不同的请求参数化其他对象（将不同请求依赖注入到其他对象），并且能够支持请求（命令）的排队执行、记录日志、撤销等（附加控制）功能。对于 GoF 给出的定义，我这里再进一步解读一下。落实到编码实现，命令模式用的最核心的实现手段，是将函数封装成对象

### 示例
画图软件和编辑器中的 redo， undo 操作，其实就是将操作（命令）保存成对象，然后可以做到 redo， undo的操作。
游戏开发中也经常将游戏中的操作（命令）存储成对象，传输到游戏服务器。

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/command/App.java

## 解释器模式
一般在编译器中用到，用来做语法分析。

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
com/iluwatar/interpreter/App.java

## 中介模式 (mediator)
[geektime](https://time.geekbang.org/column/article/226710)

## 访问者模式
访问者者模式的英文翻译是 Visitor Design Pattern。在 GoF 的《设计模式》一书中，它是这么定义的：  
`Allows for one or more operation to be applied to a set of objects at runtime, decoupling the operations from the object structure.`  
翻译成中文就是：允许一个或者多个操作应用到一组对象上，解耦操作和对象本身。

### 使用场景
访问者模式针对的是一组类型不同的对象。它们继承相同的父类或者实现相同的接口。在不同的应用场景下，我们需要对这组对象进行一系列不相关的业务操作，但为了避免不断添加功能导致类不断膨胀，职责越来越不单一，以及避免频繁地添加功能导致的频繁代码修改，我们使用访问者模式，将对象与操作解耦，将这些业务操作抽离出来，定义在独立细分的访问者类中。 -- 《设计模式之美》

visitor模式实现了伪动态双分派。 而在支持动态双分派语言中，这个模式是没有意义的

### 代码示例
[github](https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md)
这个例子不够清楚 com/iluwatar/visitor/App.java
我们看下这个例子 com/iluwatar/visitor2/App.java


## 参考资料：
《Head First Design Patterns》

《设计模式之美》 - 极客时间 王争  
https://time.geekbang.org/column/article/175236

维基百科  
https://en.wikipedia.org/wiki/Object-oriented_programming  
https://en.wikipedia.org/wiki/SOLID

《重新认识开闭原则 (OCP)》 - 极客时间 许式伟  
https://time.geekbang.org/column/article/175236

《用DDD（领域驱动设计）和ADT（代数数据类型）提升代码质量》- 携程技术 工业聚  
https://mp.weixin.qq.com/s/VzVcT36jPptpcmS46d22Rw

github 设计模式示例 java-design-patterns  
https://github.com/iluwatar/java-design-patterns/blob/master/localization/zh/README.md  

《设计模式必须通过面向对象来实现吗？》 CSDN博客  
https://blog.csdn.net/ghostyusheng/article/details/50817966
