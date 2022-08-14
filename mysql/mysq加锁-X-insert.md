# case: 插入一条存在X记录锁的数据(RR隔离级别下)
## 准备
DROP TABLE IF EXISTS t1;  
CREATE TABLE t1 (  
  id INT NOT NULL AUTO_INCREMENT,  
  a INT NULL,  
  b INT NULL,  
  PRIMARY KEY (id),  
  UNIQUE INDEX uk_a (a ASC),  
  INDEX idx_b (b ASC));  

INSERT INTO t1 (id, a, b) VALUES (1, 10, 0);   
INSERT INTO t1 (id, a, b) VALUES (2, 20, 0);   
INSERT INTO t1 (id, a, b) VALUES (3, 30, 0);   
INSERT INTO t1 (id, a, b) VALUES (4, 40, 0);    
INSERT INTO t1 (id, a, b) VALUES (5, 50, 0);  

## 场景1

| 时刻 | sessionA | sessionB | sessionC | sessionD | 
| ---- | ----- | ----- | ----- | ----- |
| t1 | BEGIN; delete from t1 where a=30; |  |  |  | 
| t2 |  | BEGIN; insert into t1(a,b) values(30,0); **(blocking)** |  |  | 
| t3 |  |  | BEGIN; insert into t1(a,b) values(25,0); **(blocking)** |  | 
| t4 |  |  |  | BEGIN; insert into t1(a,b) values(39,0); **(OK)**  | 
| t5 | commit; |  |  |  | 
| t6 |  | **(blocking)** |  |   |
| t7 |  |  |  | commit; |
| t8 |  | 1 rows affected; |  |  |
| t9 |  |  |  | BEGIN; insert into t1(a,b) values(38,0); **(blocking)** | 



### 分析

* t1 时刻 sessionA 持有 uk_a=30的 X 记录锁
  
* t2 时刻 sessionB 插入数据时发现uk_a=30冲突，尝试在(20, 30]加S锁。加上了(20,30) gap lock, 被sessionA的 uk_a=30X记录锁block。
  
* t3 时刻sessionC尝试加插入意向锁(20, 30),被sessionB的(20, 30)gap lock block。
  
* t4 时刻sessionD获取插入意向锁(30, 40)成功，插入数据并获得uk_a=39的 X 记录锁。
  
* t5-t6 sessionA提交，释放uk_a=30的X记录锁。 sessionB获取到uk_a=30的S记录锁, 尝试在(30, 39]加S锁，被sessionD block。
  
* t7-t8 sessionD提交，释放uk_a=39的X记录锁。 sessionB获取到uk_a=39的S记录锁, 成功获取到(20, 30], (30, 39]的S lock，插入成功。
  
* t9 sessionD插入时，尝试获取(30, 39)的插入意向锁失败，被 sessionB block。


## 场景2

| 时刻 | sessionA | sessionB | sessionC |
| ---- | ----- | ----- | ----- |
| t1 | BEGIN; delete from t1 where a=30; |  |  |
| t2 |  | BEGIN; insert into t1(a,b) values(30,0); **(blocking)** |  |
| t3 |  |  | begin; select * from t1 where a > 30 and a<40 lock in share mode; |
| t4 | commit; | **(blocking)** |  |
| t5 |  |  | insert into t1(a,b) values(35,0); |
| t6 |  | 1 row affected; |  Deadlock, rollback; |



### 分析

* t1 时刻 sessionA 持有 uk_a=30的 X 记录锁
  
* t2 时刻 sessionB 插入数据时发现uk_a=30冲突，尝试在(20, 30]加S锁。加上了(20,30) gap lock, 被sessionA的 uk_a=30X记录锁block。
  
* t3 时刻sessionC 在(30, 40] 上加(S)锁
  
* t4 时刻sessionA提交。 sessionB获取到(20, 30], (30, 40]的(S)锁。此时需要获取(20, 40)上的插入意向锁，被sessionC 的(30, 40](S)锁 block住。
  
* t5-t6 时刻sessionC尝试插入a=35数据，需要获取(20, 40)上的插入意向锁，被sessionA (20, 30], (30, 40]的(S)锁block。 产生了死锁。