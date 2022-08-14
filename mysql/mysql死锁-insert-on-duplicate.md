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


## 死锁重现1

| 时刻 | sessionA | sessionB | sessionC | 
| ---- | ----- | ----- | ----- |
|  t1| BEGIN; insert into t1(a,b) values(28,0) on duplicate key update b=1; |  |  | 
|  t2|  | BEGIN; insert into t1(a,b) values(28,0) on duplicate key update b=1; |  | 
|  t3|  |  | BEGIN; insert into t1(a,b) values(28,0) on duplicate key update b=1; | 
|  t4| rollback; |  |  | 


## 死锁分析1
https://dev.mysql.com/doc/refman/5.7/en/innodb-locks-set.html