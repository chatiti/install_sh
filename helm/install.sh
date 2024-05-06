# 如无需更换版本，直接执行下载
wget https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz

# 解压
tar -zxvf helm-v3.2.4-linux-amd64.tar.gz

# 进入到解压后的目录
cd linux-amd64/

# 赋予权限
mv helm /usr/local/bin/ && chmod a+x /usr/local/bin/helm

# 查看版本
helm version

# 添加仓库
helm repo add choerodon https://openchart.choerodon.com.cn/choerodon/c7n

