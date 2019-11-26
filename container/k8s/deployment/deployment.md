#deployment

### 为什么有rc了还要deployment
由于rc存在一个痛点，就是rolling-update后由于标签变化，导致和service关联失效，需要更新service

### 创建方式
* kubectl create -f XXX.yaml
* kubectl run XXXX --image=master:5000/nginx:1.13 --replicas=3 --record


### 暴露端口
* kubectl expose deployment nginx-deployment --port=80 --type=NodePort

### 升级和回滚
* 升级
    1. 方式1 kubectl edit deployment XXXX
    2. 方式2 kubectl set image deploy XXXX XXXX=master:5000/nginx:1.15
 
* 回滚 kubectl rollout undo deployment XXX
    * 附件参数， 回滚到某一个版本 --to-revision=1
* 查看回滚记录 kubectl rollout history deployment XXX
