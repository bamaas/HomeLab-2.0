#!/usr/bin/env bash
#MISE description="Install Argo CD"
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$ENV" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run bootstrap <environment>"
  echo "Example: mise run bootstrap dev"
  exit 1
fi

# Variables
BOOTSTRAP_DIR="${ROOT_DIR}/bootstrap"
ARGOCD_DIR="${APPS_DIR}/${ENV}/argocd-system/argocd/argocd"

# Check if Argo CD is already installed
if helm list -n argocd | grep -q argocd; then
    echo "Argo CD is already installed."
    echo "Manage ArgoCD via GitOps repository."
    exit 0
fi

# Install Argo CD
echo "Installing Argo CD"
helm repo add argo-cd "$(yq e '.dependencies[0].repository' "${ARGOCD_DIR}/Chart.yaml")"
helm dependency update "${ARGOCD_DIR}"
helm secrets upgrade \
    --install \
    argocd \
    "${ARGOCD_DIR}" \
    --namespace argocd \
    --create-namespace \
    --values "${APPS_DIR}/default/argocd-system/argocd/argocd/values.yaml" \
    --values "${APPS_DIR}/default/argocd-system/argocd/argocd/values.enc.yaml" \
    --values "${ARGOCD_DIR}/values.yaml" \
    --values "${ARGOCD_DIR}/values.enc.yaml" \
    --wait

# Replace ${ENV} placeholder with value
ENV=${ENV} envsubst < "${BOOTSTRAP_DIR}/bootstrap.yaml" |
  kubectl apply -f -
