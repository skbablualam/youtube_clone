````markdown
# 🎬 YouTube Clone

A React-based YouTube-style web application with a modern UI for browsing videos, searching content, and viewing video and channel details. The project also includes Docker and Kubernetes deployment assets plus a Jenkins pipeline for CI/CD.

## Features

- Home feed with video cards
- Search-based video browsing
- Video detail page with embedded player
- Channel detail page
- Responsive layout using Material UI

## Tech Stack

- React 18
- React Router DOM
- Material UI
- Axios
- React Player
- Docker + Nginx
- Kubernetes manifests
- Jenkins pipeline

## Project Structure

```text
youtube_clone/
├── public/
├── scripts/
├── src/
│   ├── components/
│   └── utils/
├── k8s/
│   ├── deployment.yaml
│   ├── ingress.yaml
│   ├── namespace.yaml
│   └── service.yaml
├── monitoring/
│   ├── grafana/
│   └── prometheus/
├── Dockerfile
├── Jenkinsfile
├── package.json
└── README.md
```

## Prerequisites

- Node.js 20+
- npm
- Docker
- Optional: Minikube and kubectl

## Local Development

1. Install dependencies:

```bash
npm install
```

2. Create a local environment file and add your RapidAPI key:

```bash
REACT_APP_RAPID_API_KEY=your_api_key
```

3. Start the development server:

```bash
npm start
```

## Build for Production

```bash
npm run build
```

## Docker

Build the image:

```bash
docker build -t youtube-clone .
```

Run the container:

```bash
docker run -d -p 3000:80 youtube-clone
```

## Kubernetes Deployment

Apply the Kubernetes manifests:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/
```

## Jenkins Pipeline

The repository includes a Jenkinsfile that performs the following steps:

- Checkout the source code
- Install dependencies
- Run tests
- Build the React app
- Build a Docker image
- Scan the image with Trivy
- Push the image to Docker Hub
- Deploy to Kubernetes

## Notes

This repository currently focuses on the frontend application and its deployment assets. It does not include Terraform infrastructure files or an AWS deployment setup.

## License

This project is licensed under the MIT License.
````