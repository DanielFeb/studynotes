#service

### create service
* kubectl create -f 配置文件
* kubectl expose deployment nginx-deployment --port=80 --type=NodePort

###概念
* node ip
* cluster ip  vip
* pod ip  通过flannel等网络插件实现的ip

### 默认node ip端口范围
* 30000-32767
* 通过修改apiserver配置 KUBE_API_ARGS="--service-node-port-range=30000-50000"

### 修改 cluster ip
* apiserver配置 KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"

