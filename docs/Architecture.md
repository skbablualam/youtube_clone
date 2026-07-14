# Architecture
![alt text](../538f2e2e-f628-4e7a-8bcb-1a61d6bd294a.png)

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
Jenkins EC2
     │
     ├── npm install
     ├── npm test
     ├── SonarCloud
     ├── Trivy
     ├── Docker Build
     ├── Docker Push
     └── SSH
             │
             ▼
       Minikube EC2
             │
             ▼
      Kubernetes Cluster
             │
             ▼
      React YouTube Clone
             │
             ▼
       Prometheus
             │
             ▼
         Grafana
             │
             ▼
      CloudWatch Agent
             │
             ▼
      Amazon CloudWatch
```
# Project Architecture

```mermaid
flowchart TD
    A[Developer] --> B[GitHub Repository]
    B --> C[GitHub Webhook]
    C --> D[Jenkins EC2]

    D --> E[npm install]
    E --> F[npm test]
    F --> G[SonarCloud]
    G --> H[Trivy]
    H --> I[Docker Build]
    I --> J[Docker Push]
    J --> K[SSH]

    K --> L[Minikube EC2]
    L --> M[Kubernetes Cluster]
    M --> N[React YouTube Clone]
    N --> O[Prometheus]
    O --> P[Grafana]
    P --> Q[CloudWatch Agent]
    Q --> R[Amazon CloudWatch]
```
