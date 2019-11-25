#install etcd
yum install etcd -y
# 可以不要，修改成远端可以访问的
#vim /etc/etcd/etcd.conf
#
systemctl start etcd
systemctl enable etcd
# 安装k8s-master
yum install kubernetes-master.x86_64 -y

# 修改端口
#vi /etc/kubernetes/apiserver
# 删除 ServiceAccount配置
#vi /etc/kubernetes/config
systemctl start kube-apiserver.service
systemctl start kube-controller-manager.service
systemctl start kube-scheduler.service
systemctl enable kube-apiserver.service
systemctl enable kube-controller-manager.service
systemctl enable kube-scheduler.service
#查看状态
kubectl get componentstatus

