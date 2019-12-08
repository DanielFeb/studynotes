### 安装gitlab
* wget http://mirror.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-11.9.11-ce.0.el7.x86_64.rpm
    * yum localinstall XXX
* 修改配置 vi /etc/gitlab/gitlab.rb
    * 13行域名 external_url 'http://node2'
    * 1535行 关闭prometheus_monitoring省资源 
        * prometheus_monitoring['enable']=false 'http://node2'
    * 启用配置 gitlab-ctl reconfigure
### 安装jenkins
* 在 node1上安装jenkins
    * 安装tomcat
    * 下载jenkins war 包

###


