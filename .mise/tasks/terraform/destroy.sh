#!/usr/bin/env bash
#MISE description="Terraform destroy"
#MISE alias="down"
set -e

# Arguments
env=$1

# Check if environment variable is provided
if [ -z "$1" ]; then
  echo "Error: environment not specified"
  echo "Usage: mise run destroy <environment>"
  echo "Example: mise run destroy dev"
  exit 1
fi

# Init
mise run terraform:init "${env}"

# Load environment variables
. "${ROOT_DIR}/.mise/tasks/.private/load-env-vars.sh" "${env}"

tf_vars_file="${ROOT_DIR}/provision/${env}/${env}.tfvars"
# Destroy
terraform \
  -chdir="${TERRAFORM_DIR}" \
    destroy \
      -var-file="${tf_vars_file}"

echo "Cluster teardown complete."