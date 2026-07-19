````markdown
# 🎬 YouTube Clone - Enterprise DevOps CI/CD Pipeline on Kubernetes

<p align="center">
  <img src="images/architecture.png" alt="Architecture" width="100%">
</p>

<p align="center">

![React](https://img.shields.io/badge/React-18-blue?logo=react)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue?logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Minikube-326CE5?logo=kubernetes)
![Jenkins](https://img.shields.io/badge/Jenkins-CI/CD-D24939?logo=jenkins)
![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazonaws)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboard-F46800?logo=grafana)
![License](https://img.shields.io/badge/License-MIT-green)

</p>

---

# 📌 Project Overview

This project demonstrates a **production-inspired DevOps CI/CD pipeline** for deploying a React-based **YouTube Clone** using modern DevOps tools and cloud-native practices.

The application is automatically built, tested, containerized, and deployed to a **Kubernetes cluster (Minikube)** whenever code is pushed to GitHub.

The primary goal of this project is to showcase an end-to-end DevOps workflow including:

- Infrastructure as Code (Terraform)
- Continuous Integration & Continuous Deployment (Jenkins)
- Containerization (Docker)
- Kubernetes Deployments
- Security Scanning (Trivy)
- Code Quality Analysis (SonarCloud)
- Monitoring (Prometheus & Grafana)
- GitHub Webhooks
- Local Kubernetes Development using Minikube

---

# 🏗 Architecture

<p align="center">
<img src="images/architecture.png" width="100%">
</p>

## Architecture Workflow

```text
Developer
     │
     ▼
GitHub Repository
     │
GitHub Webhook
     ▼
Jenkins
     │
──────────────────────────────
Checkout Source Code
Install Dependencies
Run Unit Tests
SonarCloud Analysis
Trivy Security Scan
Docker Build
Docker Push
──────────────────────────────
     │
SSH
     ▼
Minikube
     │
Kubernetes Deployment
     │
Rolling Update
     ▼
React YouTube Clone
     │
Prometheus
     │
Grafana
```

---

# ✨ Features

- Fully Automated CI/CD Pipeline
- Infrastructure as Code using Terraform
- Dockerized React Application
- Kubernetes Deployment
- GitHub Webhook Integration
- Jenkins Declarative Pipeline
- SonarCloud Code Analysis
- Trivy Vulnerability Scanning
- Rolling Kubernetes Deployment
- Prometheus Monitoring
- Grafana Dashboards
- Production-ready Folder Structure

---

# 🛠 Technology Stack

| Category | Tools |
|-----------|-------|
| Frontend | ReactJS |
| Source Code | GitHub |
| CI/CD | Jenkins |
| Container | Docker |
| Orchestration | Kubernetes (Minikube) |
| Infrastructure | Terraform |
| Cloud | AWS |
| Security | Trivy |
| Code Quality | SonarCloud |
| Monitoring | Prometheus, Grafana |
| Scripting | Bash |
| Operating System | Ubuntu 22.04 |

---

# 📂 Project Structure

```text
youtube_clone/

├── src/
├── public/
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── monitoring/
│   ├── prometheus/
│   ├── grafana/
│   ├── cloudwatch/
│   └── README.md
│
├── infrastructure/
│   ├── bootstrap/
│   └── terraform/
│
├── scripts/
│   ├── install-jenkins.sh
│   ├── install-minikube.sh
│   ├── deploy.sh
│   └── rollback.sh
│
├── docs/
│   ├── Architecture.md
│   ├── CI-CD.md
│   ├── Kubernetes.md
│   ├── Monitoring.md
│   └── Terraform.md
│
├── Dockerfile
├── Jenkinsfile
├── README.md
└── package.json
```

---

# 🚀 CI/CD Pipeline

The Jenkins pipeline automatically performs the following stages:

### Stage 1

Checkout Source Code

### Stage 2

Install Dependencies

```bash
npm install
```

---

### Stage 3

Unit Testing

```bash
npm test
```

---

### Stage 4

SonarCloud Analysis

Performs static code quality analysis.

---

### Stage 5

Trivy Filesystem Scan

Scans project files for vulnerabilities.

---

### Stage 6

Docker Build

```bash
docker build -t bablualam/youtube-clone .
```

---

### Stage 7

Trivy Image Scan

Scans Docker image for security vulnerabilities.

---

### Stage 8

Push Image

```bash
docker push bablualam/youtube-clone
```

---

### Stage 9

Deploy to Kubernetes

```bash
kubectl apply -f k8s/
```

---

### Stage 10

Verify Deployment

```bash
kubectl get pods -n youtube
```

---

# ☁ Infrastructure as Code (Terraform)

Infrastructure is managed using Terraform modules.

Provisioned Resources:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Groups
- Jenkins EC2
- Minikube EC2 (Optional)
- S3 Backend
- DynamoDB State Locking

Terraform Backend

```hcl
backend "s3" {
  bucket = "terraform-state"
  key = "terraform.tfstate"
  region = "us-east-1"
}
```

---

# 🐳 Docker

Build Image

```bash
docker build -t youtube-clone .
```

Run Container

```bash
docker run -d -p 3000:80 youtube-clone
```

---

# ☸ Kubernetes

Deploy

```bash
kubectl apply -f k8s/
```

Verify

```bash
kubectl get all -n youtube
```

Rolling Update

```bash
kubectl rollout status deployment/youtube-clone -n youtube
```

Rollback

```bash
kubectl rollout undo deployment/youtube-clone -n youtube
```

---

# 📊 Monitoring

Monitoring stack includes:

- Prometheus
- Grafana

Verify

```bash
kubectl get pods -A
```

---

# 🔗 GitHub Webhook

To automatically trigger Jenkins builds on every push:

## Start ngrok

```bash
ngrok http 8080
```

Example URL

```
https://abcd1234.ngrok-free.app
```

Configure GitHub Webhook

```
Repository

↓

Settings

↓

Webhooks

↓

Add Webhook
```

Payload URL

```
https://YOUR-NGROK-URL/github-webhook/
```

Content Type

```
application/json
```

Events

```
Just the push event
```

---

# 🚀 Quick Start

Clone Repository

```bash
git clone https://github.com/skbablualam/youtube_clone.git
```

Go to Project

```bash
cd youtube_clone
```

Start Minikube

```bash
minikube start --driver=docker
```

Deploy

```bash
kubectl apply -f k8s/
```

Access Application

```bash
minikube service youtube-clone-service -n youtube
```

---

# 📸 Screenshots

Add screenshots inside the **images/** folder.

Recommended images:

```text
images/

architecture.png

jenkins-dashboard.png

pipeline-success.png

dockerhub.png

kubernetes.png

prometheus.png

grafana.png

application.png
```

---

# 📝 Useful Commands

Check Pods

```bash
kubectl get pods -n youtube
```

Describe Deployment

```bash
kubectl describe deployment youtube-clone -n youtube
```

View Logs

```bash
kubectl logs deployment/youtube-clone -n youtube
```

Delete Resources

```bash
kubectl delete -f k8s/
```

---

# 🛡 Security

This project uses:

- SonarCloud
- Trivy
- Docker Best Practices
- Non-root Containers
- Kubernetes Rolling Updates

---

# 🎯 Learning Outcomes

This project demonstrates practical experience with:

- CI/CD Automation
- Docker
- Kubernetes
- Jenkins
- Terraform
- AWS
- GitHub Webhooks
- DevSecOps
- Infrastructure as Code
- Monitoring & Observability

---

# 🚀 Future Enhancements

- Amazon EKS Deployment
- ArgoCD GitOps
- Helm Charts
- Horizontal Pod Autoscaler
- Ingress Controller with TLS
- AWS ALB Ingress Controller
- Slack Notifications
- Email Alerts
- Blue/Green Deployment
- Canary Deployment
- Multi-Environment Support (Dev, QA, Prod)

---

# 🤝 Contributing

Contributions, issues, and feature requests are welcome.

Feel free to fork this repository and submit a pull request.

---

# 👨‍💻 Author

**Bablu Alam**

DevOps Engineer | AWS | Kubernetes | Terraform | Jenkins | Docker

- GitHub: https://github.com/skbablualam
- LinkedIn: https://linkedin.com/in/bablualam
- Portfolio: https://skbablualam.github.io/

---

# ⭐ Support

If you found this project helpful:

⭐ Star this repository

🍴 Fork the project

📢 Share it with others

---

## 📄 License

This project is licensed under the **MIT License**.

---

<p align="center">

### ⭐ If you like this project, don't forget to star the repository!

Made with ❤️ by **Bablu Alam**

</p>
````