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

echo "Linting Helm charts..."
find "${ROOT_DIR}" -name "Chart.yaml" -exec dirname {} \; | while read -r chart_dir; do
    echo "Linting chart in ${chart_dir}..."
    helm lint "${chart_dir}"
done