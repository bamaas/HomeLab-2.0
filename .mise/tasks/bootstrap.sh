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
bootstrap_dir="${ROOT_DIR}/bootstrap"
argocd_dir="${bootstrap_dir}/argocd"

# Check if Argo CD is already installed
if helm list -n argocd | grep -q argocd; then
    echo "Argo CD is already installed."
    echo "Manage ArgoCD via GitOps repository."
    exit 0
fi

# Install Argo CD
echo "Installing Argo CD"
helm repo add argo-cd "$(yq e '.dependencies[0].repository' "${argocd_dir}/Chart.yaml")"
helm dependency update "${argocd_dir}"
helm secrets upgrade \
    --install \
    argocd \
    "${argocd_dir}" \
    --namespace argocd \
    --create-namespace \
    --values "${argocd_dir}/base.values.yaml" \
    --values "${argocd_dir}/values.yaml" \
    --values "${argocd_dir}/values.enc.yaml" \
    --wait

# Replace ${ENV} placeholder with value
ENV=${ENV} envsubst < "${bootstrap_dir}/bootstrap.yaml" |
  kubectl apply -f -
