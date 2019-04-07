#缓存
* Guava缓存工具 LoadingCache
* Redis

###分布式锁

##架构
* 浏览器缓存
* Nginx动静分离
    * 文件同步问题
* CDN缓存
* 进程缓存
* 分布式缓存
* 二级缓存
    * 和分布式缓存构成二级缓存 （J2Cache）
        * 缓存一致性问题, 监听redis的keyspace
* 数据库缓存
    * memcache + mysql

##问题
* 缓存雪崩
* 缓存穿透
* 缓存击穿
* 