#!/bin/bash
set -euo pipefail

CONTAINER_NAME="jenkins-local"
JENKINS_PORT="8080"
AGENT_PORT="50000"
JENKINS_HOME_VOLUME="jenkins_home"
CUSTOM_IMAGE_NAME="my-jenkins-custom"

if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Stopping existing Jenkins container..."
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
fi

echo "Building custom Jenkins image..."
docker build -t "${CUSTOM_IMAGE_NAME}" -f scripts/Dockerfile.jenkins .

echo "Starting Jenkins in Docker..."
docker run -d \
  --name "${CONTAINER_NAME}" \
  --restart unless-stopped \
  -p "${JENKINS_PORT}:8080" \
  -p "${AGENT_PORT}:50000" \
  -v "${JENKINS_HOME_VOLUME}:/var/jenkins_home" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  "${CUSTOM_IMAGE_NAME}"

echo "Jenkins is starting up."