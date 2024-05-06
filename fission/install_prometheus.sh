export METRICS_NAMESPACE=monitoring
kubectl create namespace $METRICS_NAMESPACE

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

#values.yaml replace images to cn images
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring -f values.yaml

#Enable the Prometheus Service Monitor and Grafana Dashboards in Fission
helm upgrade fission fission-charts/fission-all --namespace fission -f fession_values.yaml
