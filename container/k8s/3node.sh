# 安装node节点， 会自动下载docker
yum install kubernetes-node.x86_64 -y
#修改 node的配置
#vim /etc/kubernetes/config
#vim /etc/kubernetes/kubelet
# KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=docker.io/tianyebj/pod-infrastructure:latest"

systemctl start kubelet.service
systemctl enable kubelet.service
systemctl start kube-proxy.service
systemctl enable kube-proxy.service