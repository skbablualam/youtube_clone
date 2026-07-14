# 📊 Monitoring Documentation

## Project

**YouTube Clone - Monitoring & Observability**

---

# Overview

This project implements a complete monitoring solution for the infrastructure, Kubernetes cluster, Docker containers, and application using open-source tools and AWS CloudWatch.

The monitoring stack provides real-time visibility into:

- EC2 Health
- Kubernetes Cluster
- Docker Containers
- Application Availability
- System Metrics
- Resource Utilization
- Logs
- Infrastructure Performance

---

# Monitoring Stack

| Component | Purpose |
|-----------|---------|
| Prometheus | Metrics Collection |
| Grafana | Dashboard Visualization |
| Node Exporter | Linux Host Metrics |
| cAdvisor | Docker Container Metrics |
| kube-state-metrics | Kubernetes Metrics |
| CloudWatch Agent | EC2 Metrics & Logs |
| Amazon CloudWatch | Cloud Monitoring |

---

# Monitoring Architecture

```text
                    +--------------------------------------+
                    |          Amazon CloudWatch           |
                    |        Metrics + Logs + Alarms       |
                    +-------------------▲------------------+
                                        │
                                        │
                          CloudWatch Agent
                                        ▲
                                        │
+-----------------------------------------------------------------------+
|                          Minikube EC2                                 |
|                                                                       |
| +----------------+     +----------------+     +--------------------+  |
| |   Prometheus   | --> |    Grafana     | --> |  Browser Dashboard |  |
| +-------▲--------+     +----------------+     +--------------------+  |
|         │                                                         |
|         │                                                         |
|  +------+--------+       +------------------+      +-------------+ |
|  | Node Exporter |       | kube-state-metrics|     |  cAdvisor   | |
|  +---------------+       +------------------+      +-------------+ |
|                                                                       |
+-----------------------------------------------------------------------+

                ▲
                │
                │
        Jenkins EC2
                │
        +---------------+
        | Node Exporter |
        +---------------+
```

---

# Monitoring Components

## 1. Prometheus

Prometheus is responsible for collecting metrics from multiple targets.

### Responsibilities

- Scrape Metrics
- Store Time-Series Data
- Query Metrics
- Alerting (Future)
- Service Discovery

---

### Prometheus Targets

| Target | Port |
|---------|------|
| Prometheus | 9090 |
| Jenkins Node Exporter | 9100 |
| Minikube Node Exporter | 9100 |
| kube-state-metrics | 8080 |
| cAdvisor | 8080 |

---

### Configuration File

```
monitoring/prometheus.yml
```

---

# 2. Grafana

Grafana provides beautiful dashboards for visualizing Prometheus metrics.

### Dashboards

- Infrastructure Dashboard
- Kubernetes Dashboard
- Docker Dashboard
- Application Dashboard

---

### Access URL

```
http://<SERVER-IP>:3000
```

Default Username

```
admin
```

Default Password

```
admin
```

---

# 3. Node Exporter

Node Exporter exposes Linux system metrics.

Installed On

- Jenkins EC2
- Minikube EC2

---

### Metrics Collected

- CPU
- Memory
- Swap
- Disk
- File System
- Load Average
- Network
- Processes
- System Uptime

---

### Endpoint

```
http://SERVER_IP:9100/metrics
```

---

# 4. cAdvisor

cAdvisor provides Docker container metrics.

Metrics include:

- CPU Usage
- Memory Usage
- Container Restarts
- Network Usage
- Filesystem Usage

---

# 5. kube-state-metrics

Collects Kubernetes object metrics.

Metrics include:

- Nodes
- Pods
- Deployments
- ReplicaSets
- DaemonSets
- StatefulSets
- Services
- Namespaces

---

# 6. CloudWatch Agent

CloudWatch Agent sends EC2 metrics and logs to Amazon CloudWatch.

Configuration File

```
monitoring/cloudwatch/amazon-cloudwatch-agent.json
```

---

### Metrics Sent

- CPU Utilization
- Memory Utilization
- Disk Utilization
- Disk I/O
- Network In
- Network Out
- Swap Usage

---

### Logs Sent

```
/var/log/syslog

/var/log/auth.log

/var/log/cloud-init.log

/var/log/cloud-init-output.log

/var/log/jenkins/jenkins.log

/var/log/docker.log
```

---

# Monitoring Workflow

```text
Linux Servers
        │
        ▼
Node Exporter
        │
        ▼
Prometheus
        │
        ▼
Grafana Dashboard
```

Cloud Monitoring

```text
EC2

↓

CloudWatch Agent

↓

Amazon CloudWatch

↓

Metrics + Logs
```

---

# Dashboards

## Infrastructure Dashboard

Displays:

- CPU Utilization
- Memory Usage
- Disk Usage
- Network Usage
- System Load

---

## Kubernetes Dashboard

Displays:

- Nodes
- Namespaces
- Deployments
- ReplicaSets
- Pods
- Services

---

## Docker Dashboard

Displays:

- Running Containers
- CPU Usage
- Memory Usage
- Restart Count
- Image Usage

---

## Application Dashboard

Displays:

- Pod Health
- Deployment Status
- Response Time (Future)
- Error Rate (Future)

---

# Useful Commands

## Prometheus Pods

```bash
kubectl get pods
```

---

## Grafana Pods

```bash
kubectl get pods
```

---

## Node Exporter

```bash
curl http://localhost:9100/metrics
```

---

## CloudWatch Agent Status

```bash
sudo systemctl status amazon-cloudwatch-agent
```

---

## Restart CloudWatch Agent

```bash
sudo systemctl restart amazon-cloudwatch-agent
```

---

## View Prometheus Targets

Open

```
http://SERVER-IP:9090/targets
```

---

## View Grafana

Open

```
http://SERVER-IP:3000
```

---

# Common Issues

## Prometheus Target Down

Check:

```bash
curl http://SERVER_IP:9100/metrics
```

Verify:

- Node Exporter is running
- Security Group allows port 9100
- Prometheus target configuration

---

## Grafana Cannot Query Prometheus

Verify:

- Datasource URL
- Prometheus is running
- Network connectivity
- Prometheus service endpoint

---

## CloudWatch Agent Not Sending Metrics

Check logs:

```bash
sudo journalctl -u amazon-cloudwatch-agent
```

Verify:

- IAM Role
- AWS Credentials
- Agent configuration
- Internet connectivity

---

## High CPU Usage

Check:

```bash
top
```

or

```bash
htop
```

---

# Best Practices

- Monitor both infrastructure and applications.
- Keep scrape intervals reasonable (15–30 seconds).
- Secure Grafana with a strong password.
- Protect Prometheus endpoints from public access.
- Rotate CloudWatch log groups as needed.
- Version-control monitoring configuration files.
- Review dashboards regularly.

---

# Future Enhancements

- Alertmanager
- Slack Alerts
- Email Notifications
- Loki for Log Aggregation
- Promtail
- Jaeger
- OpenTelemetry
- Blackbox Exporter
- Kubernetes Event Exporter

---

# Directory Structure

```
monitoring/
│
├── README.md
│
├── prometheus.yml
│
├── grafana-dashboard.json
│
├── grafana/
│   └── datasources.yml
│
└── cloudwatch/
    └── amazon-cloudwatch-agent.json
```

---

# Related Documentation

- [Architecture](Architecture.md)
- [Terraform](Terraform.md)
- [CI-CD](CI-CD.md)
- [Kubernetes](Kubernetes.md)

---

# Author

**Bablu Alam**

AWS • Terraform • Jenkins • Docker • Kubernetes • Prometheus • Grafana • CloudWatch • DevOps