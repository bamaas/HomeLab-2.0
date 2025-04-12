#!/usr/bin/env bash
#MISE description="Install Argo CD"
set -e

BOOTSTRAP_DIR="${ROOT_DIR}/bootstrap"
ARGOCD_DIR="${BOOTSTRAP_DIR}/argocd"

if helm list -n argocd | grep -q argocd; then
    echo "Argo CD is already installed."
    echo "Manage ArgoCD via GitOps repository."
    exit 0
fi

echo "Installing Argo CD"
helm repo add argo-cd "$(yq e '.dependencies[0].repository' "${ARGOCD_DIR}/Chart.yaml")"
helm dependency update "${ARGOCD_DIR}"
helm upgrade \
    --install \
    argocd \
    "${ARGOCD_DIR}" \
    --namespace argocd \
    --create-namespace \
    --wait

kubectl apply -f "${BOOTSTRAP_DIR}/bootstrap.yaml"