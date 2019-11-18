#分布式锁
* 排他性/独占性
* 阻塞性，未抢到锁的线程在锁释放时，再次争夺（惊群效应）
* 可重入性
##数据库乐观锁
    TODO
##Zookeeper
* Curator框架 http://cmsblogs.com/?p=4117
    * zNode不可同名来确保独占性
    * 通过watch锁节点的删除事件来处理阻塞
        * 处理惊群效应  
          使用临时有序节点，watch前一个有序节点的删除事件。判断是否是最小节点，如果是，那么获取到锁
            * 如果前一个节点的客户端线程因为所在服务器宕机而导致临时节点被删除， 那么猜想：当前线程会判断自己不是最小节点，然后寻找比它小的最近节点，进行监听。
    * 可重入性
        * zNode可以设置值

##Redis
* Redission http://blog.itpub.net/31545684/viewspace-2221023/
    * 可重入锁实现 
        * hset lockname clientID 1 nx, 使用lua脚本保证原子性
        * 通过给hashes里面的clientId对应的数值进行加减实现锁的可重入性

* 简单实现 http://cmsblogs.com/?p=7460
       
* 问题：
    * 因为在redis主从集群或者redis cluster运用的主从复制，在master宕机、主从切换的时候有可能发生数据丢失（master数据还没来得及拷贝到slave上）。
所以redis分布式锁可能会引起多个客户端同时获取到同一个锁。
    * 无法解决惊群问题

