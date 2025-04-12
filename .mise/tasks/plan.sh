#!/usr/bin/env bash
#MISE description="Terraform plan"
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run plan <environment>"
  echo "Example: mise run plan dev"
  exit 1
fi

# Verify that the environment file exists
if [ ! -f "${ENV}.tfvars" ]; then
  echo "Error: Environment file '${ENV}.tfvars' not found"
  exit 1
fi

terraform -chdir="${TERRAFORM_DIR}" plan -var-file="${ROOT_DIR}/${ENV}.tfvars" -out=terraform.tfplan