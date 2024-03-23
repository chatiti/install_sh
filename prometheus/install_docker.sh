docker run -d --name prometheus -p 9090:9090 prom/prometheus

docker run -d --name node_exporter --net="host" prom/node-exporter


