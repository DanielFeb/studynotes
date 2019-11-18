#redis
开发语言：ANSI C
## 启动
指定配置文件 redis-service config-file.conf

## command 类型
* string
* list
* hashed
* set
* sortedset
* geo
* stream
* pub/sub 发布订阅
    * 事件监听
        * 通过配置文件来启动开启redis内部事件发布机制
* info

## 内存管理
* 大小限制
    * Strings， 一个String的value最大为512M
    * Lists， 元素个数最大为2^32-1个
    * Sets， 元素个数最大为2^32-1个
    * Hashes， 元素个数最大为2^32-1个
    * 最大内存控制
        * maxmemory 最大内存阈值
        * maxmemory-policy 达到阈值时的策略
            * noeviction 客户端报错 
            * lru 删除很久没有访问的数据
                * volatile-lru 从设置了过期时间的数据中执行
                * allkeys-lru 从所有数据中执行
            * lfu 删除访问频次最少的数据， 基于概率的对数计数器 mirror counter算法
                * 同lru
                * 启动lfu算法后，可以使用热点数据分析功能
            * random 随机回收
                * 同lru
            * volatile-ttl
                *  回收已经过期的key，并且回ttl较短的数据
* 内存压缩
    * 通过配置，每种类型数据超过一定大小，就不进行压缩
* 过期数据处理策略
    * 主动检测处理 每10S执行一次
        *  从有过期时间的key集合中随机取20个key，删除其中过期的key， 如果过期的数目超过25%，那么再随机抽取20个。。。循环
    * 被动处理， 每次访问key时， 发现过期就清理
    * 数据恢复时处理过期数据的策略
        * RDB 不care
        * AOF
            * 每次遇到过期的数据，就在AOF末尾加一条DEL命令
        
## 持久化
* RDB  
    * 内存快照  
    * 命令 BGSAVE SAVE  
    * 自动触发时机 可通过配置文件进行配置， 默认配置为  
        * save 900 1  900秒1次写入
        * save 300 10
        * save 60 10000
        * 每隔一段时间进行一次检查，不是每次写入都检查
    * 优点
        * 对性能影响小
        * 从RDB恢复时速度快
    * 缺点
        * 会丢失数据
        * 数据集非常大且CPU不够强时，子进程消耗较长时间生成快照，影响redis性能
* AOF
    * 配置
        * appendonly yes 默认不开启
        * appendfsync
            * everysec 默认值 每秒钟写一次
            * always 每次修改都写入aof文件
            * no 从不同步
    * 优点
        * 安全
        * 容灾
        * 易读性，可修改
    * 缺点
        * 文件体积大
        * 性能消耗比RDB高
        * 数据恢复比RDB慢
## 集群
https://www.cnblogs.com/51life/p/10233340.html
* 主从复制集群
    * 目的
        * 解决单点故障问题
        * 解决单节点qps有限 （主从 读写分离）
    * 搭建
        * 主服务器， 普通模式启动
        * 从服务器
            * 命令行
                * 加入 slaveof host port
                    * 新版本 replicaof ...
                * 退出 slaveof no one
                    * 新版本 replicaof ...
            * 配置文件
                * slaveof host port
                    * 新版本 replicaof ...
                * 从服务器只读 slave-read-only yes
                    * 新版本 replica-read-only ...
    * 主从复制流程
        * 从服务器发送psync命令到主服务器（包含同步源runid，同步进度offset）
        * master收到请求，发现同步源为自己，那么根据offset进行增量同步
            * 如果同步源不是自己，那么全量同步。生成rdb传送给slave
    * 其他核心知识
        * 一主多从
            * 从可以有sub slave
        * redis默认使用异步复制
            * master侧非阻塞复制
            * slave阻塞复制
        * 可以关闭master的持久化，把持久化放到slave上
            * ！！此时要关闭master的故障重启配置，否则会导致集群数据丢失
    * 注意事项
        * 读写分离场景
            * 由于网络原因，从slave读取不到最新的数据，或者数据过期。
            * slave节点故障， client如何迁移
        * 什么时候会发生全量复制
            * 第一次建立主从关系时，runid不匹配
            * master故障, 切换master时全量复制（master挂掉时， 切换master，会引发大量主从复制，对服务器性能和网络压力有很大影响）
        * 主服务器写能力有限
        * 有ttl的key
            * slave不会自行进行过期回收
            * lua脚本执行期间，不会对key进行过期操作
* 哨兵机制 Sentinel
    * 作用
        * 监控redis主从集群，发现主服务器故障自动进行主从切换
        * 客户端连接哨兵系统，通过哨兵系统发现主服务器
        * 可以同时监控多个主从集群
    * 单点问题
        * 集群部署哨兵
        * 检测到master挂了，哨兵达到一定数量就确认master挂掉， 可配置
    * 核心运作流程
        * 服务发现和健康检查流程
            * 搭建主从集群
            * 启动哨兵，客户端通过哨兵发现redis实例信息
            * 哨兵通过master发现主从集群内所有节点信息（info replication）
            * 哨兵监控redis实例的健康状况
            * 哨兵会动态变更自己的config文件
        * 故障切换流程
            * 哨兵发现master挂了，通知其他哨兵
            * 当一定数量哨兵认为master挂了
            * 选举一个哨兵作为执行者
            * 执行者选取一个slave
            * 进行主从切换
    * 七大核心问题
        * 哨兵如何知道redis主从信息
            * 配置了master，从master info replication 获取的
        * 什么是主观下线
            * 单个哨兵认为master挂了
            * 通过ping命令
            * 配置文件可以配置超时时间
        * 什么是客观下线
            * 一定数量的哨兵认为master下线
            * 数量可配置 
            * 哨兵互相发现，通过redis主从集群（pub/sub \_sentinel_:hello）
            * 哨兵可以直接互相通讯
        * 哨兵领导选举机制
            * Raft算法
                * 每个sentinel随机睡眠一段时间后开始拉票 每个哨兵都希望成为领导者
                * 哨兵同意第一个接收到的拉票哨兵成为leader， 一人只有一票
                * 超过半数同意，就成为leader
                * 如果票数相同，根据配置failover-timeout超时，重新拉票
        * slave选举方案
            * 存活节点
            * 优先级 slave-priority配置项 越小优先级越高
            * 无优先级情况，根据数据同步情况
            * 数据同步情况一致，那么根据runid字典序第一个
        * 主从切换过程
            * 被选举的slave执行 slaveof no one
            * 其他slave执行 slaveof当前master
        * 哨兵服务部署方案
            * 哨兵要至少3个， 客观下线
            * 脑裂问题， 恢复时旧的master被干掉。 raft算法
* redis cluster
    * https://blog.csdn.net/truelove12358/article/details/79612954
    * 分片存储 2^14个是slot 一致性hash
    * 保证可用性，可以cluster加主从复制
* 监控 redislive
    
## 对ip开放
配置文件 bind 127.0.0.1             
