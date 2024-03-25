docker run -d --name prometheus -p 9090:9090 -v /root/install_sh/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

docker run -d --name node_exporter -p 9100:9100 prom/node-exporter


