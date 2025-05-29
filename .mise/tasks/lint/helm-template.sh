#!/usr/bin/env bash
#MISE description="Build and template Helm charts for validation"
set -e

echo "Building and templating Helm charts..."
# Build and template Helm charts
find "${ROOT_DIR}/apps" -name "Chart.yaml" -exec dirname {} \; | while read -r chart_dir; do
    if [ -z "$(find "${chart_dir}/charts" -name "*.tgz" 2>/dev/null)" ]; then
        echo "Building dependencies for chart in ${chart_dir}"
        helm dependency build "${chart_dir}" 1>/dev/null
    fi
    namespace=$(echo "${chart_dir}" | rev | cut -d'/' -f2 | rev)
    echo "Templating chart in ${chart_dir}"
    helm secrets template --release-name "${namespace}" -n "${namespace}" "${chart_dir}" -f "${chart_dir}/values.yaml" -f "${chart_dir}/values.enc.yaml" | \
    kubectl apply -f - --dry-run=server 1>/dev/null
done 