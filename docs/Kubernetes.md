# ☸️ Kubernetes Documentation

## Project

**YouTube Clone - Kubernetes Deployment on Minikube**

---

# Overview

This project deploys the YouTube Clone React application on a Kubernetes cluster running on Minikube inside an AWS EC2 instance.

Kubernetes provides:

- Container Orchestration
- High Availability
- Self-Healing
- Rolling Updates
- Easy Scaling
- Service Discovery

---

# Kubernetes Architecture

```text
                   Jenkins EC2
                       │
                       │ SSH
                       ▼
                Minikube EC2
                       │
             Kubernetes Cluster
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
 Namespace       Deployment       Service
        │              │              │
        ▼              ▼              ▼
     ReplicaSet      Pods         NodePort
                       │
                       ▼
                React Application
```

---

# Namespace

The application runs inside a dedicated namespace.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: youtube
```

Advantages:

- Resource isolation
- Better organization
- Easier monitoring
- Simplified management

---

# Deployment

The Deployment manages application Pods.

Example:

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: youtube-clone

spec:
  replicas: 2
```

Responsibilities:

- Create Pods
- Replace failed Pods
- Rolling Updates
- Rollback support
- Replica management

---

# ReplicaSet

ReplicaSet ensures the desired number of Pods is always running.

Example:

```
Desired Replicas : 2

Running Pods : 2
```

If one Pod fails:

```
Desired : 2

Running : 1

↓

ReplicaSet

↓

Creates New Pod

↓

Running : 2
```

---

# Pods

Each Pod contains one Docker container.

Example:

```
Pod

↓

youtube-clone

↓

Docker Container

↓

React Application
```

Useful Commands:

```bash
kubectl get pods
```

```bash
kubectl describe pod <pod-name>
```

```bash
kubectl logs <pod-name>
```

---

# Service

The Service exposes the Deployment.

Example:

```yaml
kind: Service

type: NodePort
```

Service Responsibilities:

- Stable IP
- Load Balancing
- Service Discovery

Useful Commands:

```bash
kubectl get svc
```

```bash
kubectl describe svc youtube-clone
```

---

# NodePort

Since this project does not use an AWS Load Balancer, the application is exposed using a NodePort Service.

Example:

```
NodePort

↓

30080

↓

http://EC2_PUBLIC_IP:30080
```

---

# Deployment Workflow

```text
Jenkins

↓

Docker Image

↓

Docker Hub

↓

Minikube

↓

Deployment

↓

ReplicaSet

↓

Pods

↓

Service

↓

Application
```

---

# Kubernetes Manifests

Project structure:

```
k8s/

├── namespace.yaml
├── deployment.yaml
├── service.yaml
└── ingress.yaml
```

---

# Apply Resources

Create Namespace

```bash
kubectl apply -f k8s/namespace.yaml
```

Deploy Application

```bash
kubectl apply -f k8s/deployment.yaml
```

Create Service

```bash
kubectl apply -f k8s/service.yaml
```

Create Ingress (Optional)

```bash
kubectl apply -f k8s/ingress.yaml
```

---

# Verify Deployment

Pods

```bash
kubectl get pods -n youtube
```

Deployments

```bash
kubectl get deployment -n youtube
```

ReplicaSets

```bash
kubectl get rs -n youtube
```

Services

```bash
kubectl get svc -n youtube
```

Namespaces

```bash
kubectl get ns
```

Nodes

```bash
kubectl get nodes
```

---

# Scaling

Scale to 4 replicas.

```bash
kubectl scale deployment youtube-clone \
--replicas=4 \
-n youtube
```

Verify:

```bash
kubectl get pods -n youtube
```

---

# Rolling Update

Deploy a new Docker image.

```bash
kubectl set image deployment/youtube-clone \
youtube-clone=bablualam/youtube-clone:v2 \
-n youtube
```

Verify:

```bash
kubectl rollout status deployment/youtube-clone \
-n youtube
```

---

# Rollback

Rollback to the previous version.

```bash
kubectl rollout undo deployment/youtube-clone \
-n youtube
```

View rollout history:

```bash
kubectl rollout history deployment/youtube-clone \
-n youtube
```

---

# Logs

View Pod logs.

```bash
kubectl logs <pod-name> -n youtube
```

Follow logs:

```bash
kubectl logs -f <pod-name> -n youtube
```

---

# Execute Inside Pod

```bash
kubectl exec -it <pod-name> \
-n youtube \
-- /bin/sh
```

---

# Delete Resources

Delete Deployment

```bash
kubectl delete deployment youtube-clone \
-n youtube
```

Delete Service

```bash
kubectl delete svc youtube-clone \
-n youtube
```

Delete Namespace

```bash
kubectl delete namespace youtube
```

---

# Common Troubleshooting

## Pod Pending

Check:

```bash
kubectl describe pod <pod-name>
```

Possible causes:

- Insufficient CPU
- Insufficient Memory
- Image pull issues

---

## ImagePullBackOff

Verify:

- Docker image exists
- Image tag is correct
- Docker Hub repository is public or image pull secret is configured

---

## CrashLoopBackOff

Check logs:

```bash
kubectl logs <pod-name>
```

---

## Service Not Reachable

Verify:

```bash
kubectl get svc
```

Check:

- NodePort
- Security Group
- EC2 firewall
- Minikube status

---

# Best Practices

- Use Namespaces
- Define Resource Requests and Limits
- Use Readiness Probes
- Use Liveness Probes
- Use Labels and Selectors
- Avoid using the latest image tag
- Use versioned Docker images
- Keep manifests under version control

---

# Useful Commands

| Command | Description |
|----------|-------------|
| `kubectl get pods` | List Pods |
| `kubectl get svc` | List Services |
| `kubectl get deployment` | List Deployments |
| `kubectl get nodes` | List Nodes |
| `kubectl describe pod` | Pod Details |
| `kubectl logs` | View Logs |
| `kubectl exec` | Access Pod |
| `kubectl rollout status` | Deployment Status |
| `kubectl rollout undo` | Rollback Deployment |
| `kubectl scale` | Scale Deployment |

---

# Related Documentation

- [Architecture](Architecture.md)
- [Terraform](Terraform.md)
- [CI-CD](CI-CD.md)
- [Monitoring](Monitoring.md)

---

# Author

**Bablu Alam**

AWS • Kubernetes • Docker • Jenkins • Terraform • Prometheus • Grafana • CloudWatch