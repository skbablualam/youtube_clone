#!/bin/bash

###############################################################################
# Script Name : install-minikube.sh
# Description : Install Docker, kubectl, Minikube, Helm, Prometheus,
#               Grafana and CloudWatch Agent on Ubuntu 22.04
#
# Author      : Bablu Alam
###############################################################################

set -e

echo "=========================================================="
echo "Updating Ubuntu..."
echo "=========================================================="

sudo apt update -y
sudo apt upgrade -y

###############################################################################
# Install Required Packages
###############################################################################

echo "Installing required packages..."

sudo apt install -y \
curl \
wget \
git \
apt-transport-https \
ca-certificates \
gnupg \
lsb-release \
unzip \
conntrack

###############################################################################
# Install Docker
###############################################################################

echo "Installing Docker..."

sudo apt install -y docker.io

sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker ubuntu

docker --version

###############################################################################
# Install kubectl
###############################################################################

echo "Installing kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

kubectl version --client

###############################################################################
# Install Minikube
###############################################################################

echo "Installing Minikube..."

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube version

###############################################################################
# Start Minikube
###############################################################################

echo "Starting Minikube..."

minikube start \
--driver=docker \
--memory=4096 \
--cpus=2

###############################################################################
# Enable Addons
###############################################################################

echo "Enabling Kubernetes Addons..."

minikube addons enable ingress
minikube addons enable metrics-server
minikube addons enable dashboard

###############################################################################
# Install Helm
###############################################################################

echo "Installing Helm..."

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

###############################################################################
# Add Helm Repositories
###############################################################################

helm repo add prometheus-community \
https://prometheus-community.github.io/helm-charts

helm repo add grafana \
https://grafana.github.io/helm