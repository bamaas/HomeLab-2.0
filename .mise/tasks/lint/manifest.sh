#!/usr/bin/env bash
#MISE description="Build manifests and validate manifests are following the Kubernetes API schema."
set -e
validate_schema="true"
mise run build:kustomization "$1" "${validate_schema}"