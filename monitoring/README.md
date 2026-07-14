# 📊 Monitoring Stack

This project uses a complete monitoring stack to monitor the AWS infrastructure, Kubernetes cluster, Docker containers, and application health.

---

# Monitoring Architecture

```
                    +----------------------+
                    |      Grafana         |
                    +----------+-----------+
                               |
                               |
                    +----------v-----------+
                    |     Prometheus       |
                    +----------+-----------+
                               |
        -------------------------------------------------
        |                     |                         |
        |                     |                         |
+-------v------+     +--------v--------+      +---------v---------+
| Jenkins EC2  |     | Minikube EC2    |      | Kubernetes Cluster|
| NodeExporter |     | NodeExporter    |      | kube-state-metrics|
+--------------+     +-----------------+      +-------------------+
```

---

# Components

## 1. Prometheus

Prometheus collects metrics from multiple sources.

### Metrics Collected

- CPU Usage
- Memory Usage
- Disk Usage
- Network Usage
- Docker Metrics
- Kubernetes Metrics
- Pod Status
- Deployment Status

Configuration file:

```
monitoring/prometheus.yml
```

---

## 2. Grafana

Grafana visualizes Prometheus metrics using dashboards.

Dashboards include:

- EC2 CPU Utilization
- EC2 Memory Usage
- Disk Usage
- Docker Containers
- Kubernetes Pods
- Kubernetes Deployments
- Node Health
- Network Traffic

Dashboard JSON:

```
monitoring/grafana-dashboard.json
```

---

## 3. Node Exporter

Node Exporter is installed on both EC2 instances.

### Jenkins Server

Collects:

- CPU
- Memory
- Disk
- File System
- Network

### Minikube Server

Collects:

- CPU
- Memory
- Disk
- Network
- System Load

Default Port

```
9100
```

---

## 4. kube-state-metrics

Provides Kubernetes object metrics.

Collected Metrics

- Pods
- Deployments
- ReplicaSets
- Services
- Nodes
- Namespaces

---

## 5. cAdvisor

Collects Docker container metrics.

Metrics include

- Container CPU
- Container Memory
- Network Usage
- Restart Count

---

## 6. CloudWatch Agent

CloudWatch Agent runs on both EC2 instances.

Collected Metrics

- CPU
- Memory
- Disk
- Swap
- Network
- Logs

CloudWatch Dashboard can also be created from these metrics.

---

# Monitoring Flow

```
Node Exporter
        │
        ▼
 Prometheus
        │
        ▼
   Grafana
```

---

# Ports Used

| Component | Port |
|-----------|------|
| Prometheus | 9090 |
| Grafana | 3000 |
| Node Exporter | 9100 |
| Jenkins | 8080 |
| Kubernetes API | 6443 |

---

# Access URLs

## Prometheus

```
http://<SERVER-IP>:9090
```

---

## Grafana

```
http://<SERVER-IP>:3000
```

Default Credentials

Username

```
admin
```

Password

```
admin
```

(Change the password after first login.)

---

## Node Exporter

```
http://<SERVER-IP>:9100/metrics
```

---

# Installation

Prometheus

```bash
helm install prometheus prometheus-community/prometheus
```

Grafana

```bash
helm install grafana grafana/grafana
```

Node Exporter

```bash
./scripts/install-node-exporter.sh
```

CloudWatch Agent

```bash
sudo dpkg -i amazon-cloudwatch-agent.deb
```

---

# Future Improvements

- Alertmanager Integration
- Slack Notifications
- Email Alerts
- Loki Log Aggregation
- Promtail
- Jaeger Distributed Tracing
- OpenTelemetry
- AWS Managed Prometheus
- Amazon Managed Grafana

---

# Screenshots

Add screenshots after deployment.

- Jenkins Dashboard
- Prometheus Targets
- Grafana Dashboard
- CloudWatch Dashboard
- Kubernetes Dashboard

---

# Project Structure

```
monitoring/
│
├── README.md
├── prometheus.yml
└── grafana-dashboard.json
```

---

# Author

**Bablu Alam**

AWS | DevOps | Terraform | Docker | Kubernetes | Jenkins | Prometheus | Grafana | Cloud Monitoring