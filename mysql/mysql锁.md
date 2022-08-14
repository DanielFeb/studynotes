# 死锁形成的条件
* 互斥/排他
* 占有并等待
* 不可抢占
* 循环等待

# mysql中有哪些锁

我们主要关注innodb存储引擎下的锁 (5.7)  
参考资料：
* 官方文档  
https://dev.mysql.com/doc/refman/5.7/en/innodb-locking.html  
https://dev.mysql.com/doc/refman/5.7/en/innodb-locks-set.html  
https://dev.mysql.com/doc/refman/5.7/en/innodb-deadlocks.html   
* 《极客时间-MySQL实战45讲》


## 表锁
lock tables 语法除了会限制别的线程的读写外，也限定了本线程接下来的操作对象
加锁命令：
> lock tables *t1* read, *t2* write
解锁命令：
> unlock tables

其中，**lock...read** 即加表级的S锁，**lock...write**即加表级的X锁。

## 意向锁
意向锁是表级锁。表明事务接下来会对表内数据进行何种操作，这样在对表加S或者X锁时就无需遍历所有的行级锁。

For example：  
以下语句会给相应的表加 IS 锁，当然之后也会加上相应的行级（S）锁。  
> select ... lock in shared mode;  

以下语句会给相应的表加 IX 锁，当然之后也会加上相应的行级（X）锁。
> select ... for update;  
 
表锁和意向锁的兼容情况如下

|  | X | IX | S | IS |
| ----- | ----- | ----- | ----- | ----- |
| X | Conflict | Conflict | Conflict | Conflict |
| IX | Conflict | Compatible | Conflict | Compatible |
| S | Conflict | Conflict | Compatible | Compatible |
| IS | Conflict | Compatible | Compatible | Compatible |

## 排他锁和共享锁
行级锁分为 排他锁（X）锁 和共享锁（S）锁。

## 记录锁（Record Lock）
记录锁是加在索引记录上的。分为X和S锁。

## 间隙锁（Gap Lock）
这里值得注意的是，不同的事务可以在间隙上持有相互冲突的锁。间隙锁的目的就是防止其他事务在该间隙内插入数据。

事务RR级别以上才会有间隙锁。RC级别有一些特殊情况也会有间隙锁。  
RC下出现Gap lock的情况:
> Gap locking can be disabled explicitly. This occurs if you change the transaction isolation level to READ COMMITTED or enable the innodb_locks_unsafe_for_binlog system variable (which is now deprecated). In this case, gap locking is disabled for searches and index scans and is used only for foreign-key constraint checking and duplicate-key checking.

## Next-Key Lock
Next-Key Lock 由索引的记录锁和该索引之前的间隙锁共同组成。所以Next-Key Lock的范围是个左开右闭区间。  
锁是怎么加的呢：
> InnoDB performs row-level locking in such a way that when it searches or scans a table index, it sets shared or exclusive locks on the index records it encounters.

这里引用文章里的几条加锁规则:
* 原则 1：加锁的基本单位是 next-key lock。next-key lock 是前开后闭区间。
* 原则 2：查找过程中访问到的对象才会加锁。
* 优化 1：索引上的等值查询，给唯一索引加锁的时候，next-key lock 退化为行锁。
* 优化 2：索引上的等值查询，向右遍历时且最后一个值不满足等值条件的时候，next-key lock 退化为间隙锁。
* 一个 bug：唯一索引上的范围查询会访问到不满足条件的第一个值为止。

相关：《极客时间-MySQL实战45讲》 https://time.geekbang.org/column/article/75659

## 插入意向锁（Insert Insertion Lock）
插入意向锁是在数据行插入之前由 INSERT 语句设置的一种特殊间隙锁。插入意向锁之间不互斥。 

**行级锁之间的兼容情况**（每一列的表头为已被其他session持有的锁）：

| | Gap | Insert Insertion | Record (S) | Record (X) | Next-Key (S) | Next-Key (X) |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Gap | Compatible | Compatible | Compatible | Compatible | Compatible | Compatible |
| Insert Insertion | Conflict | Compatible | Conflict | Conflict | Conflict | Conflict |
| Record (S) | Compatible | Compatible | Compatible | Conflict | Compatible | Conflict |
| Record (X) | Compatible | Compatible | Conflict | Conflict | Conflict | Conflict |
| Next-Key (S) | Compatible | Compatible | Compatible | Conflict | Compatible | Conflict |
| Next-Key (X) | Compatible | Compatible | Conflict | Conflict | Conflict | Conflict |

## 自增锁（AUTO-INC Lock）
表级锁。

## 元数据锁（meta data lock, MDL）（补充）
MDL不需要显式加锁，在访问一个表的时候会被自动加上。MDL 的作用是，保证读写的正确性。
使用DML访问一张表的时候，会自动加MDL的读锁。当使用DDL操作一张表时，会自动加MDL写锁。

## 全局锁（补充）
Mysql提供了一个加全局读锁的方法，命令如下：
> Flush tables with read lock
解锁命令
> unlock tables

全局锁(FTWRL)的典型使用场景是，做全库逻辑备份。（如果库中存在不支持事务的表，需要使用该方法拿到一致性视图。）但是会导致全库只读。

# mysql中的语句会加什么锁
https://dev.mysql.com/doc/refman/5.7/en/innodb-locks-set.html

* select  普通的select不加锁
  
* select... lock in share mode 对扫描到的索引加 S 锁
  
* select... for update 对扫描到的索引加 X 锁
  
* update 对扫描到的索引加 X 锁
  
* insert
  * 对插入的数据加 X 记录锁
  * 在插入数据之前，会给对应索引间隙加插入意向锁
  * 如果出现 duplicate-key error, 那么会在对应的记录上加S锁
  
* delete 对扫描到的索引加 X 锁
  
* INSERT ... ON DUPLICATE KEY UPDATE 
  * 和 insert 不同的是
  > An exclusive index-record lock is taken for a duplicate primary key value. An exclusive next-key lock is taken for a duplicate unique key value.
* REPLACE
  > REPLACE is done like an INSERT if there is no collision on a unique key. Otherwise, an exclusive next-key lock is placed on the row to be replaced.

# mysql死锁
## 分析死锁的命令
* 运行前，记得开启监控
> -- 开启锁监控  
> set GLOBAL innodb_status_output_locks=ON;  
> -- 开启监控  
> set GLOBAL innodb_status_output=ON;  
> -- 记录死锁日志  
> set GLOBAL innodb_print_all_deadlocks=ON;

* 运行中，可以查看运行中的锁信息
> select * from information_schema.innodb_lock_waits;  
> select * from information_schema.innodb_locks;

* 运行后，可以查看死锁日志进行分析
  * 查看最近一次的死锁日志
    > show engine innodb status\G;  
  * 查看死锁日志文件

## 死锁场景分析

## 如何避免死锁
* 在编程中尽量按照固定的顺序来处理数据库记录，假设有两个更新操作，分别更新两条相同的记录，但更新顺序不一样，有可能导致死锁；
> when different transactions update multiple tables or large ranges of rows, use the same order of operations (such as SELECT ... FOR UPDATE) in each transaction

* 更新表时，尽量使用主键更新；
  
* 避免长事务，尽量将长事务拆解，可以降低与其它事务发生冲突的概率；
  
* 设置锁等待超时参数，我们可以通过 innodb_lock_wait_timeout 设置合理的等待超时阈值，特别是在一些高并发的业务中，我们可以尽量将该值设置得小一些，避免大量事务等待，占用系统资源，造成严重的性能开销
  
* 开启mysql的死锁检测机制
  
* 在允许幻读和不可重复读的情况下，尽量使用 RC 事务隔离级别，可以避免 gap lock 导致的死锁问题；
