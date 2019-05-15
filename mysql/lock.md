##如何给mysql innodb加表锁
    LOCK TABLES table1 write, table2 read;
表锁是一次性加上的，再次调用'lock tables'会释放掉之前加的锁。因此表锁之间是不会产生死锁的。  
*加锁之后只能操作加锁的内容，如上，不能操作除了table1和table2以外的数据，甚至不能写table2。
