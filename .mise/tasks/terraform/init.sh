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

# Load environment variables
. "${ROOT_DIR}/.mise/tasks/.private/load-env-vars.sh" "${ENV}"

# Init
terraform \
  -chdir="${TERRAFORM_DIR}" \
    init \
      -reconfigure \
      -backend-config="bucket=${TERRAFORM_BACKEND_S3_BUCKET}" \
      -backend-config="key=${ENV}.terraform.tfstate"

