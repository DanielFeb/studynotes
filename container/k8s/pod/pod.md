# create pod
kubectl create -f pod.yaml
kubectl create -f .

# show pods
kubectl get pod
kubectl get pod XXX -o wide

# describe pods
kubectl describe pod XXX

# delete pod
kubectl delete pod XXX
#根据配置文件批量删除资源
kubectl delete -f XXX.yaml
#删除当前文件夹下所有配置的资源
kubectl delete -f .

# apply changes to pod
kubectl apply -f pod.yaml


# edit pod
kubectl edit pod XXX
