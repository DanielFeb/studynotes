# 创建rc, 通过标签选择器来确定pod的个数（可通过edit pod来修改标签来验证）
kubectl create -f rc.yaml

# rolling update （中断后可以通过重输命令来恢复rolling update 过程）
kubectl rolling-update myweb -f rc2.yaml --update-period=30s

# 中断后 rollback
kubectl rolling-update myweb myweb2 --update-period=10s --rollback