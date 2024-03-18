API_SERVER_ADDRESS=192.168.179.150 

cat > /etc/sysctl.d/kubernetes.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# 然后执行
sysctl --system   # 生效命令

# 卸载旧的版本
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# 安装基本的安装包
sudo yum install -y yum-utils

# 设置镜像仓库
sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo # 阿里云镜像
# 更像软件包索引
yum makecache fast

# 安装docker引擎
yum install docker-ce docker-ce-cli containerd.io -y # docker-ce 社区版 ee 企业版

# 启动Docker
systemctl enable docker && systemctl start docker # 代表启动成功
# 配置docker加速
cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://b9pmyelo.mirror.aliyuncs.com"],
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
# 重启docker
systemctl restart docker
# 查看docker信息
docker info

cat > /etc/yum.repos.d/kubernetes.repo << EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubelet-1.23.0 kubeadm-1.23.0 kubectl-1.23.0
systemctl enable kubelet && systemctl start kubelet


# 初始化 Kubernetes 集群
kubeadm init \
  --apiserver-advertise-address=$API_SERVER_ADDRESS \
  --image-repository registry.aliyuncs.com/google_containers \
  --kubernetes-version v1.23.0 \
  --service-cidr=10.96.0.0/12 \
  --pod-network-cidr=10.244.0.0/16 \
  --ignore-preflight-errors=all

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# 部署网络插件（Calico 示例）
kubectl apply -f calico.yaml

# 查看节点状态
kubectl get nodes

