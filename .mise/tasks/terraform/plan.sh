#!/usr/bin/env bash
#MISE description="Create a Terraform execution plan for the specified environment"
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run terraform:plan <environment>"
  echo "Example: mise run terraform:plan dev"
  exit 1
fi

# Init
mise run terraform:init "${ENV}"

# Load environment variables
. "${ROOT_DIR}/.mise/tasks/.private/load-env-vars.sh" "${ENV}"

tf_vars_file="${ROOT_DIR}/provision/${ENV}/${ENV}.tfvars"
# Verify that the environment file exists
if [ ! -f "${tf_vars_file}" ]; then
  echo "Error: Environment file '${tf_vars_file}' not found"
  exit 1
fi

# Plan
terraform \
  -chdir="${TERRAFORM_DIR}" \
    plan \
      -var-file="${tf_vars_file}" \
      -out=terraform.tfplan