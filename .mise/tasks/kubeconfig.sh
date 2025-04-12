#!/usr/bin/env bash
#MISE description="Get the kubeconfig file"
set -e
echo "Getting kubeconfig file"
terraform -chdir="${TERRAFORM_DIR}" output -raw kubeconfig > .config/kubeconfig
chmod 600 .config/kubeconfig