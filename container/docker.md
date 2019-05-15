#Command
docker run --name mynginx2 -p 80:80 mynginx:2.0

#docker-compose

#监控
## 主机和容器监控
* CAdvisor + InfluxDB + Grafana
    * CAdvisor（Google）数据采集
    * InfluxDB 数据存储 
        * docker run -d --name influxdb -p 8086:8086 -v /tmp/data/influxdb:/var/lib/influxdb --hostname=influxdb influxdb
        * docker exec -it influxdb influx  
            CREATE DATABASE "test"  
            CREATE USER "root" WITH PASSWORD 'root' WITH ALL PRIVILEGES
    * Grafana  图形界面
##日志监控
官方log driver
* 默认为 json-file driver
* Graylog （gelf协议）
    * 碰到数据卷权限问题， 进入容器查看当前user id， 然后修改外部数据卷的owner就可以了
* ELK?

#docker-compose
#docker swarm
* portainer 集群资源管理 