#MyCat
## 概念
* rule 分库分表规则
* data node
* data host
    * 由一到多个 WriteNode 及零到多个 ReadNode组成
## 常用分库分表规则
* 分片枚举
* 数值范围分片
* 按日期范围分片， 以多少天为一个周期
* 自然月分片
* 取模分片
* 取模范围分片
* 二进制取模范围分片
* 范围取模分片
* 一致性hash分片  
    有效解决分布式数据库扩容问题
* 应用指定分片
* 前缀ASCII码相加取模
##主键生成
server.xml 配置 SequenceHandlerType
* 0 本地文件方式 sequence_conf.properties
* 1 数据库方式 
* 2 本地时间戳 
* 3 分布式Zookeeper ID生成 63位
* 4 ZK递增方式
#监控
* mycat-mini-mornitor
* mycat-web