yum remove docker docker-common
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install  docker-ce -y

systemctl status docker
systemctl status containerd

yum install -y kubelet-1.23.8 kubeadm-1.23.8 kubectl-1.23.8
systemctl enable kubelet && systemctl start kubelet

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start --kubernetes-version=v1.23.8 --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers' --driver=docker --force

