#!/usr/bin/env bash
#MISE description="Get the kubeconfig file"
set -e

# Arguments
env=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run kubeconfig <environment>"
  echo "Example: mise run kubeconfig dev"
  exit 1
fi

# Init
mise run terraform:init "${env}"

# Load environment variables
. "${ROOT_DIR}/.mise/tasks/.private/load-env-vars.sh" "${env}"

# Get kubeconfig file from Terraform output
echo "Getting kubeconfig file"
terraform \
    -chdir="${TERRAFORM_DIR}" \
        output \
            -raw kubeconfig > .config/kubeconfig

# Set correct permissions for the kubeconfig file
chmod 600 .config/kubeconfig