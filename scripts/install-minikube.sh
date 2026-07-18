#!/bin/bash

set -euo pipefail

if [[ "$OSTYPE" != darwin* ]]; then
  echo "This script is intended for macOS." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it first: https://brew.sh" >&2
  exit 1
fi

echo "Installing Docker, kubectl, minikube and Helm..."
brew install --cask docker kubectl minikube helm >/dev/null 2>&1 || true

open -a Docker >/dev/null 2>&1 || true

echo "Waiting for Docker Desktop to start..."
for _ in {1..30}; do
  if docker info >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

if ! docker info >/dev/null 2>&1; then
  echo "Docker Desktop did not become ready in time. Please start it manually and rerun this script." >&2
  exit 1
fi

echo "Starting Minikube..."
minikube start --driver=docker --memory=4096 --cpus=2
minikube addons enable ingress >/dev/null 2>&1 || true
minikube addons enable metrics-server >/dev/null 2>&1 || true

echo "Minikube is ready."
echo "Run: ./scripts/deploy.sh"
