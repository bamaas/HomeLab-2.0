#!/usr/bin/env bash
#MISE description="Install Argo CD"
set -e

# Arguments
env="$1"

# Check if environment variable is provided
if [ -z "$env" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run bootstrap <environment>"
  echo "Example: mise run bootstrap dev"
  exit 1
fi

# Variables
bootstrap_dir="${ROOT_DIR}/bootstrap"
kustomize_dir_path="${ROOT_DIR}/apps/${env}/argocd-system/argocd/argocd/"
namespace=$(basename "$(dirname "${kustomize_dir_path}")")

# # Check if Argo CD is already installed
if kubectl get namespace "${namespace}" >/dev/null 2>&1; then
    echo "Argo CD is already installed."
    echo "Manage ArgoCD via GitOps repository."
    exit 1
fi

# Install Argo CD
echo "Installing Argo CD"
# kubectl create namespace "${namespace}"
mise run build:kustomization "${kustomize_dir_path}" |
  kubectl apply -f -

# Apply ArgoCD bootstrap applicationsets
# Replace ${ENV} placeholder with value
ENV=${env} envsubst < "${bootstrap_dir}/bootstrap.yaml" |
  kubectl apply -f -

printf "\e[32mBootstrap process completed.\e[0m\n"