### Horizontal Pod Autoscaler 弹性伸缩

##### 可以对 ReplicationController RelicaSet 或 Deployment 进行操作
* kubectl autoscale replicationcontroller myweb --max=8 --min=1 --cpu-percent=5

#### apache bench 压测工具
* yum install httpd-tools -y
* ab -n 500000 -c 15 http://172.16.67.3/index.html
