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

* 缓存穿透
    * 保存 null 值, 设置过期
    * bloom filter 布隆过滤器
* 缓存雪崩
    * 高并发下不建议-加锁或者使用消息队列，让数据库不至于挂掉
    * 设置过期标志更新缓存、为key设置不同的缓存失效时间
    * 二级缓存
    * 应用层缓存过期时间 https://www.iteye.com/blog/wsluozefeng-2227443
* 缓存击穿  
 缓存击穿指并发查同一条数据，缓存雪崩是不同数据都过期了，很多数据都查不到从而查数据库
    * 二级缓存
    * 应用层缓存过期时间 https://www.iteye.com/blog/wsluozefeng-2227443