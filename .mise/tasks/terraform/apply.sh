#!/usr/bin/env bash
#MISE description="Terraform apply"
set -e

# Arguments
ENV=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run terraform:apply <environment>"
  echo "Example: mise run terraform:apply dev"
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

# Apply
terraform \
  -chdir="${TERRAFORM_DIR}" \
    apply \
      -var-file="${tf_vars_file}"

  echo "Terraform apply completed for environment: ${ENV}"
