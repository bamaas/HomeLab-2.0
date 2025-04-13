#!/usr/bin/env bash
#MISE description="Lint the repo"
set -e

echo "Linting YAML files..."
yamllint . -c "${ROOT_DIR}/.lint/yamllint.yaml"

echo "Linting shell scripts..."
# shellcheck disable=SC2046
shellcheck $(find . -name "*.sh" ! -path "./.ignore/*")

echo "Validating Terraform code..."
terraform -chdir="${TERRAFORM_DIR}" validate