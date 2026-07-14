# 🚀 CI/CD Pipeline Documentation

## Project

**YouTube Clone - End-to-End DevOps CI/CD Pipeline**

---

# Overview

This project demonstrates a complete Enterprise DevOps CI/CD Pipeline built using modern DevOps tools and AWS infrastructure.

The pipeline automatically performs:

- Source Code Checkout
- Dependency Installation
- Unit Testing
- Static Code Analysis
- Security Scanning
- Docker Image Build
- Docker Image Push
- Kubernetes Deployment
- Monitoring

---

# CI/CD Architecture

```text
Developer
      │
      ▼
GitHub Repository
      │
      ▼
GitHub Webhook
      │
      ▼
Jenkins Pipeline
      │
      ├──────────────► Checkout Code
      │
      ├──────────────► npm install
      │
      ├──────────────► npm test
      │
      ├──────────────► SonarCloud Analysis
      │
      ├──────────────► Trivy File Scan
      │
      ├──────────────► Docker Build
      │
      ├──────────────► Trivy Image Scan
      │
      ├──────────────► Push Image to Docker Hub
      │
      ├──────────────► SSH to Minikube Server
      │
      └──────────────► Kubernetes Deployment
```

---

# Pipeline Workflow

## Stage 1 - Developer

The developer writes code locally and pushes changes to the GitHub repository.

```bash
git add .
git commit -m "Added new feature"
git push origin main
```

---

## Stage 2 - GitHub Webhook

GitHub sends a webhook event to Jenkins whenever new code is pushed.

```
GitHub

↓

Webhook

↓

Jenkins
```

---

## Stage 3 - Jenkins Checkout

Jenkins checks out the latest source code from GitHub.

Example:

```groovy
git branch: 'main',
url: 'https://github.com/username/youtube-clone.git'
```

---

## Stage 4 - Install Dependencies

Since this is a React application, dependencies are installed using npm.

```bash
npm install
```

---

## Stage 5 - Unit Testing

Run application tests.

```bash
npm test -- --watchAll=false
```

If tests fail:

- Pipeline stops
- Deployment is cancelled

---

## Stage 6 - SonarCloud Analysis

Source code quality is analyzed.

Checks include:

- Bugs
- Vulnerabilities
- Code Smells
- Duplicated Code
- Maintainability
- Security Hotspots

Example:

```bash
sonar-scanner
```

---

## Stage 7 - Trivy Filesystem Scan

Scan the project before building the Docker image.

```bash
trivy fs .
```

Detects:

- Secrets
- Vulnerabilities
- Misconfigurations

---

## Stage 8 - Docker Image Build

Build the application image.

```bash
docker build -t youtube-clone:${BUILD_NUMBER} .
```

---

## Stage 9 - Trivy Image Scan

Scan the Docker image.

```bash
trivy image youtube-clone:${BUILD_NUMBER}
```

Checks:

- Critical CVEs
- High Vulnerabilities
- Package Vulnerabilities

---

## Stage 10 - Docker Hub Login

Authenticate with Docker Hub.

```bash
docker login
```

Credentials are stored securely in Jenkins Credentials.

---

## Stage 11 - Push Docker Image

Push the image to Docker Hub.

```bash
docker push bablualam/youtube-clone:${BUILD_NUMBER}
```

---

## Stage 12 - Deploy to Kubernetes

Jenkins executes the deployment script.

```bash
./scripts/deploy.sh
```

Deployment performs:

- Namespace creation
- Deployment update
- Service creation
- Ingress update
- Rollout verification

---

## Stage 13 - Kubernetes Rollout

Verify deployment.

```bash
kubectl rollout status deployment/youtube-clone
```

---

## Stage 14 - Application Available

Application becomes accessible through the Kubernetes Service (or Ingress, if configured).

---

# Jenkins Pipeline Stages

| Stage | Description |
|--------|-------------|
| Checkout | Clone repository |
| Install | npm install |
| Test | npm test |
| SonarCloud | Static code analysis |
| Trivy FS | Filesystem security scan |
| Docker Build | Build image |
| Trivy Image | Image vulnerability scan |
| Docker Push | Push image to Docker Hub |
| Deploy | Deploy to Minikube |
| Verify | Rollout status |

---

# Jenkins Credentials

Configure the following credentials in Jenkins:

| Credential | Type |
|------------|------|
| GitHub Token | Secret Text |
| Docker Hub Username | Username/Password |
| Docker Hub Password | Username/Password |
| SonarCloud Token | Secret Text |
| AWS Access Key | Secret Text |
| AWS Secret Key | Secret Text |
| SSH Private Key | SSH Key |

---

# Required Jenkins Plugins

- Git
- GitHub
- Pipeline
- Docker Pipeline
- Credentials Binding
- SSH Agent
- SonarQube Scanner
- Workspace Cleanup
- Blue Ocean (Optional)

---

# Failure Scenarios

## Unit Test Failure

Pipeline stops immediately.

---

## SonarCloud Quality Gate Failure

Deployment is blocked until code quality issues are resolved.

---

## Trivy Critical Vulnerabilities

Pipeline fails if critical vulnerabilities are detected.

---

## Docker Build Failure

Image is not created.

Deployment is skipped.

---

## Docker Push Failure

Image is not uploaded to Docker Hub.

Deployment is cancelled.

---

## Kubernetes Deployment Failure

Use the rollback script.

```bash
./scripts/rollback.sh
```

---

# Rollback Process

```text
Deployment Failed
        │
        ▼
rollback.sh
        │
        ▼
kubectl rollout undo
        │
        ▼
Previous Stable Version
```

---

# Security Best Practices

- Store all secrets in Jenkins Credentials.
- Never commit API keys to GitHub.
- Scan source code and Docker images with Trivy.
- Enforce SonarCloud Quality Gates.
- Use least-privilege AWS IAM policies.
- Rotate credentials regularly.

---

# Pipeline Benefits

- Fully automated deployments
- Consistent build process
- Early bug detection
- Security scanning
- Automated rollback
- Faster releases
- Improved reliability

---

# Future Enhancements

- GitHub Actions pipeline
- Argo CD for GitOps
- Slack notifications
- Email notifications
- OWASP Dependency Check
- Kubernetes admission policies
- Blue/Green Deployment
- Canary Deployment
- Horizontal Pod Autoscaler (HPA)
- Multi-environment deployments (Dev, QA, Prod)

---

# Related Documentation

- [Architecture](Architecture.md)
- [Terraform](Terraform.md)
- [Kubernetes](Kubernetes.md)
- [Monitoring](Monitoring.md)

---

# Author

**Bablu Alam**

AWS • Terraform • Jenkins • Docker • Kubernetes • SonarCloud • Trivy • Prometheus • Grafana • CloudWatch