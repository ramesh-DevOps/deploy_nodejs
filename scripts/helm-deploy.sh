#!/bin/bash
set -e

ACR_NAME=$1
HELM_CHART=$2
IMAGE=$3
NAMESPACE=$4

# Login to ACR
az acr login --name $ACR_NAME

# Add Helm repository
helm repo add my-acr https://$ACR_NAME.azurecr.io/helm/v1/repo
helm repo update

# Install or upgrade Helm chart
helm upgrade --install my-release $HELM_CHART --namespace $NAMESPACE --set image.repository=$IMAGE
