#!/bin/bash

set -euo pipefail

NAMESPACE="youtube"
APP_NAME="youtube-clone"
IMAGE_TAG="${IMAGE_TAG:-local}"
IMAGE_NAME="${IMAGE_NAME:-${APP_NAME}}"
FULL_IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"

echo "========================================================="
echo "Deploying ${APP_NAME} to local Minikube"
echo "========================================================="

echo "Namespace : ${NAMESPACE}"
echo "Image     : ${FULL_IMAGE}"

echo ""

if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl is required. Install it first." >&2
  exit 1
fi

if ! minikube status >/dev/null 2>&1; then
  echo "Minikube is not running. Start it with: minikube start --driver=docker --memory=4096 --cpus=2" >&2
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker Desktop must be running." >&2
  exit 1
fi

echo "Building Docker image..."
docker build -t "${FULL_IMAGE}" .

echo "Loading image into Minikube..."
minikube image load "${FULL_IMAGE}"

echo "Creating namespace..."
kubectl apply -f k8s/namespace.yaml

echo "Deploying Kubernetes resources..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml >/dev/null 2>&1 || true

echo "Updating deployment image..."
kubectl set image deployment/${APP_NAME} ${APP_NAME}="${FULL_IMAGE}" -n "${NAMESPACE}"

echo "Waiting for rollout..."
kubectl rollout status deployment/${APP_NAME} -n "${NAMESPACE}"

echo ""
echo "Deployment complete."
echo "Run: minikube service ${APP_NAME}-service -n ${NAMESPACE}"
