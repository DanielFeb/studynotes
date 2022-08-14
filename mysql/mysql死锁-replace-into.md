# case: replace into(RR, RC级别均能复现)
## 准备
DROP TABLE IF EXISTS t1;  
CREATE TABLE t1 (  
  id INT NOT NULL AUTO_INCREMENT,  
  a INT NULL,  
  b INT NULL,  
  PRIMARY KEY (id),  
  UNIQUE INDEX uk_a (a ASC));  

INSERT INTO t1 (id, a, b) VALUES (1, 10, 0);   
INSERT INTO t1 (id, a, b) VALUES (2, 20, 0);   
INSERT INTO t1 (id, a, b) VALUES (3, 30, 0);   
INSERT INTO t1 (id, a, b) VALUES (4, 40, 0);    
INSERT INTO t1 (id, a, b) VALUES (5, 50, 0);  


## 死锁重现1

| 时刻 | sessionA | sessionB | sessionC | 
| ---- | ----- | ----- | ----- |
|  t1| BEGIN; REPLACE INTO t1 (a, b) VALUES (40, 1); |  |  | 
|  t2|  | BEGIN; REPLACE INTO t1 (a, b) VALUES (30, 1); |  | 
|  t3|  |  | BEGIN; REPLACE INTO t1 (a, b) VALUES (40, 1); | 
|  t4| commit; |  |  | 
|  t5|  | 2 rows affected; | Deadlock,rollback; | 


## 死锁分析

* t1 sessionA 进行 duplicate key checking，有冲突，获取到(30, 40], (40, 50] next-key (X)lock。uk_a=40唯一索引冲突，所以删除a=40记录。之后再获取(30, 50)插入意向锁成功，插入a=40的记录。
  * A: (30, 40], (40, 50]
  
* t2 sessionB 进行 duplicate key checking，有冲突，尝试获取(20, 30]成功, 但是获取(30, 40] next-key (X)lock失败，只能拿到（30，40）gap lock, 被sessionA在a=40的X记录锁block住。
  * B: (20, 30], (30, 40), wait A a=40

* t3 sessionC 进行 duplicate key checking，有冲突，尝试获取到(30, 40], (40, 50] next-key (X)lock。此时sessionA持有(30, 40] next-key (X)lock，所以只能先拿到(30,40)的gap lock, 之后被sessionA在a=40的X记录锁block住。
  * C: (30, 40), wait A a=40
  
* t4 sessionA commit, 释放所有的锁。 sessionB先获得到a=40的X记录锁。
  * 此时sessionB持有(20, 40], (30, 40] next-key(X) lock
  * 此时sessionC持有(30, 40) gap lock, 被sessionB的uk_a=40 记录锁block。
  * sessionB执行删除操作，但是插入需要获取(20, 40)的插入意向锁，被sessionC持有(30, 40) gap lock block住。
  * 死锁条件达成。


为什么RC下会有Gap lock:
> Gap locking can be disabled explicitly. This occurs if you change the transaction isolation level to READ COMMITTED or enable the innodb_locks_unsafe_for_binlog system variable (which is now deprecated). In this case, gap locking is disabled for searches and index scans and is used only for foreign-key constraint checking and duplicate-key checking.


## 死锁重现2

| 时刻 | sessionA | sessionB | sessionC | 
| ---- | ----- | ----- | ----- |
|  t1| BEGIN; SELECT * FROM t1 WHERE a=40 for update; |  |  | 
|  t2|  | BEGIN; REPLACE INTO t1 (a, b) VALUES (30, 1); |  | 
|  t3|  |  | BEGIN; REPLACE INTO t1 (a, b) VALUES (40, 1); | 
|  t4| commit; |  |  | 
|  t5|  | 2 rows affected; | Deadlock,rollback; | 


## 死锁分析2

* t1 sessionA 在 a=40上加X记录锁
  
* t2 sessionB 进行 duplicate key checking，有冲突，尝试获取(20, 30]成功, 但是获取(30, 40] next-key (X)lock失败，只能拿到（30，40）gap lock, 被sessionA在a=40的X记录锁block住。
  * B: (20, 30], (30, 40), wait A a=40

* t3 sessionC 进行 duplicate key checking，有冲突，尝试获取到(30, 40], (40, 50] next-key (X)lock。此时sessionA持有(30, 40] next-key (X)lock，所以只能先拿到(30,40)的gap lock, 之后被sessionA在a=40的X记录锁block住。
  * C: (30, 40), wait A a=40
  
* t4 sessionA commit, 释放所有的锁。 sessionB先获得到a=40的X记录锁。
  * 此时sessionB持有(20, 40], (30, 40] next-key(X) lock
  * 此时sessionC持有(30, 40) gap lock, 被sessionB的uk_a=40 记录锁block。
  * sessionB执行删除操作，但是插入需要获取(20, 40)的插入意向锁，被sessionC持有(30, 40) gap lock block住。
  * 死锁条件达成。


# 解决方案
* DBA建议改成 insert... on duplicate key update ...
* 并发不高的情况下：先查数据，根据数据有无再进行操作。
* 并发较高，加额外的悲观锁 / 乐观锁
* 使用分布式锁