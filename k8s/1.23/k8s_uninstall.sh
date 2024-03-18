kubeadm reset -y
rm -rf $HOME/.kube 
rm -rf $HOME/.kube/config
rm -rf /var/lib/etcd
yum remove kubelet kubeadm kubectl -y