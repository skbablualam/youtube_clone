#!/bin/bash
set -euo pipefail

CONTAINER_NAME="jenkins-local"
JENKINS_PORT="8080"
AGENT_PORT="50000"
JENKINS_HOME_VOLUME="jenkins_home"
CUSTOM_IMAGE_NAME="my-jenkins-custom"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Stopping existing Jenkins container..."
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
fi

echo "Building custom Jenkins image..."
docker build -t "${CUSTOM_IMAGE_NAME}" -f "${SCRIPT_DIR}/Dockerfile.jenkins" "${SCRIPT_DIR}/.."

echo "Starting Jenkins in Docker..."
docker run -d \
  --name "${CONTAINER_NAME}" \
  --restart unless-stopped \
  -p "${JENKINS_PORT}:8080" \
  -p "${AGENT_PORT}:50000" \
  -v "${JENKINS_HOME_VOLUME}:/var/jenkins_home" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/.kube:/var/jenkins_home/.kube \
  -v ~/.minikube:$HOME/.minikube \
  "${CUSTOM_IMAGE_NAME}"

echo "Jenkins is starting up."