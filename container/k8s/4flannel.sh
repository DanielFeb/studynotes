
#在master上执行
etcdctl set /atomic.io/network/config '{"Network":"172.16.0.0/16"}'


yum install flannel -y
#配置etcd地址 和储存的网络前缀(默认)
vi /etc/sysconfig/flanneld

systemctl start flanneld.service
systemctl enable flanneld.service

#用ifconfig命令确定是否多了flannel0网卡

#重启docker
systemctl restart docker
#用ifconfig命令确定docker0和flannel0在同一网段
# docker 1.13 后需要调整iptables规则
iptables -P FORWARD ACCEPT
#设置iptables重启后生效 systemctl status docker 查看配置文件
# vi /usr/lib/systemd/system/docker.service
# 加入一行 ExecStartPost=/usr/sbin/iptables -P FORWARD ACCEPT
# 运行 systemctl daemon-reload使配置生效


#测试容器网络连通性
docker pull busybox
docker run it busybox


