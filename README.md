
# YouTube Clone - Local Minikube Deployment

This repository contains a React-based YouTube clone frontend that is now configured for local Kubernetes deployment on macOS using Minikube.

## New architecture

- GitHub sends updates to Jenkins running locally in Docker
- Jenkins builds the React app and container image
- The image is loaded into Minikube on the MacBook
- The app is deployed to Kubernetes and exposed locally
- Prometheus and Grafana can be added for monitoring

## What changed

- Removed the AWS and Terraform workflow from the main deployment path
- Simplified the setup for local development on a MacBook
- Updated the deployment scripts to work with Docker Desktop and Minikube

## Prerequisites

Install the following tools on your Mac:

- Docker Desktop
- Homebrew
- kubectl
- Minikube
- Helm (optional for monitoring)

## Quick start

1. Install the required tools:

   ```bash
   brew install --cask docker
   brew install kubectl minikube helm
   ```

2. Start Docker Desktop and make sure it is running.

3. Start Minikube:

   ```bash
   minikube start --driver=docker --memory=4096 --cpus=2
   minikube addons enable ingress
   ```

4. Start Jenkins locally:

   ```bash
   ./scripts/install-jenkins.sh
   ```

5. Deploy the application:

   ```bash
   ./scripts/deploy.sh
   ```

6. Open the app:

   ```bash
   minikube service youtube-clone-service -n youtube
   ```

## Project structure

- [src](src) – React application source code
- [k8s](k8s) – Kubernetes manifests for the app
- [scripts](scripts) – setup and deployment helpers
- [monitoring](monitoring) – Prometheus and Grafana configuration

## Local deployment workflow

The deployment script will:

- build the Docker image locally
- load the image into the Minikube Docker environment
- create the Kubernetes namespace
- deploy the app and expose it through a service

## Jenkins workflow

The Jenkins pipeline is simplified for local use:

- checkout the repository
- install dependencies
- build the React app
- build the Docker image
- load the image into Minikube
- deploy the updated image to Kubernetes

## GitHub webhook to Jenkins

To trigger Jenkins automatically on every push to GitHub, follow these steps:

1. Install the Jenkins plugins:
   - GitHub Plugin
   - GitHub Branch Source Plugin

2. In Jenkins, create or open your pipeline job and set the repository URL to your GitHub repo.

3. In the job configuration, enable the build trigger:
   - Build Triggers → GitHub hook trigger for GITScm polling

4. In GitHub, go to your repository → Settings → Webhooks → Add webhook.

5. Use these values:
   - Payload URL: http://<your-public-jenkins-host>/github-webhook/
   - Content type: application/json
   - Secret: optional
   - Events: Just the push event

6. Because Jenkins is running locally on your Mac, GitHub needs a reachable public URL. Use a tunnel such as ngrok, Cloudflare Tunnel, or Tailscale to expose your local Jenkins instance.

Example with ngrok:

```bash
ngrok http 8080
```

Then use the generated HTTPS URL in the webhook payload URL.

## Monitoring

Prometheus and Grafana can be installed with Helm if you want cluster visibility.

Example:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
```

## Notes

- This setup is intended for local development and learning rather than production-grade cloud deployment.
- The old Terraform and AWS-based infrastructure files have been removed from the main workflow.