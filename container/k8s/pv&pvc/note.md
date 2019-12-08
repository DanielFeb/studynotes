### persistent volume
### persistent volume claim

###使用步骤
1. 每个节点都安装 nfs
    * yum install nfs-utils -y
    * vim /etc/exports
        */data  192.168.31.0/24(rw,async,no_root_squash,no_all_squash)
    * 创建 /data目录
    * systemctl restart rpcbind
    * systemctl restart nfs
    * showmount -e master
2. 创建pv
    * kubectl create -f pv.yaml

3. 在pod中使用pvc
    * see mysql-rc-pvc.yml

###分布式文件系统 glusterfs
* 查看磁盘挂载容量等信息 df -h
1. 所有节点安装glusterfs:
    * yum install centos-release-gluster -y
    * yum install glusterfs-server -y
    * systemctl start glusterd.service
    * systemctl enable glusterd.service
    * mkdir -p /gfs/test1
    * mkdir -p /gfs/test2

2. 配置glusterfs
    * 配置节点
        * 查看节点 gluster pool list
        * 编辑节点 gluster peer probe/detach/status
            * gluster peer probe node1
            * gluster peer probe node2
    * 卷管理
        * 创建分布式复制卷
            * gluster volume create ivolume replica 2 master:/gfs/test1 master:/gfs/test2 node1:/gfs/test1 node1:/gfs/test2 force
        * 启动卷 
            * gluster volume start ivolume
        * 查看卷
            * gluster volume info ivolume
        * 挂载卷
            * mount -t glusterfs master:/ivolume /mnt
        * 扩容
            * gluster volume add-brick ivolume node2:/gfs/test1 node2:/gfs/test2 force
3. 在k8s中使用glusterfs
    * 创建Endpoint 
        * 创建 kubectl create -f glusterfs-ep.yaml
        
    
