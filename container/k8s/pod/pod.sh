# create pod
kubectl create -f pod.yaml

# show pods
kubectl get pod
kubectl get pod XXX -o wide

# describe pods
kubectl describe pod XXX

# delete pod
kubectl delete pod XXX

# apply changes to pod
kubectl apply -f pod.yaml


# edit pod
kubectl edit pod XXX
