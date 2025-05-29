#!/usr/bin/env bash
#MISE description="Lint Helm charts"
set -e

echo "Linting Helm charts..."
find "${ROOT_DIR}" -name "Chart.yaml" -exec dirname {} \; | while read -r chart_dir; do
    echo "Linting chart in ${chart_dir}..."
    helm lint "${chart_dir}"
done
