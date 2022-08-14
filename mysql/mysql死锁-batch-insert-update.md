# case: insert ... on duplicate
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

## 死锁重现
| 时刻 | sessionA | sessionB | sessionC | 
| ---- | ----- | ----- | ----- |
|  t1| BEGIN; select * from t1 where a=20 lock in share mode; |  |  | 
|  t2|  | BEGIN; insert into t1(a) values(30), (20), (10) on duplicate key update b=0; **(blocking)** |   | 
|  t3|  |  | BEGIN; update t1 **force index (uk_a)** set b=1  where a=30 or a=20 or a=10; **(blocking)** | 
|  t4| commit; |  |  | 
|  t5|  | success; | Deadlock, rollback; |


## 死锁分析

* 这个从代码上看，数据都是根据uk_a降序排列。而实际上，对于sessionB的insert语句来说，确实是按照sql中顺序进行插入。 而对于update语句，实际上经过sql优化，是根据uk_a升序进行查询更新的。最终会导致锁循环依赖。

* 注：
  * sessionA 的语句线上并没有，只是为了让这个场景容易复现加上的。
  * 这里的force index (uk_a) 是为了模拟线上走索引的情景。否则这里数据量太少，mysql会选择全表扫描。

# 解决方案
* 如果确实需要批量插入和查询，注意加锁的顺序。
  * 这里把sessionB的语句调整为升序就可以了。