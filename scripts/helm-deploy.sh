#!/bin/bash
set -e

ACR_NAME="testcon"
HELM_CHART="my-node-app-chart"
IMAGE="my-node-app"
NAMESPACE="default"


# Check if all required arguments are provided
if [ -z "$ACR_NAME" ] || [ -z "$HELM_CHART" ] || [ -z "$IMAGE" ] || [ -z "$NAMESPACE" ]; then
  echo "Usage: $0 <acr-name> <helm-chart-path> <image-name:tag> <namespace>"
  exit 1
fi

# Login to ACR
echo "Logging in to ACR: $ACR_NAME"
az acr login --name $ACR_NAME

# Add Helm repository
echo "Adding Helm repository for ACR"
helm repo add my-acr oci://$ACR_NAME.azurecr.io/helm
helm repo update

# Install or upgrade Helm chart
echo "Deploying Helm chart: $HELM_CHART"
helm upgrade --install my-release $HELM_CHART --namespace $NAMESPACE --set image.repository=$IMAGE

