#!/bin/bash

###############################################################################
# Script Name : rollback.sh
# Description : Rollback Kubernetes Deployment
# Project     : YouTube Clone DevOps Project
# Author      : Bablu Alam
###############################################################################

set -e

NAMESPACE="youtube"
DEPLOYMENT="youtube-clone"

echo "========================================================="
echo " Kubernetes Rollback Utility"
echo "========================================================="

echo ""
echo "Current Rollout History"
echo ""

kubectl rollout history deployment/${DEPLOYMENT} \
-n ${NAMESPACE}

echo ""
read -p "Rollback to previous revision? (y/n): " answer

if [[ "$answer" != "y" ]]; then
    echo ""
    echo "Rollback cancelled."
    exit 0
fi

echo ""
echo "Rolling back deployment..."

kubectl rollout undo deployment/${DEPLOYMENT} \
-n ${NAMESPACE}

echo ""
echo "Waiting for rollout to complete..."

kubectl rollout status deployment/${DEPLOYMENT} \
-n ${NAMESPACE}

echo ""
echo "========================================================="
echo " Rollback Completed Successfully"
echo "========================================================="

echo ""
echo "Deployment"

kubectl get deployment \
-n ${NAMESPACE}

echo ""
echo "Pods"

kubectl get pods \
-n ${NAMESPACE}

echo ""
echo "Services"

kubectl get svc \
-n ${NAMESPACE}

echo ""
echo "========================================================="