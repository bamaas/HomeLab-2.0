#!/usr/bin/env bash
#MISE description="Fetch dependencies for Helm charts, render and optinally validate manifests."
set -e

CHART_DIR=$1

# Optional argument to validate manifests against the Kubernetes API schema
# If not provided, the manifests are not validated
SCHEMA_VALIDATION=$2

# Validate CHART_DIR variable is provided
if [ -z "$CHART_DIR" ]; then
  echo "Error: chart directory not specified"
  echo "Usage: mise run lint:manifest <path_to_chart>"
  exit 1
fi

echo "Fetching dependencies for chart in ${CHART_DIR}"
helm dependency build "${CHART_DIR}" 1>/dev/null

namespace=$(echo "${CHART_DIR}" | rev | cut -d'/' -f2 | rev)

if [ -z "$SCHEMA_VALIDATION" ]; then
  echo "Rendering chart in ${CHART_DIR}."
  helm secrets template --release-name "${namespace}" -n "${namespace}" "${CHART_DIR}" -f "${CHART_DIR}/values.yaml" -f "${CHART_DIR}/values.enc.yaml"
else
  echo "Rendering chart in ${CHART_DIR} and validating manifests."
  helm secrets template --release-name "${namespace}" -n "${namespace}" "${CHART_DIR}" -f "${CHART_DIR}/values.yaml" -f "${CHART_DIR}/values.enc.yaml" | \
    kubeconform -summary -ignore-missing-schemas -summary -strict -kubernetes-version 1.32.0
  echo "Chart in ${CHART_DIR} is valid"
fi