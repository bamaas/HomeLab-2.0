#!/usr/bin/env bash
#MISE description="Terraform init"
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run terraform:init <environment>"
  echo "Example: mise run terraform:init dev"
  exit 1
fi

# Config
terraform_backend_state_file="${ENV}.terraform.tfstate"

# Load environment variables
. "${ROOT_DIR}/.mise/tasks/.private/load-env-vars.sh" "${ENV}"

# Check if .terraform directory exists and backend is configured for the correct environment
if [ -d "${TERRAFORM_DIR}/.terraform" ] && [ -f "${TERRAFORM_DIR}/.terraform/terraform.tfstate" ]; then
  backend_key_configured=$(jq -r '.backend.config.key // empty' "${TERRAFORM_DIR}/.terraform/terraform.tfstate")
  if [ "${backend_key_configured}" = "${terraform_backend_state_file}" ]; then
    echo "Terraform is already initialized for environment '${ENV}'."
    exit 0
  fi
fi

# Init
terraform \
  -chdir="${TERRAFORM_DIR}" \
    init \
      -reconfigure \
      -backend-config="bucket=${TERRAFORM_BACKEND_S3_BUCKET}" \
      -backend-config="key=${terraform_backend_state_file}"

