#!/bin/bash

###############################################################################
# Script Name : deploy.sh
# Description : Deploy YouTube Clone to Kubernetes (Minikube)
# Author      : Bablu Alam
###############################################################################

set -e

echo "========================================================="
echo " Starting Deployment..."
echo "========================================================="

###############################################################################
# Variables
###############################################################################

NAMESPACE="youtube"

APP_NAME="youtube-clone"

DOCKER_USERNAME="YOUR_DOCKERHUB_USERNAME"

IMAGE_NAME="${DOCKER_USERNAME}/${APP_NAME}"

IMAGE_TAG=${BUILD_NUMBER:-latest}

FULL_IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"

echo ""
echo "Application : ${APP_NAME}"
echo "Namespace   : ${NAMESPACE}"
echo "Image       : ${FULL_IMAGE}"
echo ""

###############################################################################
# Verify Kubernetes Cluster
###############################################################################

echo "Checking Kubernetes Cluster..."

kubectl cluster-info

echo ""
kubectl get nodes

###############################################################################
# Create Namespace
###############################################################################

echo ""
echo "Creating Namespace (if not exists)..."

kubectl apply -f k8s/namespace.yaml

###############################################################################
# Update Deployment Image
###############################################################################

echo ""
echo "Updating Deployment Manifest..."

sed -i "s|IMAGE_NAME|${FULL_IMAGE}|g" k8s/deployment.yaml

###############################################################################
# Deploy Resources
###############################################################################

echo ""
echo "Deploying Kubernetes Resources..."

kubectl apply -f k8s/deployment.yaml

kubectl apply -f k8s/service.yaml

kubectl apply -f k8s/ingress.yaml

###############################################################################
# Wait for Rollout
###############################################################################

echo ""
echo "Waiting for Deployment..."

kubectl rollout status deployment/${APP_NAME} \
-n ${NAMESPACE}

###############################################################################
# Verify Deployment
###############################################################################

echo ""
echo "Pods"

kubectl get pods -n ${NAMESPACE}

echo ""
echo "Services"

kubectl get svc -n ${NAMESPACE}

echo ""
echo "Deployments"

kubectl get deployment -n ${NAMESPACE}

echo ""
echo "Ingress"

kubectl get ingress -n ${NAMESPACE}

###############################################################################
# Deployment Summary
###############################################################################

echo ""
echo "========================================================="
echo " Deployment Completed Successfully"
echo "========================================================="

echo ""
echo "Application Name : ${APP_NAME}"
echo "Namespace        : ${NAMESPACE}"
echo "Docker Image     : ${FULL_IMAGE}"

echo ""
echo "========================================================="