```markdown
# 🎬 YouTube Clone

![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Material UI](https://img.shields.io/badge/Material--UI-0081CB?style=for-the-badge&logo=material-ui&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=Jenkins&logoColor=white)

> A responsive YouTube-style web application featuring a modern UI for browsing videos, searching content, and viewing channel details. Fully containerized and deployed via a robust Jenkins CI/CD pipeline to a Kubernetes cluster, complete with observability tools.

---

## ✨ Features

- **Home Feed:** Explore trending and recommended video cards.
- **Dynamic Search:** Browse specific video content via rapid API integration.
- **Immersive Viewing:** Dedicated video detail pages with an embedded React player.
- **Channel Insights:** View detailed channel pages and statistics.
- **Responsive Design:** Optimized for all devices using Material UI.

---

## 🛠️ Tech Stack

**Frontend:** React 18, React Router DOM, Material UI, Axios, React Player  
**DevOps:** Docker, Nginx, Kubernetes, Minikube  
**CI/CD:** Jenkins (Pipeline as Code)  
**Monitoring:** Prometheus, Grafana, cAdvisor, Node Exporter  

---

## 📂 Project Structure

```text
youtube_clone/
├── k8s/                # Kubernetes manifests (Deployment, Service, Ingress)
├── monitoring/         # Prometheus & Grafana configurations
├── public/             # Static assets
├── scripts/            # Environment setup scripts (Jenkins, Minikube)
├── src/                # React source code (Components, Utils, API config)
├── Dockerfile          # Multi-stage Docker build with Nginx
├── Jenkinsfile         # Declarative CI/CD pipeline
└── package.json        # Node dependencies and scripts

```

---

## 🚀 Quick Start

### Prerequisites

* **Node.js** (v20+) & **npm**
* **Docker**
* **Minikube & kubectl** (For local Kubernetes deployment)

### Local Development

1. **Install dependencies:**
```bash
npm install

```


2. **Configure Environment:**
Create a `.env` file in the root directory and add your RapidAPI key:
```env
REACT_APP_RAPID_API_KEY=your_api_key_here

```


3. **Start the development server:**
```bash
npm start

```



---

## 🐳 Docker Deployment

To manually build and run the application in an Nginx container:

```bash
# Build the image
docker build -t youtube-clone .

# Run the container
docker run -d -p 3000:80 youtube-clone

```

---

## ☸️ Kubernetes Deployment

Ensure your local cluster (Minikube) is running, then apply the manifests:

```bash
# Create the namespace first
kubectl apply -f k8s/namespace.yaml

# Deploy the application assets
kubectl apply -f k8s/

```

---

## 🏗️ CI/CD Pipeline (Jenkins)

This repository includes a `Jenkinsfile` designed to automate the entire software delivery lifecycle. The pipeline executes the following stages:

1. **Checkout:** Pulls the latest source code.
2. **Install Dependencies:** Installs Node packages via `npm`.
3. **Run Tests:** Executes unit tests.
4. **Build:** Compiles the optimized React production build.
5. **Docker Build:** Creates the Nginx web server image.
6. **Security Scan:** Scans the filesystem and container image using **Trivy**.
7. **Push:** Pushes the verified image to Docker Hub.
8. **Deploy:** Applies the K8s manifests to the cluster.

*(Note: Custom setup scripts for the Jenkins Docker container are available in the `scripts/` directory).*

---

## 📝 Notes

This repository currently focuses on the frontend application, CI/CD, and local deployment assets. It does not include Terraform infrastructure-as-code files or an AWS production deployment setup at this time.

## 📄 License

This project is licensed under the [MIT License](https://www.google.com/search?q=LICENSE).

```

```