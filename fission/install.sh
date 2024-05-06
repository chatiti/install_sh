#install online
#curl -Lo fission https://github.com/fission/fission/releases/download/v1.20.1/fission-v1.20.1-linux-amd64 && chmod +x fission && sudo mv fission /usr/local/bin/

#install offline
yum install fission-v1.20.1-linux-amd64
export FISSION_NAMESPACE="fission"
kubectl create namespace $FISSION_NAMESPACE
kubectl create -k "github.com/fission/fission/crds/v1?ref=v1.20.1"
helm repo add fission-charts https://fission.github.io/fission-charts/
helm repo update
helm install --version v1.20.1 --namespace $FISSION_NAMESPACE fission \
  --set serviceType=NodePort,routerServiceType=NodePort \
  fission-charts/fission-all
helm install --namespace fission --set serviceType=NodePort,routerServiceType=NodePort fission fission-charts/fission-all
