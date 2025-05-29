#!/usr/bin/env bash
#MISE description="Validate Terraform code"
set -e

echo "Validating Terraform code..."
terraform -chdir="${TERRAFORM_DIR}" validate