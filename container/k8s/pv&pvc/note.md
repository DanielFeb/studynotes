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