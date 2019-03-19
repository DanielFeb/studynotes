#Rabbitmq
erlang语言
##权限控制
###角色
* none
* manager
* policymaker
* monitor
* admin
##可靠性
* 事务
* confirm机制
##高可用性
* 集群 镜像队列
* 负载均衡
    * HAProxy + Keepalived
##持久化
###达到内存阈值，写入磁盘
###durable的exchange，durable的queue及persistent的message会被写磁盘
写入文件前会有一个Buffer,大小为1M,数据在写入文件时，首先会写入到这个Buffer，如果Buffer已满，则会将Buffer写入到文件（未必刷到磁盘）。
有个固定的刷盘时间：25ms,也就是不管Buffer满不满，每个25ms，Buffer里的数据及未刷新到磁盘的文件内容必定会刷到磁盘。
每次消息写入后，如果没有后续写入请求，则会直接将已写入的消息刷到磁盘：使用Erlang的receive x after 0实现，只要进程的信箱里没有消息，则产生一个timeout消息，而timeout会触发刷盘操作。
引用自 https://blog.csdn.net/u013256816/article/details/60875666
###内存和磁盘控制
https://blog.csdn.net/andrewniu/article/details/80255703
##死信
死信队列是在policy里面定义的  
以下几种情况消息将进入死信队列
* 有消息被拒绝（basic.reject/ basic.nack）并且requeue=false
* 队列达到最大长度
* 消息TTL过期

