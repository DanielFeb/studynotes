###创建步骤
* 创建dns服务pod 
    * kubectl create -f skydns-rc.yaml
    * 查看kube-system空间的资源
        * kubectl get XXX --namespace=kube-system
* 暴露 dns service 到 10.254.230.254 cluster ip
    * kubectl create -f skydns-svc.yaml
* 修改所有node的kubelet配置并重启kubelet服务
    * KUBELET_ARGS="--cluster_dns=10.254.230.254 --cluster_domain=cluster.local"
