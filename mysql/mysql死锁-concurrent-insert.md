# case: concurrent insert
mysql官方文档提到并发insert会产生一种死锁。 
https://dev.mysql.com/doc/refman/5.7/en/innodb-locks-set.html

## 准备
DROP TABLE IF EXISTS t1;  
CREATE TABLE t1 (i INT, PRIMARY KEY (i)) ENGINE = InnoDB;

## 死锁重现
| 时刻 | sessionA | sessionB | sessionC | 
| ---- | ----- | ----- | ----- |
|  t1| BEGIN; insert into t2 values (1); |  |  | 
|  t2|  | BEGIN; insert into t2 values (1); **(blocking)** |   | 
|  t3|  |  | BEGIN; insert into t2 values (1); **(blocking)** | 
|  t4| rollback; |  |  | 
|  t5|  | ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction |  |
|  t6|  |  |  Query OK, 1 row affected | 

## 死锁分析
* t1 sessionA 获取插入意向锁（-INF，INF），插入主键索引成功，获取i=1记录X锁
* t2 sessionB 获取插入意向锁（-INF，INF），索引i=1已经存在，尝试给i=1加S锁。由于sessionA持有该记录的X锁，所以sessionB被阻塞
* t3 sessionC 和 sessionB 一样。
* t4 时刻 sessionA释放X锁。 sessionB和sessionC同时获得S锁。用同时尝试取获取X锁，产生死锁。

