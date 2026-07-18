#!/bin/bash

set -euo pipefail

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required. Install Docker Desktop first." >&2
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker Desktop is not running. Start it and rerun this script." >&2
  exit 1
fi

CONTAINER_NAME="jenkins-local"
JENKINS_PORT="8080"
AGENT_PORT="50000"
JENKINS_HOME_VOLUME="jenkins_home"

if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Stopping existing Jenkins container..."
  docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true
fi

docker volume create "${JENKINS_HOME_VOLUME}" >/dev/null

echo "Starting Jenkins in Docker..."
docker run -d \
  --name "${CONTAINER_NAME}" \
  -p "${JENKINS_PORT}:8080" \
  -p "${AGENT_PORT}:50000" \
  -v "${JENKINS_HOME_VOLUME}:/var/jenkins_home" \
  jenkins/jenkins:lts-jdk17

echo "Jenkins is starting up."
echo "Open http://localhost:8080"
echo "Initial admin password:"
docker exec "${CONTAINER_NAME}" cat /var/jenkins_home/secrets/initialAdminPassword
